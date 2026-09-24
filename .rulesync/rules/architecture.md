---
root: false
targets:
  - "*"
---

# アーキテクチャ

Clean Architecture を意識したレイヤー構成とする。依存の方向は常に UI → Repository → API/外部 の一方向で、内側のレイヤーは外側を知らない。

## レイヤーと責務

| レイヤー | ディレクトリ | 責務 |
| --- | --- | --- |
| Domain | `lib/domain/` | ドメインモデル・enum・ドメインロジック。Flutter や外部 SDK に依存しない |
| Repository | `lib/repository/` | データ取得・永続化の抽象化。外部モデルを Domain モデルへ変換する |
| Data Source | `lib/api/`, `lib/helper/` | API クライアント、Firebase、端末機能などの実装詳細 |
| Presentation (State) | `lib/feature/<feature>/` | 画面ごとの状態管理。Riverpod の Notifier |
| Presentation (UI) | `lib/feature/<feature>/`, `lib/widget/` | Widget。状態の描画とユーザー操作のハンドリングのみ |
| Controller | `lib/controller/` | 複数画面で共有するアプリ横断の状態 |

## Domain

- モデルの class では `freezed_annotation` を使用する。
- 例外は `DomainError` に正規化して扱う。

## Repository

- `abstract class` でインターフェースを定義し、`Impl` で実装する。
- `Provider` で公開する。UI・State からは常に抽象型経由で利用する。
- 外部 API のレスポンスモデルをそのまま外へ出さず、Domain モデルへマッピングする。
- 発生した例外は `DomainError` に変換して throw する。
- 書き込み系（POST/PUT/DELETE）のメソッドは、作成・更新後の Domain モデルを返す。返す値が本当に存在しない場合のみ `bool` などで代替する。

## Presentation

状態管理は Riverpod（`riverpod_annotation`）と FlutterHooks を使用する。非同期データを表示する画面は、お知らせ画面（`lib/feature/announcement/`）のデータフローに揃える。

### データフロー（読み取り）

```
Repository ──fetch()──> AsyncEntityNotifierMixin ──AsyncEntity<T>──> ScreenContainer ──entity──> Widget
     ▲                                                                                              │
     └──────────────────────────── refresh() ◀──────────────────────────────────────────────────────┘
```

### データフロー（書き込み）

```
Widget ──操作──> submit() ──> AsyncActionNotifierMixin.run() ──> Repository
                                        │
                     AsyncEntity<T> ────┴────> ref.listen ──> SnackBar / pop / invalidate
```

### State

- 画面の状態は `lib/feature/<feature>/<feature>_state.dart` に `@riverpod` な Notifier として定義する。
- 非同期に取得するデータは `AsyncEntity<T>` で保持し、`AsyncEntityNotifierMixin<T>` を mixin する。
- `build()` は `initialState()` を返し、`fetch()` に Repository 呼び出しのみを書く。ローディング・エラー・リフレッシュの遷移は mixin に任せ、個別実装しない。
- State から API クライアントや外部 SDK を直接呼ばない。必ず Repository を経由する。

```dart
@riverpod
final class AnnouncementState extends _$AnnouncementState
    with AsyncEntityNotifierMixin<List<Announcement>> {
  @override
  AsyncEntity<List<Announcement>> build() => initialState();

  @override
  Future<List<Announcement>> fetch() =>
      ref.read(announcementRepositoryProvider).getAnnouncements();
}
```

### Action（書き込み）

- POST/PUT/DELETE などの書き込みは `lib/feature/<feature>/<feature>_action.dart` に `@riverpod` な Notifier として定義し、`AsyncActionNotifierMixin<T>` を mixin する。
- `build()` は `initialState()` を返す。読み取りと違い生成時に自動実行せず、画面の操作を起点に公開メソッド（`submit()` など）から `run()` を呼ぶ。
- `run()` が loading / success / failure の遷移と二重送信の防止を担う。個別に try/catch やフラグを書かない。
- Widget から Repository を直接呼ばない。バリデーションは Domain モデルのファクトリか Notifier に置き、Widget から出す。
- 実行中は `isRunning` で送信ボタンを無効化する。書き込みの待機表示は `ScreenContainer` の全面ローディングではなく、ボタン内のインジケーターなど局所的な表示にする。
- 成功後は関連する読み取り State を `ref.invalidate(...)` または `refresh()` して整合を取る。
- 同一画面で続けて実行する場合は `reset()` で未実行の状態へ戻す。

```dart
@riverpod
final class SubjectFeedbackAction extends _$SubjectFeedbackAction
    with AsyncActionNotifierMixin<SubjectFeedback> {
  @override
  AsyncEntity<SubjectFeedback> build() => initialState();

  Future<void> submit({
    required String lessonId,
    required SubjectFeedback feedback,
  }) => run(
    () => ref
        .read(subjectRepositoryProvider)
        .createFeedback(lessonId: lessonId, feedback: feedback),
  );
}
```

### UI

- 画面（`*_screen.dart`）は `Provider` を watch するため `ConsumerWidget` を使う。ローカルな状態（`TextEditingController`、タブ、アニメーションなど）が必要な場合は `HookConsumerWidget` を使う。ローカル状態は Hooks で扱い、Notifier に持たせない。
- 画面から切り出した子 Widget は `StatelessWidget` とし、必要な値とコールバックをコンストラクタで受け取る。子 Widget から `Provider` を直接参照せず、`ref` の読み書きは画面に集約する。
- `Scaffold` の `body` は `ScreenContainer` で包み、`ScreenStates` に画面が依存する `AsyncEntity` を列挙する。読み込み中・エラー表示は `ScreenContainer` に任せ、画面側で個別に組まない。必須でない状態は `optionalStates` に入れる。
- `entity` が `null` のケース（未取得）を描画側で必ず考慮する。
- 再読み込みは `ref.read(...Provider.notifier).refresh()` を呼ぶ。`RefreshIndicator` の `onRefresh` にはこれを渡す。
- SnackBar 表示・`pop`・画面遷移などの副作用は状態の描画ではないため、`build` 内で分岐せず `ref.listen` で状態遷移を購読して一度だけ発火させる。
- Widget にビジネスロジックを書かない。整形は `lib/helper/` のヘルパーや Domain のロジックへ寄せる。
- Widget の class は `final class` とする。

テストの方針は `testing.md` を参照する。

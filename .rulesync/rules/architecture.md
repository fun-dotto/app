---
root: false
targets: ["*"]
globs: ["**/*.dart"]
---

# アーキテクチャ

Clean Architecture をベースとし、状態管理と DI は以下の方針で行う。

| 関心事               | 採用技術                         |
| -------------------- | -------------------------------- |
| レイヤー構成         | Clean Architecture               |
| ローカルな状態管理   | Flutter Hooks (`flutter_hooks`)  |
| グローバルな状態管理 | Riverpod (`riverpod_annotation`) |
| DI                   | Riverpod (`riverpod_annotation`) |

## レイヤー構成

依存は常に外側から内側へ向ける。内側のレイヤーは外側のレイヤーを知ってはならない。

```
Presentation ──▶ Application (UseCase) ──▶ Domain ◀── Data
```

### Domain

- アプリのビジネスルールの中核。最も内側のレイヤー。
- Entity / Value Object は `freezed_annotation` を使用して不変に定義する。
- Repository は抽象 (`abstract interface class`) としてここに定義する。
- Flutter・Riverpod・Firebase・API クライアントなど、外部パッケージに依存しない (Dart 純粋)。
- 複数の UseCase で共有する手続きは Service (`XxxService`) として、Service が扱う複合的なモデルは ServiceModel としてここに定義する。Service は Repository 抽象と他の Domain モデルにのみ依存する。

### Application (UseCase)

- 1 つのユースケースを 1 クラスで表現する。
- Domain の Repository 抽象 (と Service) にのみ依存する。
- UseCase から別の UseCase を呼ばない。共通化が必要な手続きは Domain の Service に切り出す。
- Repository を素通しするだけの処理であっても UseCase を作り、Presentation から Repository を直接呼ばない。
- 複数 Repository を跨ぐ処理やビジネスロジックの手続きはここに置く。
- Widget や `BuildContext` に依存しない。

### Data

- Domain の Repository 抽象を実装する。
- API・Firebase・ローカルストレージなどのデータソースへのアクセスを担う。
- 独自の DTO は定義しない。API クライアント (`dotto_api`) や Firebase などが返す型から Domain モデルへの変換はこのレイヤーで行い、それらの型を外に漏らさない。

### Presentation

- Widget・State (Riverpod の Notifier) で構成する。
- Widget は `HookConsumerWidget` を基本とする。
- UseCase を呼び出して状態を更新し、Repository やデータソースを直接呼ばない。
- `foundation/` の config・flag・logger も Presentation から直接参照せず、Domain の Repository 抽象と UseCase を経由する。

## ディレクトリ構成

レイヤー単位で分割し、Presentation のみ機能単位で分ける。

```
lib/
├── domain/              # Entity, Repository 抽象
├── application/         # UseCase
├── data/                # Repository 実装, DataSource
├── presentation/
│   └── <feature>/       # Screen, Widget, State
├── foundation/          # 設定・ログ・フラグなど共通基盤
├── helper/              # 汎用ユーティリティ (DateFormatter など)
├── extension/           # 標準型・外部パッケージ型の extension
└── router/              # ルーティング
```

- Domain・Application・Data は機能を跨いで共有されるため、機能単位では分けない。
- `presentation/<feature>/` 間の直接参照は避け、共有する Widget は `presentation/` 直下の共通ディレクトリへ切り出す。
- 特定機能のドメインが肥大化した場合や、機能ごとに担当を分ける必要が生じた場合は、feature-first への移行を再検討する。

## ユーティリティ

特定のレイヤーやドメインに属さない汎用処理は `helper/` と `extension/` に置く。

- `helper/` には、状態を持たない純粋な関数・クラスのみを置く。
  - Firebase・API・ストレージなど外部へアクセスするものは Data レイヤー、Provider は該当するレイヤーへ置き、`helper/` に置かない。
- `extension/` には、`String`・`DateTime`・`Iterable` など標準型や外部パッケージの型への extension を置く。ドメインモデルの振る舞いはモデル自身に定義する。
- 同じ処理が 2 箇所以上に現れたら、ユーティリティへの切り出しを検討する。

### 日付整形

- `DateFormat` は各所で直接使わず、`lib/helper/date_formatter.dart` の `DateFormatter` クラスにメソッドとして定義して利用する。

## 状態管理

### ローカルな状態 (Flutter Hooks)

1 つの Widget (とその子) の中で完結する一時的な UI 状態は Flutter Hooks で管理する。

- 例: `TextEditingController`、`AnimationController`、`ScrollController`、タブ選択、展開/折りたたみ、フォームの入力途中の値。
- `useState`、`useTextEditingController`、`useAnimationController`、`useEffect`、`useMemoized` などを使用する。
- `StatefulWidget` は原則使用しない。
- 再利用するロジックはカスタムフック (`useXxx`) として切り出す。
- 画面を離れたら破棄されてよい状態のみを扱う。

### グローバルな状態 (Riverpod)

複数の Widget・画面で共有される状態や、非同期に取得するデータは Riverpod で管理する。

- 例: ログインユーザー、ユーザー設定、API から取得したデータ。
- 状態を変更するものは `Notifier` / `AsyncNotifier` クラスとして定義する。
- 非同期データは `AsyncValue` で扱う。
- アプリ全体で保持すべきもの以外は `keepAlive` を付けず、autoDispose に任せる。

### 使い分けの基準

| 判断基準                             | Hooks    | Riverpod |
| ------------------------------------ | -------- | -------- |
| 他の Widget / 画面と共有するか       | しない   | する     |
| 画面を離れた後も保持するか           | しない   | する     |
| ビジネスロジック・非同期取得を伴うか | 伴わない | 伴う     |
| テストで差し替えたいか               | 不要     | 必要     |

迷った場合は Hooks から始め、共有が必要になった時点で Riverpod へ昇格させる。

### 画面状態クラスを作らない

ドメインデータと UI フラグをまとめた画面専用の状態クラス (`XxxViewState` など) は作らない。

- Notifier はドメインモデル (またはそのコレクション) をそのまま状態として保持する。
- 方向の切り替え・スクロール済みなどの UI フラグは Hooks で管理する。
- 1 画面で複数のデータを扱う場合は、ドメイン概念ごとに Notifier を分ける。
- それでも画面状態クラスが必要に思える場合は、ドメインモデルが実態に即していないサインとして、Domain にモデルを追加・見直す。
- 非同期状態は `AsyncValue` で表し、独自の非同期状態コンテナを作らない。

## DI (Riverpod)

依存関係の注入はすべて Riverpod の Provider で行う。

- Repository 実装・UseCase・DataSource・API クライアントはそれぞれ `@riverpod` 関数として Provider を定義する。
- Repository の Provider は **抽象型を返す** ように定義し、利用側は実装クラスを知らないようにする。
- 依存は `ref.watch` で取得し、コンストラクタ引数として渡す。クラス内部で `ref` を保持しない (Notifier を除く)。
- テストやフレーバー差し替えは `ProviderScope(overrides: [...])` / `ProviderContainer(overrides: [...])` で行う。

```dart
// domain/
abstract interface class SubjectRepository {
  Future<List<Subject>> fetchAll();
}

// data/
@riverpod
SubjectRepository subjectRepository(Ref ref) =>
    SubjectRepositoryImpl(ref.watch(apiClientProvider));

// application/
final class FetchSubjectsUseCase {
  const FetchSubjectsUseCase(this._repository);
  final SubjectRepository _repository;

  Future<List<Subject>> call() => _repository.fetchAll();
}

@riverpod
FetchSubjectsUseCase fetchSubjectsUseCase(Ref ref) =>
    FetchSubjectsUseCase(ref.watch(subjectRepositoryProvider));

// presentation/
@riverpod
final class SubjectListState extends _$SubjectListState {
  @override
  Future<List<Subject>> build() => ref.watch(fetchSubjectsUseCaseProvider)();
}

final class SubjectListScreen extends HookConsumerWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');
    final subjects = ref.watch(subjectListStateProvider);

    return switch (subjects) {
      AsyncData(:final value) => SubjectList(
          subjects: value.where((s) => s.name.contains(query.value)).toList(),
          onQueryChanged: (q) => query.value = q,
        ),
      AsyncError(:final error) => ErrorView(error: error),
      _ => const LoadingView(),
    };
  }
}
```

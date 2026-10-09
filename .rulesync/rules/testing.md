---
root: false
targets: ["*"]
globs: ["**/*_test.dart"]
---

# テスト

古典学派 (デトロイト学派) のスタイルでテストを書く。できるだけ本物の実装を組み合わせ、振る舞いを検証する。

## 基本方針

- テストの単位はクラスではなく「振る舞い」とする。1 つの振る舞いを、関係する本物のクラス群を組み合わせて検証する。
- 実装の詳細 (どのメソッドが何回呼ばれたか) ではなく、観測可能な結果 (戻り値・状態・UI) を検証する。
- リファクタリングで内部構造が変わっても、振る舞いが同じならテストが壊れないようにする。

## テストダブル

- テストダブルを使うのは、プロセス外部への依存 (アプリの境界) に限る。
  - 例: API クライアント (`dotto_api`)、Firebase、ローカルストレージ、プラットフォームチャネル、現在時刻、乱数。
- Domain モデル・UseCase・Repository 実装・State (Notifier) など、アプリ内部のクラスは差し替えずに本物を使う。
- テストダブルはモックよりもフェイク (インメモリ実装などの動く簡易実装) を優先する。
  - フェイクは `test/helpers/` に置き、テスト間で共有する。
- モック (`mockito`) は、外部への送信 (通知送信・ログ送信など) のように、呼び出し自体が観測すべき結果である場合にのみ使い、`verify` による呼び出し検証もその場合に限る。

## レイヤーごとの方針

- Domain: 外部依存がないため、テストダブルを使わずにテストする。
- UseCase: 本物の Repository 実装に、外部依存のフェイクを注入して組み立てる。
- State (Notifier): `ProviderContainer` で外部依存の Provider のみを override し、UseCase・Repository は本物を使う。
- Widget: `ProviderScope(overrides: [...])` で外部依存の Provider のみを override し、画面の振る舞いを検証する。
  - 表示のバリエーション (空・エラー文言・長い文字列など) は、Content に値を直接渡して検証してよい。

```dart
test('科目一覧を取得できる', () async {
  final container = ProviderContainer(
    overrides: [
      // 外部依存のみをフェイクに差し替える
      apiClientProvider.overrideWithValue(FakeApiClient(subjects: [...])),
    ],
  );
  addTearDown(container.dispose);

  final subjects = await container.read(subjectListStateProvider.future);

  expect(subjects, hasLength(2));
});
```

## 書き方

- テスト名は日本語で、検証する振る舞いを記述する。
- Arrange / Act / Assert の順に記述し、1 テストでは 1 つの振る舞いを検証する。
- テスト間で状態を共有せず、各テストは独立して実行できるようにする。

## Widgetbook

Content (`XxxContent`) の見た目は、dotto 用の Widgetbook (`dotto_design_system` の Widgetbook とは別) の Story で網羅し、VRT (Visual Regression Test) の対象とする。

- Content を追加・変更したら、必ず Story を作成・更新する。
- Story は表示が変わり得るパターンを網羅する。
  - 例: 通常、空、要素が 1 件 / 多数、長い文字列、任意項目の有無、選択・無効などの状態ごとの表示。
- Story に渡す値は固定のダミーデータとし、現在時刻・乱数・ネットワークに依存させない (VRT の結果を安定させるため)。
- コールバックは何もしない関数を渡す。
- 1 つの Story では 1 つのパターンだけを表示し、Story 名でそのパターンを表す。

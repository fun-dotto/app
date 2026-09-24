---
root: false
targets:
  - "*"
---

# テスト

古典学派（Detroit / Classical school）のテストスタイルを採る。テストは観測可能な振る舞いを検証し、内部の呼び出し手順には踏み込まない。

- できるだけ実装クラスをそのまま使う。Repository の State テストであっても、Domain モデルやヘルパー、`AsyncEntityNotifierMixin` などの協力オブジェクトは本物を使う。
- テストダブルを差し込むのはプロセス外の依存（HTTP API、Firebase、端末機能、時刻、ランダム）に限る。同一プロセス内のクラスを差し替えるためにダブルを作らない。
- モックライブラリによる自動生成モック（`*.mocks.dart`）は増やさない。必要な場合は、インターフェースを `implements` した手書きの Fake を書き、テストファイル内に置く。
- 検証は状態（戻り値・`AsyncEntity` の `status` / `entity` / `error`）に対して行う。「何回呼ばれたか」「どの順で呼ばれたか」の検証は、それ自体が仕様であるとき（重複リクエストを防ぐ、など）だけに限る。
- Riverpod の State は `ProviderContainer` に対して実際の Notifier を動かし、プロセス外依存の Provider のみ `overrideWithValue` で差し替える。
- Repository の実装は、API クライアントだけを差し替えて `Impl` をそのままテストする。マッピングと `DomainError` への変換が検証対象になる。
- 書き込み系の Notifier は、実行後の `status` / `entity` / `error` と、実行中の再実行が無視されること（二重送信の防止）を検証する。
- Domain のロジックは Flutter に依存しない単体テストとして書く。
- テストの配置は実装のディレクトリ構成に対応させる（`lib/feature/<feature>/` ↔ `test/feature/<feature>/`）。

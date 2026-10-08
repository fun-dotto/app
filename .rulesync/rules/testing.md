---
root: false
targets: ["*"]
globs: ["**/*_test.dart"]
---

# テスト

- Domain・UseCase は Riverpod なしで、Repository のモックを直接コンストラクタに渡してテストする。
- State (Notifier) は `ProviderContainer` で UseCase / Repository の Provider を override してテストする。
- Widget テストは `ProviderScope(overrides: [...])` で依存を差し替える。

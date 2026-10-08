---
root: false
targets: ["*"]
globs: ["**/*"]
---

# コードスタイル

- DRY 原則を遵守する
- SOLID 原則を遵守する
- `very_good_analysis` の警告を残さない。import の書き方や末尾カンマなど、lint・フォーマッタで強制される規則はツールに任せる。

## 命名

- ファイル名は snake_case とし、原則 1 ファイル 1 公開クラスとする。
- クラス名の末尾は役割に応じて統一する。

  | 役割            | 命名                                 |
  | --------------- | ------------------------------------ |
  | Repository 抽象 | `XxxRepository`                      |
  | Repository 実装 | `XxxRepositoryImpl`                  |
  | DataSource      | `XxxDataSource`                      |
  | UseCase         | `XxxUseCase` (`call` メソッドを持つ) |
  | Notifier        | `XxxState`                           |
  | 画面            | `XxxScreen`                          |

- bool 値は `is` / `has` / `can` / `should` で始める。

## クラス

- 継承を想定しないクラスは `final class` とする。
- 抽象 (Repository など) は `abstract interface class` とする。
- フィールドは `final` とし、可能な箇所では `const` を付ける。
- コレクションを外部へ公開する場合は、変更不可な形 (`List.unmodifiable` など) で返す。

## Null 安全・制御構文

- `!` (null assertion) は原則使用せず、`?.`・`??`・パターンマッチで扱う。
- 型や値による分岐は、if-else の連鎖よりも `switch` 式・パターンマッチを優先する。
- 意味を持つ数値・文字列はマジックナンバーとせず、名前付きの定数にする。

## エラー処理

- 例外を握りつぶさない。捕捉した場合は、ログ出力・再送出・UI への反映のいずれかを必ず行う。
- `catch (e)` のみで済ませず、`on XxxException catch (e)` で型を指定する。
- 外部パッケージ由来の例外は Data レイヤーでドメインの例外に変換し、上位レイヤーへ漏らさない。

## Riverpod

- Provider は `riverpod_annotation` の `@riverpod` / `@Riverpod(keepAlive: true)` で定義し、手書きしない。
- `AsyncValue` は `switch` によるパターンマッチで loading / error / data を描き分ける。

## Widget

- Widget を返すメソッド (`Widget _buildXxx()`) ではなく、Widget クラスとして切り出す。
- `build` メソッドが長くなった場合は、意味のある単位で Widget に分割する。
- 色・サイズ・テキストスタイルはデザインシステム (`dotto_design_system`) から、文言は l10n から取得し、直接記述しない。

## コメント

- コメントは日本語で記述する。
- コードを読めば分かること (何をしているか) は書かず、コードから読み取れない意図・理由・制約 (なぜそうしているか) を書く。
- 公開 API (public なクラス・メソッド・Provider など) には、役割が名前から自明でない場合に `///` のドキュメントコメントを付ける。
  - 1 文目で要約し、詳細は空行を挟んで続ける。
  - 識別子は `[ClassName]` のように角括弧で参照する。
- 実装内の補足は `//` を使い、`/* */` は使わない。
- コメントアウトしたコードは残さず削除する (履歴は Git で追える)。
- 一時的な対応や未対応事項は `// TODO(<GitHub ユーザー名>): <内容>` の形式で書き、可能なら Issue へのリンクを添える。
- `// Firebase` のような区切りのためだけのコメントは避け、必要ならメソッドやクラスに切り出す。
- コードを変更したら、関連するコメントも合わせて更新する。

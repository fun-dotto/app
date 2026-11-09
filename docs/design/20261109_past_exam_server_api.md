# 過去問機能のサーバー API 経由への移行(アプリ側設計)

- 日付: 2026-11-09
- 対象: `apps/dotto`(Flutter アプリ)
- 関連: サーバー側設計 `fun-dotto/server` の `docs/design/20261109_past_exam_gcs_signed_url.md`

## 1. 背景と目的

現状、過去問機能はアプリ側だけで完結している。アプリが Cloudflare R2 の認証情報(`--dart-define` で埋め込み)を持ち、`minio` パッケージで直接一覧取得・ダウンロードしている。

| 課題 | 内容 |
|---|---|
| 認証情報の露出 | `EnvironmentConfigs.cloudflareR2*` の鍵がバイナリから抽出できる |
| 認可が UI のみ | 未ログイン時に一覧を出さないのは `SubjectDetailPastExamScreen` の表示制御だけ |
| 二重管理 | 過去問ID を同梱 `assets/syllabus.db` の `過去問` 列から引いており、科目本体は Connect RPC なのに過去問だけ旧来の経路 |

サーバー側が過去問 API を提供する(サーバー側設計を参照)のに合わせ、アプリは App API だけを呼ぶ構成にする。保存先が R2 から GCS に変わってもアプリは影響を受けない。

## 2. 現状

| 層 | 現行 |
|---|---|
| data | `PastExamDataSource` → `S3DataSource.getListObjectsKey`(R2 のプレフィックス一覧)、`PdfDataSource.fetchPastExam`(`getObject`) |
| domain | `PastExamRepository.fetchKeys(String pastExamId)`、`Subject.pastExamId` |
| application | `FetchPastExamsUseCase`、`DownloadPdfUseCase(isPastExam: ...)` |
| presentation | `PastExamsState`、`SubjectDetailPastExamScreen`、`CloudflarePdfViewer` / `WebPdfViewer(isPastExam)` |
| router | `/course/subjects/:id/past-exams/:pastExamId`、`/subjects/:id/past-exams/:pastExamId`(`pastExamId` は実際は PDF のオブジェクトキー) |

## 3. 目標の構成

```
科目詳細(過去問タブ)
  → FetchPastExamsUseCase(subjectId)
    → PastExamRepository.list(subjectId)         … App API ListPastExams
  → タップ → PDF 表示ルート (past_exam_id)
    → DownloadPdfUseCase
      → PastExamRepository.getDownloadUrl(id)    … App API GetPastExamDownloadUrl
      → PdfRepository.download(url)              … 既存の HTTP ダウンロード経路
```

- 署名付き URL の取得は PDF 表示の直前に行う。期限(約 5 分)切れを避けるため、一覧取得時に URL は取得しない。
- ダウンロード本体は、既存の `PdfRepositoryImpl._downloadWeb`(`http.Client`)をそのまま使う。

## 4. ドメイン

```dart
final class PastExam {
  const new({required this.id, required this.subjectId, required this.fileName, required this.createdAt});
  final String id;
  final String subjectId;
  final String fileName;
  final DateTime createdAt;
}

final class PastExamDownloadUrl {
  const new({required this.url, required this.expiresAt});
  final Uri url;
  final DateTime expiresAt;
}

abstract interface class PastExamRepository {
  Future<List<PastExam>> list(String subjectId);
  Future<PastExamDownloadUrl> getDownloadUrl(String pastExamId);
}
```

- `Subject.pastExamId` は削除する(`subject.dart`、`subject_repository_impl.dart:87` の `readPastExamId` 呼び出しも含む)。
- 過去問タブは `Subject.id` を渡して一覧を取得する。

## 5. データ層

- `PastExamRepositoryImpl` は、生成済みの Connect クライアント(`SubjectRepositoryImpl` と同じ `_client` の取得方法)で `PastExamService` を呼ぶ。proto の生成物は `buf.gen.yaml` により取り込む(サーバーの proto 公開に追従)。
- 変換は `fromApi...` 形式の既存のコンバーターに揃える。
- エラーは既存の `mapDomainError` を通す。未認証・期限切れ・存在しない ID を `DomainError` にマップする。
- `PdfRepositoryImpl.download` から `isPastExam` を削除し、URL を渡すだけにする。

## 6. 画面・ルーティング

- `SubjectDetailPastExamScreen` は `pastExamId` の代わりに `subjectId` を受け取り、`PastExam` の一覧を表示する(表示名は `fileName`。`pastExamFileName` は不要になる)。
- 未ログイン時の表示は維持する(サーバー側でも拒否されるが、UX のため事前に出す)。
- ルートの `:pastExamId` は不透明な過去問 ID に変わる(`CourseSubjectPastExamRouteData`、`SubjectPastExamRouteData`)。PDF 画面のタイトル用に、ファイル名は `extra` またはクエリで渡すか、ルート側で再取得する。決めるのは実装時。
- `onPastExamSelected` の引数を、オブジェクトキーから `PastExam`(または ID とファイル名)に変更する(`subject_detail_screen.dart`、`subject_detail_builder.dart`)。
- 新しい PDF ビューア(`PastExamPdfViewer` 相当)は、表示時に `getDownloadUrl` を呼んでから既存のダウンロード処理に渡す。`CloudflarePdfViewer` は名前が実態と合わなくなるため改名または統合する。

## 7. 削除対象

- `lib/data/s3_data_source.dart`、`lib/data/past_exam_data_source.dart`(と `.g.dart`)
- `PdfDataSource.fetchPastExam`、`PdfRepository.download` の `isPastExam` 引数、`DownloadPdfUseCase` / `pdf_document_state.dart` / `web_pdf_viewer.dart` の同引数
- `SubjectDataSource.readPastExamId`(と `syllabus.db` の `過去問` 列への依存)
- `EnvironmentConfigs` の `cloudflareR2Endpoint`、`cloudflareR2AccessKeyId`、`cloudflareR2SecretAccessKey`、`cloudflareR2BucketName`
- ビルド・CI・fastlane の `--dart-define` で渡している R2 関連の値
- `pubspec.yaml` の `minio` 依存

## 8. テスト

- `test/helpers/fake_past_exam_data_source.dart` を、新リポジトリ(またはデータソース)のフェイクに置き換える。
- 更新するもの: `subject_detail_screen_test.dart`、`subject_data_test.dart`、`app_routes_test.dart`、`pdf_document_test.dart`、`fake_pdf_data_source.dart`
- 追加するもの: 一覧取得の成功・空・エラー、署名付き URL 取得失敗(期限切れ・未認証)のウィジェットテスト

## 9. 移行・リリース順序

1. サーバー側(proto・DB・ハンドラー)のリリースと、過去問データの GCS への投入を完了する。
2. アプリ側の proto 生成物を更新し、上記の変更を実装する。
3. アプリをリリースする。
4. 旧バージョンは R2 を直接参照するため、利用が十分に減るまで R2 を残す。R2 の鍵の失効と廃止はサーバー側の手順に従う。

アプリとサーバーのリリースが前後すると過去問が表示できなくなるため、サーバー側が先、アプリが後の順序を守る。

## 10. 未決事項

- PDF 画面のタイトル(ファイル名)の受け渡し方法(`extra` / クエリ / 再取得)
- 署名付き URL の期限切れ時の挙動(エラー表示のみか、自動再取得か)
- 強制アップデートを併用するかどうか(旧アプリ向け R2 の廃止時期とセットで判断)

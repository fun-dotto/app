//
//  Generated code. Do not modify.
//  source: app/v1/article.proto
//

import "package:connectrpc/connect.dart" as connect;
import "article.pb.dart" as appv1article;
import "article.connect.spec.dart" as specs;

/// 記事を提供する。記事の本文は Web の記事ページで表示する。
extension type ArticleServiceClient (connect.Transport _transport) {
  /// 公開中の記事の一覧を、公開日時の新しい順に取得する。
  Future<appv1article.ListArticlesResponse> listArticles(
    appv1article.ListArticlesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ArticleService.listArticles,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}

//
//  Generated code. Do not modify.
//  source: app/v1/article.proto
//

import "package:connectrpc/connect.dart" as connect;
import "article.pb.dart" as appv1article;

/// 記事を提供する。記事の本文は Web の記事ページで表示する。
abstract final class ArticleService {
  /// Fully-qualified name of the ArticleService service.
  static const name = 'app.v1.ArticleService';

  /// 公開中の記事の一覧を、公開日時の新しい順に取得する。
  static const listArticles = connect.Spec(
    '/$name/ListArticles',
    connect.StreamType.unary,
    appv1article.ListArticlesRequest.new,
    appv1article.ListArticlesResponse.new,
  );
}

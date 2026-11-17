// This is a generated file - do not edit.
//
// Generated from app/v1/article.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// 記事。
class Article extends $pb.GeneratedMessage {
  factory Article({
    $core.String? id,
    $core.String? url,
    $core.String? title,
    $0.Timestamp? publishTime,
  }) {
    final result = Article._();
    if (id != null) result.id = id;
    if (url != null) result.url = url;
    if (title != null) result.title = title;
    if (publishTime != null) result.publishTime = publishTime;
    return result;
  }

  Article._();

  factory Article.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Article()..mergeFromBuffer(data, registry);
  factory Article.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Article()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Article',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: Article.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'publishTime',
        subBuilder: $0.Timestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Article clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Article copyWith(void Function(Article) updates) =>
      super.copyWith((message) => updates(message as Article)) as Article;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Article() / Article.new instead')
  static Article create() => Article._();
  static $pb.GeneratedMessage $_createMessage() => Article._();
  @$core.override
  Article createEmptyInstance() => Article._();
  @$core.pragma('dart2js:noInline')
  static Article getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Article>(Article.$_createMessage);
  static Article? _defaultInstance;

  /// ID。microCMS のコンテンツ ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 記事ページの URL。
  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);

  /// タイトル。
  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  /// 公開日時。
  @$pb.TagNumber(4)
  $0.Timestamp get publishTime => $_getN(3);
  @$pb.TagNumber(4)
  set publishTime($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPublishTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublishTime() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensurePublishTime() => $_ensure(3);
}

/// ListArticles の Request。
class ListArticlesRequest extends $pb.GeneratedMessage {
  factory ListArticlesRequest() => ListArticlesRequest._();

  ListArticlesRequest._();

  factory ListArticlesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListArticlesRequest()..mergeFromBuffer(data, registry);
  factory ListArticlesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListArticlesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListArticlesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListArticlesRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListArticlesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListArticlesRequest copyWith(void Function(ListArticlesRequest) updates) =>
      super.copyWith((message) => updates(message as ListArticlesRequest))
          as ListArticlesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListArticlesRequest() / ListArticlesRequest.new instead')
  static ListArticlesRequest create() => ListArticlesRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListArticlesRequest._();
  @$core.override
  ListArticlesRequest createEmptyInstance() => ListArticlesRequest._();
  @$core.pragma('dart2js:noInline')
  static ListArticlesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListArticlesRequest>(
          ListArticlesRequest.$_createMessage);
  static ListArticlesRequest? _defaultInstance;
}

/// ListArticles の Response。
class ListArticlesResponse extends $pb.GeneratedMessage {
  factory ListArticlesResponse({
    $core.Iterable<Article>? articles,
  }) {
    final result = ListArticlesResponse._();
    if (articles != null) result.articles.addAll(articles);
    return result;
  }

  ListArticlesResponse._();

  factory ListArticlesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListArticlesResponse()..mergeFromBuffer(data, registry);
  factory ListArticlesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListArticlesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListArticlesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListArticlesResponse.$_createMessage)
    ..pPM<Article>(1, _omitFieldNames ? '' : 'articles',
        subBuilder: Article.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListArticlesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListArticlesResponse copyWith(void Function(ListArticlesResponse) updates) =>
      super.copyWith((message) => updates(message as ListArticlesResponse))
          as ListArticlesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListArticlesResponse() / ListArticlesResponse.new instead')
  static ListArticlesResponse create() => ListArticlesResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListArticlesResponse._();
  @$core.override
  ListArticlesResponse createEmptyInstance() => ListArticlesResponse._();
  @$core.pragma('dart2js:noInline')
  static ListArticlesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListArticlesResponse>(
          ListArticlesResponse.$_createMessage);
  static ListArticlesResponse? _defaultInstance;

  /// 記事の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<Article> get articles => $_getList(0);
}

/// 記事を提供する。記事の本文は Web の記事ページで表示する。
class ArticleServiceApi {
  final $pb.RpcClient _client;

  ArticleServiceApi(this._client);

  /// 公開中の記事の一覧を、公開日時の新しい順に取得する。
  $async.Future<ListArticlesResponse> listArticles(
          $pb.ClientContext? ctx, ListArticlesRequest request) =>
      _client.invoke<ListArticlesResponse>(ctx, 'ArticleService',
          'ListArticles', request, ListArticlesResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

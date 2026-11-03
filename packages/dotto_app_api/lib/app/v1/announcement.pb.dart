// This is a generated file - do not edit.
//
// Generated from app/v1/announcement.proto.

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

/// おしらせ。
class Announcement extends $pb.GeneratedMessage {
  factory Announcement({
    $core.String? id,
    $core.String? title,
    $core.String? url,
    $0.Timestamp? availableFrom,
  }) {
    final result = Announcement._();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (url != null) result.url = url;
    if (availableFrom != null) result.availableFrom = availableFrom;
    return result;
  }

  Announcement._();

  factory Announcement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Announcement()..mergeFromBuffer(data, registry);
  factory Announcement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Announcement()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Announcement',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: Announcement.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'availableFrom',
        subBuilder: $0.Timestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Announcement clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Announcement copyWith(void Function(Announcement) updates) =>
      super.copyWith((message) => updates(message as Announcement))
          as Announcement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Announcement() / Announcement.new instead')
  static Announcement create() => Announcement._();
  static $pb.GeneratedMessage $_createMessage() => Announcement._();
  @$core.override
  Announcement createEmptyInstance() => Announcement._();
  @$core.pragma('dart2js:noInline')
  static Announcement getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Announcement>(
          Announcement.$_createMessage);
  static Announcement? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// タイトル。
  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  /// リンク先の URL。
  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);

  /// 公開を開始した日時。
  @$pb.TagNumber(4)
  $0.Timestamp get availableFrom => $_getN(3);
  @$pb.TagNumber(4)
  set availableFrom($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAvailableFrom() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvailableFrom() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureAvailableFrom() => $_ensure(3);
}

/// ListAnnouncements の Request。
class ListAnnouncementsRequest extends $pb.GeneratedMessage {
  factory ListAnnouncementsRequest() => ListAnnouncementsRequest._();

  ListAnnouncementsRequest._();

  factory ListAnnouncementsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListAnnouncementsRequest()..mergeFromBuffer(data, registry);
  factory ListAnnouncementsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListAnnouncementsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAnnouncementsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListAnnouncementsRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAnnouncementsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAnnouncementsRequest copyWith(
          void Function(ListAnnouncementsRequest) updates) =>
      super.copyWith((message) => updates(message as ListAnnouncementsRequest))
          as ListAnnouncementsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListAnnouncementsRequest() / ListAnnouncementsRequest.new instead')
  static ListAnnouncementsRequest create() => ListAnnouncementsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListAnnouncementsRequest._();
  @$core.override
  ListAnnouncementsRequest createEmptyInstance() =>
      ListAnnouncementsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListAnnouncementsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAnnouncementsRequest>(
          ListAnnouncementsRequest.$_createMessage);
  static ListAnnouncementsRequest? _defaultInstance;
}

/// ListAnnouncements の Response。
class ListAnnouncementsResponse extends $pb.GeneratedMessage {
  factory ListAnnouncementsResponse({
    $core.Iterable<Announcement>? announcements,
  }) {
    final result = ListAnnouncementsResponse._();
    if (announcements != null) result.announcements.addAll(announcements);
    return result;
  }

  ListAnnouncementsResponse._();

  factory ListAnnouncementsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListAnnouncementsResponse()..mergeFromBuffer(data, registry);
  factory ListAnnouncementsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListAnnouncementsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAnnouncementsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListAnnouncementsResponse.$_createMessage)
    ..pPM<Announcement>(1, _omitFieldNames ? '' : 'announcements',
        subBuilder: Announcement.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAnnouncementsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAnnouncementsResponse copyWith(
          void Function(ListAnnouncementsResponse) updates) =>
      super.copyWith((message) => updates(message as ListAnnouncementsResponse))
          as ListAnnouncementsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListAnnouncementsResponse() / ListAnnouncementsResponse.new instead')
  static ListAnnouncementsResponse create() => ListAnnouncementsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListAnnouncementsResponse._();
  @$core.override
  ListAnnouncementsResponse createEmptyInstance() =>
      ListAnnouncementsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListAnnouncementsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAnnouncementsResponse>(
          ListAnnouncementsResponse.$_createMessage);
  static ListAnnouncementsResponse? _defaultInstance;

  /// おしらせの一覧。
  @$pb.TagNumber(1)
  $pb.PbList<Announcement> get announcements => $_getList(0);
}

/// おしらせを提供する。
class AnnouncementServiceApi {
  final $pb.RpcClient _client;

  AnnouncementServiceApi(this._client);

  /// 公開中のおしらせの一覧を取得する。
  $async.Future<ListAnnouncementsResponse> listAnnouncements(
          $pb.ClientContext? ctx, ListAnnouncementsRequest request) =>
      _client.invoke<ListAnnouncementsResponse>(ctx, 'AnnouncementService',
          'ListAnnouncements', request, ListAnnouncementsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

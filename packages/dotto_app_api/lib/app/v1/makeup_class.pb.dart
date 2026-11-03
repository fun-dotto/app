// This is a generated file - do not edit.
//
// Generated from app/v1/makeup_class.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/type/date.pb.dart' as $1;
import 'common.pbenum.dart' as $2;
import 'subject.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// 補講。
class MakeupClass extends $pb.GeneratedMessage {
  factory MakeupClass({
    $core.String? id,
    $0.Subject? subject,
    $1.Date? date,
    $2.Period? period,
    $core.String? comment,
  }) {
    final result = MakeupClass._();
    if (id != null) result.id = id;
    if (subject != null) result.subject = subject;
    if (date != null) result.date = date;
    if (period != null) result.period = period;
    if (comment != null) result.comment = comment;
    return result;
  }

  MakeupClass._();

  factory MakeupClass.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MakeupClass()..mergeFromBuffer(data, registry);
  factory MakeupClass.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MakeupClass()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MakeupClass',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: MakeupClass.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Subject>(2, _omitFieldNames ? '' : 'subject',
        subBuilder: $0.Subject.$_createMessage)
    ..aOM<$1.Date>(3, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Date.$_createMessage)
    ..aE<$2.Period>(4, _omitFieldNames ? '' : 'period',
        enumValues: $2.Period.values)
    ..aOS(5, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeupClass clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MakeupClass copyWith(void Function(MakeupClass) updates) =>
      super.copyWith((message) => updates(message as MakeupClass))
          as MakeupClass;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MakeupClass() / MakeupClass.new instead')
  static MakeupClass create() => MakeupClass._();
  static $pb.GeneratedMessage $_createMessage() => MakeupClass._();
  @$core.override
  MakeupClass createEmptyInstance() => MakeupClass._();
  @$core.pragma('dart2js:noInline')
  static MakeupClass getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MakeupClass>(
          MakeupClass.$_createMessage);
  static MakeupClass? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 科目。
  @$pb.TagNumber(2)
  $0.Subject get subject => $_getN(1);
  @$pb.TagNumber(2)
  set subject($0.Subject value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubject() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Subject ensureSubject() => $_ensure(1);

  /// 日付。
  @$pb.TagNumber(3)
  $1.Date get date => $_getN(2);
  @$pb.TagNumber(3)
  set date($1.Date value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Date ensureDate() => $_ensure(2);

  /// 時限。
  @$pb.TagNumber(4)
  $2.Period get period => $_getN(3);
  @$pb.TagNumber(4)
  set period($2.Period value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPeriod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriod() => $_clearField(4);

  /// 補足のコメント。
  @$pb.TagNumber(5)
  $core.String get comment => $_getSZ(4);
  @$pb.TagNumber(5)
  set comment($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasComment() => $_has(4);
  @$pb.TagNumber(5)
  void clearComment() => $_clearField(5);
}

/// ListMakeupClasses の Request。
class ListMakeupClassesRequest extends $pb.GeneratedMessage {
  factory ListMakeupClassesRequest({
    $core.Iterable<$core.String>? subjectIds,
    $1.Date? fromDate,
    $1.Date? untilDate,
  }) {
    final result = ListMakeupClassesRequest._();
    if (subjectIds != null) result.subjectIds.addAll(subjectIds);
    if (fromDate != null) result.fromDate = fromDate;
    if (untilDate != null) result.untilDate = untilDate;
    return result;
  }

  ListMakeupClassesRequest._();

  factory ListMakeupClassesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMakeupClassesRequest()..mergeFromBuffer(data, registry);
  factory ListMakeupClassesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMakeupClassesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMakeupClassesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListMakeupClassesRequest.$_createMessage)
    ..pPS(3, _omitFieldNames ? '' : 'subjectIds')
    ..aOM<$1.Date>(4, _omitFieldNames ? '' : 'fromDate',
        subBuilder: $1.Date.$_createMessage)
    ..aOM<$1.Date>(5, _omitFieldNames ? '' : 'untilDate',
        subBuilder: $1.Date.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMakeupClassesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMakeupClassesRequest copyWith(
          void Function(ListMakeupClassesRequest) updates) =>
      super.copyWith((message) => updates(message as ListMakeupClassesRequest))
          as ListMakeupClassesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListMakeupClassesRequest() / ListMakeupClassesRequest.new instead')
  static ListMakeupClassesRequest create() => ListMakeupClassesRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListMakeupClassesRequest._();
  @$core.override
  ListMakeupClassesRequest createEmptyInstance() =>
      ListMakeupClassesRequest._();
  @$core.pragma('dart2js:noInline')
  static ListMakeupClassesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMakeupClassesRequest>(
          ListMakeupClassesRequest.$_createMessage);
  static ListMakeupClassesRequest? _defaultInstance;

  /// 科目IDのリスト。指定した科目の補講のみを取得する。空の場合は全科目を対象とする。
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get subjectIds => $_getList(0);

  /// 検索対象の開始日付。未設定の場合は開始日付で絞り込まない。
  @$pb.TagNumber(4)
  $1.Date get fromDate => $_getN(1);
  @$pb.TagNumber(4)
  set fromDate($1.Date value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFromDate() => $_has(1);
  @$pb.TagNumber(4)
  void clearFromDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Date ensureFromDate() => $_ensure(1);

  /// 検索対象の終了日付。未設定の場合は終了日付で絞り込まない。
  @$pb.TagNumber(5)
  $1.Date get untilDate => $_getN(2);
  @$pb.TagNumber(5)
  set untilDate($1.Date value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasUntilDate() => $_has(2);
  @$pb.TagNumber(5)
  void clearUntilDate() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Date ensureUntilDate() => $_ensure(2);
}

/// ListMakeupClasses の Response。
class ListMakeupClassesResponse extends $pb.GeneratedMessage {
  factory ListMakeupClassesResponse({
    $core.Iterable<MakeupClass>? makeupClasses,
  }) {
    final result = ListMakeupClassesResponse._();
    if (makeupClasses != null) result.makeupClasses.addAll(makeupClasses);
    return result;
  }

  ListMakeupClassesResponse._();

  factory ListMakeupClassesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMakeupClassesResponse()..mergeFromBuffer(data, registry);
  factory ListMakeupClassesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMakeupClassesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMakeupClassesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListMakeupClassesResponse.$_createMessage)
    ..pPM<MakeupClass>(1, _omitFieldNames ? '' : 'makeupClasses',
        subBuilder: MakeupClass.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMakeupClassesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMakeupClassesResponse copyWith(
          void Function(ListMakeupClassesResponse) updates) =>
      super.copyWith((message) => updates(message as ListMakeupClassesResponse))
          as ListMakeupClassesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListMakeupClassesResponse() / ListMakeupClassesResponse.new instead')
  static ListMakeupClassesResponse create() => ListMakeupClassesResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListMakeupClassesResponse._();
  @$core.override
  ListMakeupClassesResponse createEmptyInstance() =>
      ListMakeupClassesResponse._();
  @$core.pragma('dart2js:noInline')
  static ListMakeupClassesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMakeupClassesResponse>(
          ListMakeupClassesResponse.$_createMessage);
  static ListMakeupClassesResponse? _defaultInstance;

  /// 補講の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<MakeupClass> get makeupClasses => $_getList(0);
}

/// 補講を提供する。
class MakeupClassServiceApi {
  final $pb.RpcClient _client;

  MakeupClassServiceApi(this._client);

  /// 補講の一覧を取得する。
  $async.Future<ListMakeupClassesResponse> listMakeupClasses(
          $pb.ClientContext? ctx, ListMakeupClassesRequest request) =>
      _client.invoke<ListMakeupClassesResponse>(ctx, 'MakeupClassService',
          'ListMakeupClasses', request, ListMakeupClassesResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

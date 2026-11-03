// This is a generated file - do not edit.
//
// Generated from app/v1/cancelled_class.proto.

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

/// 休講。
class CancelledClass extends $pb.GeneratedMessage {
  factory CancelledClass({
    $core.String? id,
    $0.Subject? subject,
    $1.Date? date,
    $2.Period? period,
    $core.String? comment,
  }) {
    final result = CancelledClass._();
    if (id != null) result.id = id;
    if (subject != null) result.subject = subject;
    if (date != null) result.date = date;
    if (period != null) result.period = period;
    if (comment != null) result.comment = comment;
    return result;
  }

  CancelledClass._();

  factory CancelledClass.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CancelledClass()..mergeFromBuffer(data, registry);
  factory CancelledClass.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CancelledClass()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelledClass',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: CancelledClass.$_createMessage)
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
  CancelledClass clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelledClass copyWith(void Function(CancelledClass) updates) =>
      super.copyWith((message) => updates(message as CancelledClass))
          as CancelledClass;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CancelledClass() / CancelledClass.new instead')
  static CancelledClass create() => CancelledClass._();
  static $pb.GeneratedMessage $_createMessage() => CancelledClass._();
  @$core.override
  CancelledClass createEmptyInstance() => CancelledClass._();
  @$core.pragma('dart2js:noInline')
  static CancelledClass getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelledClass>(
          CancelledClass.$_createMessage);
  static CancelledClass? _defaultInstance;

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

/// ListCancelledClasses の Request。
class ListCancelledClassesRequest extends $pb.GeneratedMessage {
  factory ListCancelledClassesRequest({
    $core.Iterable<$core.String>? subjectIds,
    $1.Date? fromDate,
    $1.Date? untilDate,
  }) {
    final result = ListCancelledClassesRequest._();
    if (subjectIds != null) result.subjectIds.addAll(subjectIds);
    if (fromDate != null) result.fromDate = fromDate;
    if (untilDate != null) result.untilDate = untilDate;
    return result;
  }

  ListCancelledClassesRequest._();

  factory ListCancelledClassesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCancelledClassesRequest()..mergeFromBuffer(data, registry);
  factory ListCancelledClassesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCancelledClassesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCancelledClassesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListCancelledClassesRequest.$_createMessage)
    ..pPS(3, _omitFieldNames ? '' : 'subjectIds')
    ..aOM<$1.Date>(4, _omitFieldNames ? '' : 'fromDate',
        subBuilder: $1.Date.$_createMessage)
    ..aOM<$1.Date>(5, _omitFieldNames ? '' : 'untilDate',
        subBuilder: $1.Date.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCancelledClassesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCancelledClassesRequest copyWith(
          void Function(ListCancelledClassesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListCancelledClassesRequest))
          as ListCancelledClassesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListCancelledClassesRequest() / ListCancelledClassesRequest.new instead')
  static ListCancelledClassesRequest create() =>
      ListCancelledClassesRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListCancelledClassesRequest._();
  @$core.override
  ListCancelledClassesRequest createEmptyInstance() =>
      ListCancelledClassesRequest._();
  @$core.pragma('dart2js:noInline')
  static ListCancelledClassesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCancelledClassesRequest>(
          ListCancelledClassesRequest.$_createMessage);
  static ListCancelledClassesRequest? _defaultInstance;

  /// 科目IDのリスト。指定した科目の休講のみを取得する。空の場合は全科目を対象とする。
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

/// ListCancelledClasses の Response。
class ListCancelledClassesResponse extends $pb.GeneratedMessage {
  factory ListCancelledClassesResponse({
    $core.Iterable<CancelledClass>? cancelledClasses,
  }) {
    final result = ListCancelledClassesResponse._();
    if (cancelledClasses != null)
      result.cancelledClasses.addAll(cancelledClasses);
    return result;
  }

  ListCancelledClassesResponse._();

  factory ListCancelledClassesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCancelledClassesResponse()..mergeFromBuffer(data, registry);
  factory ListCancelledClassesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCancelledClassesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCancelledClassesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListCancelledClassesResponse.$_createMessage)
    ..pPM<CancelledClass>(1, _omitFieldNames ? '' : 'cancelledClasses',
        subBuilder: CancelledClass.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCancelledClassesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCancelledClassesResponse copyWith(
          void Function(ListCancelledClassesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListCancelledClassesResponse))
          as ListCancelledClassesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListCancelledClassesResponse() / ListCancelledClassesResponse.new instead')
  static ListCancelledClassesResponse create() =>
      ListCancelledClassesResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListCancelledClassesResponse._();
  @$core.override
  ListCancelledClassesResponse createEmptyInstance() =>
      ListCancelledClassesResponse._();
  @$core.pragma('dart2js:noInline')
  static ListCancelledClassesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCancelledClassesResponse>(
          ListCancelledClassesResponse.$_createMessage);
  static ListCancelledClassesResponse? _defaultInstance;

  /// 休講の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<CancelledClass> get cancelledClasses => $_getList(0);
}

/// 休講を提供する。
class CancelledClassServiceApi {
  final $pb.RpcClient _client;

  CancelledClassServiceApi(this._client);

  /// 休講の一覧を取得する。
  $async.Future<ListCancelledClassesResponse> listCancelledClasses(
          $pb.ClientContext? ctx, ListCancelledClassesRequest request) =>
      _client.invoke<ListCancelledClassesResponse>(ctx, 'CancelledClassService',
          'ListCancelledClasses', request, ListCancelledClassesResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

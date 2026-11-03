//
//  Generated code. Do not modify.
//  source: app/v1/subject.proto
//

import "package:connectrpc/connect.dart" as connect;
import "subject.pb.dart" as appv1subject;
import "subject.connect.spec.dart" as specs;

/// 科目を提供する。
extension type SubjectServiceClient (connect.Transport _transport) {
  /// 科目を検索する。同一項目同士は OR、異なる項目同士は AND で絞り込む。
  Future<appv1subject.ListSubjectsResponse> listSubjects(
    appv1subject.ListSubjectsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SubjectService.listSubjects,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// 科目の詳細を取得する。
  Future<appv1subject.GetSubjectResponse> getSubject(
    appv1subject.GetSubjectRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SubjectService.getSubject,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}

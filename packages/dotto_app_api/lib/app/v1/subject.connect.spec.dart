//
//  Generated code. Do not modify.
//  source: app/v1/subject.proto
//

import "package:connectrpc/connect.dart" as connect;
import "subject.pb.dart" as appv1subject;

/// 科目を提供する。
abstract final class SubjectService {
  /// Fully-qualified name of the SubjectService service.
  static const name = 'app.v1.SubjectService';

  /// 科目を検索する。同一項目同士は OR、異なる項目同士は AND で絞り込む。
  static const listSubjects = connect.Spec(
    '/$name/ListSubjects',
    connect.StreamType.unary,
    appv1subject.ListSubjectsRequest.new,
    appv1subject.ListSubjectsResponse.new,
  );

  /// 科目の詳細を取得する。
  static const getSubject = connect.Spec(
    '/$name/GetSubject',
    connect.StreamType.unary,
    appv1subject.GetSubjectRequest.new,
    appv1subject.GetSubjectResponse.new,
  );
}

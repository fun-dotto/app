import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;

/// API の通知内にある科目をドメインに変換する。
SubjectSummary mapNoticeSubject(api.Subject subject) =>
    fromApiSubjectSummary(subject);

int mapNoticePeriod(api.Period period) => switch (period) {
  api.Period.PERIOD_1 => 1,
  api.Period.PERIOD_2 => 2,
  api.Period.PERIOD_3 => 3,
  api.Period.PERIOD_4 => 4,
  api.Period.PERIOD_5 => 5,
  api.Period.PERIOD_6 => 6,
  _ => throw FormatException('Invalid course period: $period'),
};

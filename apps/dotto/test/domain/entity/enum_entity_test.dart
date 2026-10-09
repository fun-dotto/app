import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/cultural_subject_category.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/notification_alert_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_classification.dart';
import 'package:dotto/domain/entity/subject_requirement_type.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AcademicArea', () {
    test('旧ユーザー設定のキーからコースを復元できる', () {
      for (final area in AcademicArea.values) {
        expect(
          AcademicArea.fromDeprecatedUserPreferenceKey(
            area.deprecatedUserPreferenceKey ?? '',
          ),
          area,
        );
      }
    });

    test('未知のキーからはコースを復元しない', () {
      expect(AcademicArea.fromDeprecatedUserPreferenceKey('未知'), isNull);
    });

    test('表示名と旧フィルタのキーがコースごとに異なる', () {
      expect(
        AcademicArea.values.map((e) => e.label).toSet(),
        hasLength(AcademicArea.values.length),
      );
      expect(
        AcademicArea.values.map((e) => e.deprecatedFilterOptionChoiceKey),
        everyElement(endsWith('コース')),
      );
    });
  });

  group('Grade', () {
    test('旧ユーザー設定のキーから学部の学年を復元できる', () {
      expect(Grade.fromDeprecatedUserPreferenceKey('1年'), Grade.b1);
      expect(Grade.fromDeprecatedUserPreferenceKey('4年'), Grade.b4);
    });

    test('未知のキーからは学年を復元しない', () {
      expect(Grade.fromDeprecatedUserPreferenceKey('修士1年'), isNull);
    });
  });

  group('DayOfWeek', () {
    test('番号と曜日を相互に変換できる', () {
      for (final day in DayOfWeek.values) {
        expect(DayOfWeek.fromNumber(day.number), day);
      }
    });

    test('日時から曜日を求める', () {
      // 2024-01-01 は月曜日
      expect(DayOfWeek.fromDateTime(DateTime(2024)), DayOfWeek.monday);
      expect(DayOfWeek.fromDateTime(DateTime(2024, 1, 7)), DayOfWeek.sunday);
    });

    test('平日は月曜から金曜の5日間', () {
      expect(DayOfWeek.weekdays.map((e) => e.label), ['月', '火', '水', '木', '金']);
    });

    test('週末を含む全曜日に1文字の表示名がある', () {
      expect(DayOfWeek.values.map((e) => e.label), everyElement(hasLength(1)));
    });
  });

  group('Period', () {
    test('番号と時限を相互に変換できる', () {
      for (final period in Period.values) {
        expect(Period.fromNumber(period.number), period);
      }
    });
  });

  group('Floor', () {
    test('表示名から階を求める', () {
      expect(Floor.fromLabel('R6'), Floor.sixth);
    });

    test('未知の表示名は1階として扱う', () {
      expect(Floor.fromLabel('B1'), Floor.first);
    });
  });

  group('NotificationAlertStatus', () {
    test('目立つ通知が無効な状態のみ利用者に設定を促す', () {
      final prompted = NotificationAlertStatus.values
          .where((e) => e.shouldPromptUser)
          .toSet();

      expect(prompted, {
        NotificationAlertStatus.denied,
        NotificationAlertStatus.provisional,
        NotificationAlertStatus.alertDisabled,
      });
    });

    test('有効な状態のみ目立つ通知が有効とみなす', () {
      expect(
        NotificationAlertStatus.values.where((e) => e.isProminentEnabled),
        [NotificationAlertStatus.enabled],
      );
    });

    test('状態ごとに異なる表示名を持つ', () {
      expect(
        NotificationAlertStatus.values.map((e) => e.label).toSet(),
        hasLength(NotificationAlertStatus.values.length),
      );
    });
  });

  group('TimetableSemester', () {
    test('前期と後期で通年科目を共有し、それ以外の開講期は重複しない', () {
      final spring = TimetableSemester.spring.semesters.toSet();
      final fall = TimetableSemester.fall.semesters.toSet();

      expect(spring.intersection(fall), {Semester.allYear});
      expect(spring.union(fall), Semester.values.toSet());
    });

    test('旧シラバスDBの学期番号へ変換する', () {
      expect(TimetableSemester.spring.number, 10);
      expect(TimetableSemester.fall.number, 20);
    });

    test('表示名を持つ', () {
      expect(TimetableSemester.values.map((e) => e.label), ['前期', '後期']);
    });
  });

  test('科目の分類に関する列挙値はすべて異なる表示名を持つ', () {
    for (final labels in <List<String>>[
      [for (final e in AcademicClass.values) e.label],
      [for (final e in CulturalSubjectCategory.values) e.label],
      [for (final e in Semester.values) e.label],
      [for (final e in SubjectClassification.values) e.label],
      [for (final e in SubjectRequirementType.values) e.label],
      [for (final e in Grade.values) e.label],
    ]) {
      expect(labels.toSet(), hasLength(labels.length));
    }
  });
}

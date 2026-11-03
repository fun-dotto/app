import 'package:dotto/data/personal_calendar_repository_impl.dart';
import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/personal_calendar_item.pb.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toPeriod', () {
    test('period1 を Period.first にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toPeriod(api.Period.PERIOD_1),
        Period.first,
      );
    });

    test('period2 を Period.second にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toPeriod(api.Period.PERIOD_2),
        Period.second,
      );
    });

    test('period3 を Period.third にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toPeriod(api.Period.PERIOD_3),
        Period.third,
      );
    });

    test('period4 を Period.fourth にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toPeriod(api.Period.PERIOD_4),
        Period.fourth,
      );
    });

    test('period5 を Period.fifth にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toPeriod(api.Period.PERIOD_5),
        Period.fifth,
      );
    });

    test('period6 を Period.sixth にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toPeriod(api.Period.PERIOD_6),
        Period.sixth,
      );
    });
  });

  group('toLectureStatus', () {
    test('cancelled を LectureStatus.cancelled にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toLectureStatus(
          api.PersonalCalendarItem_State.STATE_CANCELLED,
        ),
        LectureStatus.cancelled,
      );
    });

    test('makeup を LectureStatus.madeUp にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toLectureStatus(
          api.PersonalCalendarItem_State.STATE_MAKEUP,
        ),
        LectureStatus.madeUp,
      );
    });

    test('normal を LectureStatus.normal にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toLectureStatus(
          api.PersonalCalendarItem_State.STATE_NORMAL,
        ),
        LectureStatus.normal,
      );
    });

    test('roomChanged を LectureStatus.roomChanged にマッピングする', () {
      expect(
        PersonalCalendarRepositoryImpl.toLectureStatus(
          api.PersonalCalendarItem_State.STATE_ROOM_CHANGED,
        ),
        LectureStatus.roomChanged,
      );
    });
  });
}

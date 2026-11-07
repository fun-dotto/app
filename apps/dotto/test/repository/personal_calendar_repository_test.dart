import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/personal_calendar_repository_impl.dart';
import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/personal_calendar_item.pbenum.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromApiPeriod', () {
    test('PERIOD_1 を Period.first にマッピングする', () {
      expect(fromApiPeriod(api.Period.PERIOD_1), Period.first);
    });

    test('PERIOD_2 を Period.second にマッピングする', () {
      expect(fromApiPeriod(api.Period.PERIOD_2), Period.second);
    });

    test('PERIOD_3 を Period.third にマッピングする', () {
      expect(fromApiPeriod(api.Period.PERIOD_3), Period.third);
    });

    test('PERIOD_4 を Period.fourth にマッピングする', () {
      expect(fromApiPeriod(api.Period.PERIOD_4), Period.fourth);
    });

    test('PERIOD_5 を Period.fifth にマッピングする', () {
      expect(fromApiPeriod(api.Period.PERIOD_5), Period.fifth);
    });

    test('PERIOD_6 を Period.sixth にマッピングする', () {
      expect(fromApiPeriod(api.Period.PERIOD_6), Period.sixth);
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

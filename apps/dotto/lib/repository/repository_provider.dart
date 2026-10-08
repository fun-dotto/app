import 'package:dotto/api/api_client.dart';
import 'package:dotto/helper/firebase_realtime_database_repository.dart';
import 'package:dotto/repository/bus_repository.dart';
import 'package:dotto/repository/fcm_token_repository.dart';
import 'package:dotto/repository/holiday_repository.dart';
import 'package:dotto/repository/personal_calendar_repository.dart';
import 'package:dotto/repository/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:dotto/data/course_registration_repository_impl.dart'
    show courseRegistrationRepositoryProvider;
export 'package:dotto/data/timetable_repository_impl.dart'
    show timetableRepositoryProvider;

final busRepositoryProvider = Provider<BusRepository>(
  (_) => BusRepositoryImpl(FirebaseRealtimeDatabaseRepository()),
);

final holidayRepositoryProvider = Provider<HolidayRepository>(
  (_) => HolidayRepositoryImpl(),
);

final fcmTokenRepositoryProvider = Provider<FCMTokenRepository>(
  FCMTokenRepositoryImpl.new,
);

final roomRepositoryProvider = Provider<RoomRepository>(
  (_) => RoomRepositoryImpl(),
);

final personalCalendarRepositoryProvider = Provider<PersonalCalendarRepository>(
  (ref) {
    final apiClient = ref.watch(apiClientProvider);
    return PersonalCalendarRepositoryImpl(apiClient);
  },
);

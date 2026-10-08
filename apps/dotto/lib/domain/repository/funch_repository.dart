import 'package:dotto/domain/entity/funch_menu.dart';
import 'package:dotto/domain/entity/funch_menu_schedule.dart';

abstract interface class FunchRepository {
  Future<List<FunchMenu>> fetchCommonMenus();
  Future<List<FunchMenu>> fetchOriginalMenus();
  Future<List<FunchMenuSchedule>> fetchSchedules({
    required bool isMonthly,
    required DateTime from,
    required DateTime to,
  });
}

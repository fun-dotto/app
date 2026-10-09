import 'package:dotto/application/fetch_funch_menus_use_case.dart';
import 'package:dotto/domain/entity/funch_daily_menu.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'funch_menus_state.g.dart';

@riverpod
final class FunchMenusState extends _$FunchMenusState {
  @override
  Future<Map<DateTime, FunchDailyMenu>> build({bool isTodayOnly = false}) {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day);
    return ref.watch(fetchFunchMenusUseCaseProvider)(
      from: from,
      to: from.add(Duration(days: isTodayOnly ? 0 : 6)),
    );
  }
}

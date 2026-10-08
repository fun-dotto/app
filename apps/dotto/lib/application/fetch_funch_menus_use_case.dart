import 'package:dotto/data/funch_repository_impl.dart';
import 'package:dotto/domain/entity/funch_daily_menu.dart';
import 'package:dotto/domain/entity/funch_menu.dart';
import 'package:dotto/domain/repository/funch_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fetch_funch_menus_use_case.g.dart';

@riverpod
FetchFunchMenusUseCase fetchFunchMenusUseCase(Ref ref) =>
    FetchFunchMenusUseCase(ref.watch(funchRepositoryProvider));

/// 月次と日次の献立を合わせて、日付ごとのメニューを取得する。
final class FetchFunchMenusUseCase {
  const new(this._repository);
  final FunchRepository _repository;
  Future<Map<DateTime, FunchDailyMenu>> call({
    required DateTime from,
    required DateTime to,
  }) async {
    final common = {
      for (final menu in await _repository.fetchCommonMenus()) menu.id: menu,
    };
    final original = {
      for (final menu in await _repository.fetchOriginalMenus()) menu.id: menu,
    };
    final monthly = {
      for (final schedule in await _repository.fetchSchedules(
        isMonthly: true,
        from: from,
        to: to,
      ))
        DateTime(schedule.date.year, schedule.date.month): schedule,
    };
    final daily = await _repository.fetchSchedules(
      isMonthly: false,
      from: from,
      to: to,
    );
    return Map.unmodifiable({
      for (final schedule in daily)
        DateTime(
          schedule.date.year,
          schedule.date.month,
          schedule.date.day,
        ): FunchDailyMenu(
          menuItems: [
            for (final source in [
              monthly[DateTime(schedule.date.year, schedule.date.month)],
              schedule,
            ])
              if (source != null) ...[
                for (final id in source.commonMenuIds)
                  if (common[id.toString()] case final FunchMenu menu) menu,
                for (final id in source.originalMenuIds)
                  if (original[id] case final FunchMenu menu) menu,
              ],
          ],
        ),
    });
  }
}

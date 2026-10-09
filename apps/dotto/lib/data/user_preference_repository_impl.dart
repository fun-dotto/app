import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/data/shared_preferences_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user_preference.dart';
import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/domain/entity/user_preference_keys.dart';
import 'package:dotto/domain/repository/user_preference_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_preference_repository_impl.g.dart';

@riverpod
UserPreferenceRepository userPreferenceRepository(Ref ref) =>
    UserPreferenceRepositoryImpl(
      ref.watch(sharedPreferencesDataSourceProvider.future),
    );

final class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
  const new(this._preferences);
  final Future<SharedPreferences> _preferences;

  @override
  Future<DottoUserPreference> fetch() async {
    try {
      final preferences = await _preferences;
      final key = preferences.getString(
        UserPreferenceKeys.timetablePeriodStyle.key,
      );
      return DottoUserPreference(
        timetablePeriodStyle:
            TimetablePeriodStyle.fromKey(key ?? '') ??
            TimetablePeriodStyle.numberOnly,
      );
    } on Exception catch (error, stackTrace) {
      throw mapDomainError(e: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> saveTimetablePeriodStyle(TimetablePeriodStyle style) async {
    try {
      final preferences = await _preferences;
      final isSaved = await preferences.setString(
        UserPreferenceKeys.timetablePeriodStyle.key,
        style.key,
      );
      if (!isSaved) {
        throw const DomainError(
          type: DomainErrorType.unknown,
          message: 'Failed to save preferences',
        );
      }
    } on DomainError {
      rethrow;
    } on Exception catch (error, stackTrace) {
      throw mapDomainError(e: error, stackTrace: stackTrace);
    }
  }
}

import 'package:dotto/data/shared_preferences_data_source.dart';
import 'package:dotto/domain/entity/user_preference_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preference_data_source.g.dart';

@riverpod
PreferenceDataSource preferenceDataSource(Ref ref) =>
    PreferenceDataSource(ref.watch(sharedPreferencesDataSourceProvider.future));

final class PreferenceDataSource {
  const new(this._preferences);
  final Future<SharedPreferences> _preferences;
  Future<void> setBool(UserPreferenceKeys key, {required bool value}) async {
    final prefs = await _preferences;
    if (key.type == bool) {
      await prefs.setBool(key.key, value);
    } else {
      throw TypeError();
    }
  }

  Future<bool?> getBool(UserPreferenceKeys key) async {
    final prefs = await _preferences;
    return prefs.getBool(key.key);
  }

  Future<void> setString(UserPreferenceKeys key, String value) async {
    final prefs = await _preferences;
    if (key.type == String) {
      await prefs.setString(key.key, value);
    } else {
      throw TypeError();
    }
  }

  Future<String?> getString(UserPreferenceKeys key) async {
    final prefs = await _preferences;
    return prefs.getString(key.key);
  }

  Future<void> setInt(UserPreferenceKeys key, int value) async {
    final prefs = await _preferences;
    if (key.type == int) {
      await prefs.setInt(key.key, value);
    } else {
      throw TypeError();
    }
  }

  Future<int?> getInt(UserPreferenceKeys key) async {
    final prefs = await _preferences;
    return prefs.getInt(key.key);
  }

  Future<void> remove(UserPreferenceKeys key) async {
    final prefs = await _preferences;
    await prefs.remove(key.key);
  }
}

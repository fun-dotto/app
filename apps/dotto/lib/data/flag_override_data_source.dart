import 'package:dotto/domain/entity/flag.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'flag_override_data_source.g.dart';

@Riverpod(keepAlive: true)
FlagOverrideDataSource flagOverrideDataSource(Ref ref) =>
    const FlagOverrideDataSource();

/// Debug 用の FeatureFlag の上書き値を SharedPreferences へ永続化する。
///
/// 現状は bool 型のフラグのみ対応する。
final class FlagOverrideDataSource {
  const new();

  /// 旧実装 (ConfigNotifier) が使用していた funch 専用のキー。
  static const _legacyIsFunchEnabledOverrideKey = 'isFunchEnabledOverride';

  static String _prefsKey(Flag<Object> flag) => 'flag_override_${flag.key}';

  Future<Map<String, bool>> load(List<Flag<Object>> flags) async {
    final prefs = await SharedPreferences.getInstance();
    await _migrateLegacyKey(prefs);

    return Map.unmodifiable({
      for (final flag in flags)
        if (prefs.getBool(_prefsKey(flag)) case final bool value)
          flag.key: value,
    });
  }

  Future<void> save(Flag<Object> flag, {required bool? value}) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(_prefsKey(flag));
    } else {
      await prefs.setBool(_prefsKey(flag), value);
    }
  }

  Future<void> _migrateLegacyKey(SharedPreferences prefs) async {
    final legacyValue = prefs.getBool(_legacyIsFunchEnabledOverrideKey);
    if (legacyValue == null) return;

    await prefs.setBool(_prefsKey(Flags.funch), legacyValue);
    await prefs.remove(_legacyIsFunchEnabledOverrideKey);
  }
}

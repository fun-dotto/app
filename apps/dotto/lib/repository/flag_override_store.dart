import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/foundation/flag/flags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'flag_override_store.g.dart';

@Riverpod(keepAlive: true)
FlagOverrideStore flagOverrideStore(Ref ref) => const FlagOverrideStore();

/// Debug用のFeatureFlag overrideをSharedPreferencesへ永続化する。
///
/// 現状はbool型のフラグのみ対応する。
final class FlagOverrideStore {
  const FlagOverrideStore();

  /// 旧実装 (ConfigNotifier) が使用していたfunch専用のキー。
  static const _legacyIsFunchEnabledOverrideKey = 'isFunchEnabledOverride';

  static String _prefsKey(Flag<Object> flag) => 'flag_override_${flag.key}';

  /// 保存済みのoverrideをフラグのkeyをキーとするMapで読み込む。
  Future<Map<String, Object?>> load(List<Flag<Object>> flags) async {
    final prefs = await SharedPreferences.getInstance();
    await _migrateLegacyKey(prefs);

    return {
      for (final flag in flags)
        if (prefs.get(_prefsKey(flag)) case final Object value) flag.key: value,
    };
  }

  Future<void> set(Flag<Object> flag, {required bool? value}) async {
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

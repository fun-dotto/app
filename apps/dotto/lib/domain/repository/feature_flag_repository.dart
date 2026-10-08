import 'package:dotto/foundation/flag/flag.dart';

abstract interface class FeatureFlagRepository {
  /// Remote Config に設定された [flag] の値を返す。
  T fetchRemoteValue<T>(Flag<T> flag);

  /// 開発者が上書きしたフラグの値を、フラグの key をキーとして返す。
  Future<Map<String, bool>> fetchOverrides(List<Flag<Object>> flags);

  /// [flag] の上書き値を保存する。`null` を渡すと上書きを解除する。
  Future<void> saveOverride(Flag<bool> flag, {required bool? value});
}

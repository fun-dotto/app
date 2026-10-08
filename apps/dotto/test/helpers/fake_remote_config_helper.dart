import 'package:dotto/helper/remote_config_helper.dart';

/// [values] に設定した値を返す Remote Config のフェイク。
final class FakeRemoteConfigHelper implements RemoteConfigHelper {
  final values = <String, Object?>{};

  @override
  bool getBool(String key) => values[key] as bool? ?? false;

  @override
  double getDouble(String key) => values[key] as double? ?? 0;

  @override
  int getInt(String key) => values[key] as int? ?? 0;

  @override
  Map<String, Object?> getJSON(String key) =>
      values[key] as Map<String, Object?>? ?? <String, Object?>{};

  @override
  String getString(String key) => values[key] as String? ?? '';

  @override
  Future<void> setup() async {}
}

import 'package:dotto/data/remote_config_data_source.dart';

/// [values] に設定した値を返す Remote Config のフェイク。
final class FakeRemoteConfigDataSource implements RemoteConfigDataSource {
  new({this.setupResult, this.activatedValues = const {}});

  final Future<void>? setupResult;
  final Map<String, Object?> activatedValues;
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
  Future<void> setup() async {
    if (setupResult case final result?) await result;
    values.addAll(activatedValues);
  }
}

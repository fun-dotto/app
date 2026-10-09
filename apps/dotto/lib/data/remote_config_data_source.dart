import 'dart:convert';

import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_data_source.g.dart';

@Riverpod(keepAlive: true)
RemoteConfigDataSource remoteConfigDataSource(Ref ref) =>
    _RemoteConfigDataSourceImpl();

abstract interface class RemoteConfigDataSource {
  Future<void> setup();
  bool getBool(String key);
  double getDouble(String key);
  int getInt(String key);
  String getString(String key);
  Map<String, Object?> getJSON(String key);
}

final class _RemoteConfigDataSourceImpl implements RemoteConfigDataSource {
  @override
  Future<void> setup() async {
    if (kDebugMode) {
      await FirebaseRemoteConfig.instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: Duration.zero,
        ),
      );
    } else {
      await FirebaseRemoteConfig.instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
    }

    await FirebaseRemoteConfig.instance.setDefaults({
      for (final flag in Flags.all) flag.key: flag.defaultValue,
      for (final config in RemoteConfigs.all)
        config.key: config.remoteDefaultValue,
    });

    await FirebaseRemoteConfig.instance.fetchAndActivate();
  }

  @override
  bool getBool(String key) {
    return FirebaseRemoteConfig.instance.getBool(key);
  }

  @override
  double getDouble(String key) {
    return FirebaseRemoteConfig.instance.getDouble(key);
  }

  @override
  int getInt(String key) {
    return FirebaseRemoteConfig.instance.getInt(key);
  }

  @override
  String getString(String key) {
    return FirebaseRemoteConfig.instance.getString(key);
  }

  @override
  Map<String, Object?> getJSON(String key) {
    final value = FirebaseRemoteConfig.instance.getString(key);
    if (value.isEmpty) return <String, Object?>{};

    try {
      final decoded = jsonDecode(value);
      if (decoded is Map) {
        return Map<String, Object?>.from(decoded);
      }
    } on FormatException {
      // Fall through to return an empty map.
    }

    return <String, Object?>{};
  }
}

import 'dart:convert';

import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/foundation/flag/flags.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteConfigHelperProvider = Provider<RemoteConfigHelper>(
  (ref) => _RemoteConfigHelperImpl(),
);

abstract class RemoteConfigHelper {
  Future<void> setup();
  bool getBool(String key);
  double getDouble(String key);
  int getInt(String key);
  String getString(String key);
  Map<String, Object?> getJSON(String key);
}

final class _RemoteConfigHelperImpl implements RemoteConfigHelper {
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
      for (final config in RemoteConfigs.all) config.key: config.defaultValue,
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

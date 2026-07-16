import 'package:dotto/foundation/config/config.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/helper/remote_config_helper.dart';
import 'package:dotto/repository/config_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

void main() {
  test('invalidateすると最新のRemote ConfigからConfigを再構築する', () {
    final remoteConfig = FakeRemoteConfigHelper()
      ..values[RemoteConfigs.latestAppVersion.key] = '1.0.0';
    final container = ProviderContainer(
      overrides: [remoteConfigHelperProvider.overrideWithValue(remoteConfig)],
    );
    addTearDown(container.dispose);

    expect(
      container.read(configProvider(RemoteConfigs.latestAppVersion)),
      '1.0.0',
    );

    remoteConfig.values[RemoteConfigs.latestAppVersion.key] = '2.0.0';
    container.invalidate(configRepositoryProvider);

    expect(
      container.read(configProvider(RemoteConfigs.latestAppVersion)),
      '2.0.0',
    );
  });

  test('有効な緊急告知をConfigへ変換する', () {
    final remoteConfig = FakeRemoteConfigHelper()
      ..values[RemoteConfigs.breakingAnnouncement.key] = <String, Object?>{
        'title': 'お知らせ',
        'url': 'https://example.com/announcement',
        'is_external': true,
      };
    final container = ProviderContainer(
      overrides: [remoteConfigHelperProvider.overrideWithValue(remoteConfig)],
    );
    addTearDown(container.dispose);

    final announcement = container.read(
      configProvider(RemoteConfigs.breakingAnnouncement),
    );

    expect(announcement?.title, 'お知らせ');
    expect(announcement?.url, 'https://example.com/announcement');
    expect(announcement?.isExternal, isTrue);
  });
}

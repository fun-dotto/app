import 'package:dotto/data/config_data_source.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/foundation/config/config.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_remote_config_data_source.dart';

void main() {
  test('invalidateすると最新のRemote ConfigからConfigを再構築する', () {
    final remoteConfig = FakeRemoteConfigDataSource()
      ..values[RemoteConfigs.latestAppVersion.key] = '1.0.0';
    final container = ProviderContainer(
      overrides: [
        remoteConfigDataSourceProvider.overrideWithValue(remoteConfig),
      ],
    );
    addTearDown(container.dispose);

    expect(
      container.read(configProvider(RemoteConfigs.latestAppVersion)),
      '1.0.0',
    );

    remoteConfig.values[RemoteConfigs.latestAppVersion.key] = '2.0.0';
    container.invalidate(configDataSourceProvider);

    expect(
      container.read(configProvider(RemoteConfigs.latestAppVersion)),
      '2.0.0',
    );
  });

  test('有効な緊急告知をConfigへ変換する', () {
    final remoteConfig = FakeRemoteConfigDataSource()
      ..values[RemoteConfigs.breakingAnnouncement.key] = <String, Object?>{
        'title': 'お知らせ',
        'url': 'https://example.com/announcement',
        'is_external': true,
      };
    final container = ProviderContainer(
      overrides: [
        remoteConfigDataSourceProvider.overrideWithValue(remoteConfig),
      ],
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

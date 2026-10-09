import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/presentation/common/feature_flag.dart';
import 'package:dotto/presentation/common/flag_override_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_remote_config_data_source.dart';

void main() {
  ProviderContainer createContainer({required bool remoteValue}) {
    final remoteConfig = FakeRemoteConfigDataSource()
      ..values[Flags.funch.key] = remoteValue;
    final container = ProviderContainer(
      overrides: [
        remoteConfigDataSourceProvider.overrideWithValue(remoteConfig),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('上書きがなければRemote Configの値を使う', () async {
    final container = createContainer(remoteValue: true);
    await container.read(flagOverrideStateProvider.notifier).load();

    expect(container.read(featureFlagProvider(Flags.funch)), isTrue);
  });

  test('上書きした値をRemote Configより優先する', () async {
    final container = createContainer(remoteValue: true);

    await container
        .read(flagOverrideStateProvider.notifier)
        .setOverride(Flags.funch, value: false);

    expect(container.read(featureFlagProvider(Flags.funch)), isFalse);
  });

  test('上書きを解除するとRemote Configの値に戻る', () async {
    final container = createContainer(remoteValue: true);
    final notifier = container.read(flagOverrideStateProvider.notifier);
    await notifier.setOverride(Flags.funch, value: false);

    await notifier.setOverride(Flags.funch, value: null);

    expect(container.read(featureFlagProvider(Flags.funch)), isTrue);
  });

  test('保存した上書きを次回起動時に読み込む', () async {
    await createContainer(remoteValue: true)
        .read(flagOverrideStateProvider.notifier)
        .setOverride(Flags.funch, value: false);
    final container = createContainer(remoteValue: true);

    await container.read(flagOverrideStateProvider.notifier).load();

    expect(container.read(featureFlagProvider(Flags.funch)), isFalse);
  });

  test('旧形式のキーで保存された上書きを引き継ぐ', () async {
    SharedPreferences.setMockInitialValues({'isFunchEnabledOverride': false});
    final container = createContainer(remoteValue: true);

    await container.read(flagOverrideStateProvider.notifier).load();

    expect(container.read(featureFlagProvider(Flags.funch)), isFalse);
  });
}

import 'package:dotto/application/fetch_flag_overrides_use_case.dart';
import 'package:dotto/application/fetch_remote_flag_value_use_case.dart';
import 'package:dotto/application/save_flag_override_use_case.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fake_remote_config_data_source.dart';

ProviderContainer _container(FakeRemoteConfigDataSource remoteConfig) {
  final container = ProviderContainer(
    overrides: [remoteConfigDataSourceProvider.overrideWithValue(remoteConfig)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('フラグの値をRemote Configから取得する', () {
    final container = _container(
      FakeRemoteConfigDataSource()..values[Flags.web.key] = true,
    );

    expect(
      container.read(fetchRemoteFlagValueUseCaseProvider)(Flags.web),
      isTrue,
    );
  });

  test('保存した上書き値を取得し、nullを保存すると上書きを解除する', () async {
    final container = _container(FakeRemoteConfigDataSource());
    final save = container.read(saveFlagOverrideUseCaseProvider);
    final fetch = container.read(fetchFlagOverridesUseCaseProvider);

    await save(Flags.funch, value: true);
    await save(Flags.web, value: false);
    expect(await fetch(), {Flags.funch.key: true, Flags.web.key: false});

    await save(Flags.funch, value: null);
    expect(await fetch(), {Flags.web.key: false});
  });

  test('旧形式で保存された学食フラグの上書き値を引き継ぐ', () async {
    SharedPreferences.setMockInitialValues({'isFunchEnabledOverride': true});
    final container = _container(FakeRemoteConfigDataSource());

    expect(await container.read(fetchFlagOverridesUseCaseProvider)(), {
      Flags.funch.key: true,
    });
  });
}

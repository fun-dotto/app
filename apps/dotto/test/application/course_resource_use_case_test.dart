import 'package:dotto/application/fetch_course_resources_use_case.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_remote_config_data_source.dart';

void main() {
  test('講義画面のリンクと資料をRemote Configの値で組み立てる', () {
    final remoteConfig = FakeRemoteConfigDataSource()
      ..values[RemoteConfigs.dottoWebUrl.key] = 'https://example.com/web'
      ..values[RemoteConfigs.opinionBoxUrl.key] = 'https://example.com/box';
    final container = ProviderContainer(
      overrides: [
        remoteConfigDataSourceProvider.overrideWithValue(remoteConfig),
      ],
    );
    addTearDown(container.dispose);

    final resources = container.read(fetchCourseResourcesUseCaseProvider)();

    expect(resources.dottoWebUrl, 'https://example.com/web');
    expect(resources.opinionBoxUrl, 'https://example.com/box');
    expect(resources.breakingAnnouncement, isNull);
  });
}

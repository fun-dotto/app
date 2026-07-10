import 'package:dotto/controller/config_controller.dart';
import 'package:dotto/controller/feature_flag_controller.dart';
import 'package:dotto/foundation/async_entity.dart';
import 'package:dotto/foundation/async_entity_notifier.dart';
import 'package:dotto/helper/logger.dart';
import 'package:dotto/helper/notification_helper.dart';
import 'package:dotto/helper/remote_config_helper.dart';
import 'package:dotto/repository/feature_flag_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root_initialization_state.g.dart';

@riverpod
final class RootInitializationState extends _$RootInitializationState
    with AsyncEntityNotifierMixin<bool> {
  @override
  AsyncEntity<bool> build() => initialState();

  @override
  Future<bool> fetch() async {
    // Setup Remote Config
    await ref.read(remoteConfigHelperProvider).setup();
    // Remote Configのfetch結果をConfigとFeatureFlagへ反映
    ref.read(configProvider.notifier).refresh();
    ref.invalidate(featureFlagRepositoryProvider);
    // Load local debug overrides
    await ref.read(flagOverridesProvider.notifier).loadOverrides();
    // Setup Notification
    await ref.read(notificationHelperProvider).setupInteractedMessage();
    // Setup Logger
    await ref.read(loggerProvider).setup();
    return true;
  }
}

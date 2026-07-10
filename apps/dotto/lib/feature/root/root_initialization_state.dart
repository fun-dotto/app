import 'package:dotto/controller/config_controller.dart';
import 'package:dotto/foundation/async_entity.dart';
import 'package:dotto/foundation/async_entity_notifier.dart';
import 'package:dotto/helper/logger.dart';
import 'package:dotto/helper/notification_helper.dart';
import 'package:dotto/helper/remote_config_helper.dart';
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
    // Load local debug overrides
    await ref.read(configProvider.notifier).loadOverrides();
    // Setup Notification
    await ref.read(notificationHelperProvider).setupInteractedMessage();
    // Setup Logger
    await ref.read(loggerProvider).setup();
    return true;
  }
}

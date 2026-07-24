import 'dart:async';

import 'package:dotto/domain/user_preference_keys.dart';
import 'package:dotto/helper/user_preference_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root_alert_state.freezed.dart';
part 'root_alert_state.g.dart';

@freezed
abstract class RootAlerts with _$RootAlerts {
  const factory RootAlerts({
    @Default(false) bool hasShownUpdateAlert,
    @Default(false) bool hasShownNotificationAlert,
  }) = _RootAlerts;
}

/// アップデートアラート・通知許可アラートの表示済み状態
@riverpod
final class RootAlertState extends _$RootAlertState {
  @override
  RootAlerts build() => const RootAlerts();

  void onUpdateAlertShown() {
    state = state.copyWith(hasShownUpdateAlert: true);
  }

  void markNotificationAlertEvaluated() {
    _markNotificationAlertHandled(persistLastShownAt: false);
  }

  void markNotificationAlertShown() {
    _markNotificationAlertHandled(persistLastShownAt: true);
  }

  void _markNotificationAlertHandled({required bool persistLastShownAt}) {
    state = state.copyWith(hasShownNotificationAlert: true);
    if (!persistLastShownAt || kDebugMode) return;
    unawaited(
      UserPreferenceRepository.setInt(
        UserPreferenceKeys.notificationPromptLastShownAt,
        DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}

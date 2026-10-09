import 'dart:async';

import 'package:dotto/data/url_launcher_helper.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_interaction_data_source.g.dart';

@Riverpod(keepAlive: true)
NotificationInteractionDataSource notificationInteractionDataSource(Ref ref) =>
    NotificationInteractionDataSourceImpl(ref.watch(loggerProvider));

abstract interface class NotificationInteractionDataSource {
  Future<void> setupInteractedMessage();
}

final class NotificationInteractionDataSourceImpl
    implements NotificationInteractionDataSource {
  new(this._logger);
  final Logger _logger;
  bool _isInitialized = false;

  @override
  Future<void> setupInteractedMessage() async {
    if (_isInitialized) return;
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    _isInitialized = true;

    if (initialMessage != null) {
      unawaited(_handleMessage(initialMessage));
    }

    // バックグラウンドから通知を開いた操作も同じ処理へ渡す。
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    final url = message.data['url'];
    if (url case final String url) {
      await launchUrlSafely(url, logger: _logger);
    }
  }
}

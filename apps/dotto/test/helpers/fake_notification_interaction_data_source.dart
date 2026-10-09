import 'package:dotto/data/notification_interaction_data_source.dart';

/// OS 通知のイベント購読を行わない初期化境界。
final class FakeNotificationInteractionDataSource
    implements NotificationInteractionDataSource {
  const new();

  @override
  Future<void> setupInteractedMessage() async {}
}

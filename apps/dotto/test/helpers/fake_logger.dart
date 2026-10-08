import 'package:dotto/foundation/log/analytics_event_key.dart';
import 'package:dotto/foundation/log/logger.dart';

/// 何も送信しないロガー。
final class FakeLogger implements Logger {
  @override
  Future<void> setup() async {}

  @override
  Future<void> logAppOpen() async {}

  @override
  Future<void> logEvent(
    AnalyticsEventKey key, {
    Map<String, Object>? parameters,
  }) async {}

  @override
  Future<void> logLogin() async {}

  @override
  Future<void> logLogout() async {}

  @override
  Future<void> logError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {}
}

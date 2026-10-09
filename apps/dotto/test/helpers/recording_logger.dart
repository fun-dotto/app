import 'package:dotto/foundation/log/analytics_event_key.dart';
import 'package:dotto/foundation/log/logger.dart';

/// 送信したイベントとエラーを記録するロガー。
final class RecordingLogger implements Logger {
  final events = <String>[];
  final errors = <({Object? error, Object? reason})>[];

  @override
  Future<void> setup() async {}

  @override
  Future<void> logAppOpen() async => events.add('app_open');

  @override
  Future<void> logEvent(
    AnalyticsEventKey key, {
    Map<String, Object>? parameters,
  }) async => events.add(key.name);

  @override
  Future<void> logLogin() async => events.add('login');

  @override
  Future<void> logLogout() async => events.add('logout');

  @override
  Future<void> logError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async => errors.add((error: exception, reason: reason));
}

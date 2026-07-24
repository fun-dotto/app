import 'package:dotto/foundation/log/analytics_event_key.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/foundation/log/use_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('useLogger returns the logger from ProviderScope', (
    tester,
  ) async {
    final logger = _FakeLogger();
    Logger? actual;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [loggerProvider.overrideWithValue(logger)],
        child: HookBuilder(
          builder: (context) {
            actual = useLogger();
            return const SizedBox();
          },
        ),
      ),
    );

    expect(actual, same(logger));
  });
}

final class _FakeLogger implements Logger {
  @override
  Future<void> logAppOpen() async {}

  @override
  Future<void> logError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {}

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
  Future<void> setup() async {}
}

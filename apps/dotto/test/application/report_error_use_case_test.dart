import 'package:dotto/application/report_error_use_case.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/recording_logger.dart';

void main() {
  test('エラーを理由とともに送信する', () async {
    final logger = RecordingLogger();
    final container = ProviderContainer(
      overrides: [loggerProvider.overrideWithValue(logger)],
    );
    addTearDown(container.dispose);
    final error = StateError('broken');

    await container.read(reportErrorUseCaseProvider)(
      error,
      StackTrace.empty,
      reason: '初期化に失敗',
    );

    expect(logger.errors, [(error: error, reason: '初期化に失敗')]);
  });
}

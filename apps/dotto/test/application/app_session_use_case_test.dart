import 'package:dotto/application/complete_tutorial_use_case.dart';
import 'package:dotto/application/fetch_tutorial_completion_use_case.dart';
import 'package:dotto/application/record_notification_prompt_use_case.dart';
import 'package:dotto/application/should_prompt_notification_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProviderContainer _container() {
  SharedPreferences.setMockInitialValues({});
  final container = ProviderContainer();
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('チュートリアルは完了するまで未完了として扱う', () async {
    final container = _container();
    final fetch = container.read(fetchTutorialCompletionUseCaseProvider);
    expect(await fetch(), isFalse);

    await container.read(completeTutorialUseCaseProvider)();

    expect(await fetch(), isTrue);
  });

  test('デバッグビルドでは表示を記録しても通知案内を毎回表示する', () async {
    // 案内の確認を容易にするため、デバッグビルドでは表示間隔を設けない
    final container = _container();

    await container.read(recordNotificationPromptUseCaseProvider)();

    expect(
      await container.read(shouldPromptNotificationUseCaseProvider)(),
      isTrue,
    );
  });
}

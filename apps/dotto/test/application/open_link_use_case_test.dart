import 'package:dotto/application/open_course_link_use_case.dart';
import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/domain/entity/course_link_event.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_url_launcher.dart';
import '../helpers/recording_logger.dart';

ProviderContainer _container(RecordingLogger logger) {
  final container = ProviderContainer(
    overrides: [loggerProvider.overrideWithValue(logger)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('外部リンクを開く', () async {
    final launcher = FakeUrlLauncher()..install(addTearDown);
    final container = _container(RecordingLogger());

    final isOpened = await container.read(openExternalLinkUseCaseProvider)(
      'https://example.com',
      shouldOpenExternally: true,
    );

    expect(isOpened, isTrue);
    expect(launcher.openedUrls, ['https://example.com']);
  });

  test('開けない外部リンクは開けなかったことを返す', () async {
    final launcher = FakeUrlLauncher(canOpen: false)..install(addTearDown);
    final container = _container(RecordingLogger());

    final isOpened = await container.read(openExternalLinkUseCaseProvider)(
      'https://example.com',
    );

    expect(isOpened, isFalse);
    expect(launcher.openedUrls, isEmpty);
  });

  test('講義画面のリンクを開き、どのリンクかを記録する', () async {
    final launcher = FakeUrlLauncher()..install(addTearDown);
    final logger = RecordingLogger();
    final container = _container(logger);

    await container.read(openCourseLinkUseCaseProvider)(
      'https://example.com/box',
      event: CourseLinkEvent.opinionBox,
    );

    expect(launcher.openedUrls, ['https://example.com/box']);
    expect(logger.events, ['opinionBoxButtonTapped']);
  });
}

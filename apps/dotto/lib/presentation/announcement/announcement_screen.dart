import 'dart:async';

import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/presentation/announcement/announcement_content.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class AnnouncementScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcements = ref.watch(announcementStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: switch (announcements) {
        AsyncData(:final value) => AnnouncementContent(
          announcements: value,
          onRefresh: ref.read(announcementStateProvider.notifier).refresh,
          onAnnouncementTap: (announcement) => unawaited(
            ref.read(openExternalLinkUseCaseProvider)(announcement.url),
          ),
        ),
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}

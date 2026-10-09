import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/presentation/announcement/announcement_detail_content.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// お知らせの詳細画面。
final class AnnouncementDetailScreen extends HookConsumerWidget {
  const new({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcements = ref.watch(announcementStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: switch (announcements) {
        AsyncData(:final value) => switch (value.firstWhereOrNull(
          (announcement) => announcement.id == id,
        )) {
          final Announcement announcement => AnnouncementDetailContent(
            announcement: announcement,
            onOpen: () => unawaited(
              ref.read(openExternalLinkUseCaseProvider)(announcement.url),
            ),
          ),
          null => const Center(child: Text('お知らせが見つかりませんでした。')),
        },
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotto/domain/announcement.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/helper/url_launcher_helper.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// お知らせの詳細画面。
///
/// お知らせ本文は外部ページで配信されているため、この画面では概要を表示し、
/// 本文はブラウザで開く。
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
          final Announcement announcement => _AnnouncementDetail(
            announcement: announcement,
          ),
          null => const Center(child: Text('お知らせが見つかりませんでした。')),
        },
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}

final class _AnnouncementDetail extends StatelessWidget {
  const new({required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            announcement.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            DateFormatter.full(announcement.date),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 8),
          DottoButton(
            onPressed: () => unawaited(launchUrlSafely(announcement.url)),
            child: const Text('お知らせを開く'),
          ),
        ],
      ),
    );
  }
}

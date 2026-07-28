import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotto/domain/announcement.dart';
import 'package:dotto/feature/announcement/announcement_state.dart';
import 'package:dotto/foundation/container/screen_container.dart';
import 'package:dotto/foundation/container/screen_states.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/helper/url_launcher_helper.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// お知らせの詳細画面。
///
/// お知らせ本文は外部ページで配信されているため、この画面では概要を表示し、
/// 本文はブラウザで開く。
final class AnnouncementDetailScreen extends ConsumerWidget {
  const AnnouncementDetailScreen({required this.id, super.key});

  final String id;

  Widget _body(BuildContext context, Announcement announcement) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcements = ref.watch(announcementStateProvider);
    final entity = announcements.entity;
    final announcement = entity?.firstWhereOrNull(
      (announcement) => announcement.id == id,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: ScreenContainer(
        states: ScreenStates(states: [announcements]),
        child: () {
          if (entity == null) {
            return const SizedBox.shrink();
          }
          if (announcement == null) {
            return const Center(child: Text('お知らせが見つかりませんでした。'));
          }
          return _body(context, announcement);
        }(),
      ),
    );
  }
}

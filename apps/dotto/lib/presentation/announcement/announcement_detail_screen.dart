import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// お知らせの詳細画面。
///
/// お知らせ本文は外部ページで配信されているため、この画面では概要を表示し、
/// 本文はブラウザで開く。
final class AnnouncementDetailScreen extends HookConsumerWidget {
  const new({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useLocalization();
    final announcements = ref.watch(announcementStateProvider);

    return Scaffold(
      appBar: DottoAppBar(title: Text(l10n.announcementTitle)),
      body: switch (announcements) {
        AsyncData(:final value) => switch (value.firstWhereOrNull(
          (announcement) => announcement.id == id,
        )) {
          final Announcement announcement => _AnnouncementDetail(
            announcement: announcement,
          ),
          null => Center(child: Text(l10n.announcementNotFound)),
        },
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}

final class _AnnouncementDetail extends HookConsumerWidget {
  const new({required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useLocalization();
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
            DateFormatter.full(
              announcement.date,
              locale: Localizations.localeOf(context).toString(),
            ),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 8),
          DottoButton(
            onPressed: () => unawaited(
              ref.read(openExternalLinkUseCaseProvider)(announcement.url),
            ),
            child: Text(l10n.announcementOpen),
          ),
        ],
      ),
    );
  }
}

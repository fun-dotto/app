import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:material_ui/material_ui.dart';

/// お知らせの概要の表示。
///
/// お知らせ本文は外部ページで配信されているため、本文は [onOpen] でブラウザで開く。
final class AnnouncementDetailContent extends StatelessWidget {
  const new({required this.announcement, required this.onOpen, super.key});

  final Announcement announcement;
  final VoidCallback onOpen;

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
            DateFormatter.full(
              announcement.date,
              locale: Localizations.localeOf(context).toString(),
            ),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 8),
          DottoButton(onPressed: onOpen, child: const Text('お知らせを開く')),
        ],
      ),
    );
  }
}

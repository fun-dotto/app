import 'package:dotto/domain/announcement.dart';
import 'package:dotto/feature/announcement/announcement_state.dart';
import 'package:dotto/foundation/screen_container.dart';
import 'package:dotto/foundation/screen_states.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/helper/url_launcher_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AnnouncementScreen extends ConsumerWidget {
  const AnnouncementScreen({super.key});

  Widget _announcementListRow(BuildContext context, Announcement announcement) {
    return ListTile(
      title: Text(
        announcement.title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        DateFormatter.full(announcement.date),
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onTap: () => launchUrlSafely(announcement.url),
      trailing: const Icon(Icons.chevron_right_outlined),
    );
  }

  Widget _body(
    BuildContext context,
    List<Announcement>? announcements, {
    required Future<void> Function() onRefresh,
  }) {
    if (announcements == null) {
      return const SizedBox();
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        itemCount: announcements.length,
        separatorBuilder: (_, _) => const Divider(height: 0),
        itemBuilder: (_, index) {
          final announcement = announcements[index];
          return _announcementListRow(context, announcement);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcements = ref.watch(announcementStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('お知らせ')),
      body: ScreenContainer(
        states: ScreenStates(states: [announcements]),
        child: _body(
          context,
          announcements.entity,
          onRefresh: () async {
            await ref.read(announcementStateProvider.notifier).refresh();
          },
        ),
      ),
    );
  }
}

import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class AnnouncementListTile extends HookConsumerWidget {
  const new({required this.announcement, super.key});

  final Announcement announcement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        announcement.title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        DateFormatter.full(
          announcement.date,
          locale: Localizations.localeOf(context).toString(),
        ),
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onTap: () => ref.read(openExternalLinkUseCaseProvider)(announcement.url),
      trailing: const Icon(Icons.chevron_right_outlined),
    );
  }
}

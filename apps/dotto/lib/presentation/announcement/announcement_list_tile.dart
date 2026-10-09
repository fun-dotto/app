import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:material_ui/material_ui.dart';

final class AnnouncementListTile extends StatelessWidget {
  const new({required this.announcement, required this.onTap, super.key});

  final Announcement announcement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right_outlined),
    );
  }
}

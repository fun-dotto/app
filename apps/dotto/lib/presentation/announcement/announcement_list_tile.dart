import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/helper/url_launcher_helper.dart';
import 'package:flutter/material.dart';

final class AnnouncementListTile extends StatelessWidget {
  const new({required this.announcement, super.key});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
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
}

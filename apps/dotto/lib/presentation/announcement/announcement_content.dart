import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/presentation/announcement/announcement_list_tile.dart';
import 'package:material_ui/material_ui.dart';

/// お知らせ一覧の表示。
final class AnnouncementContent extends StatelessWidget {
  const new({
    required this.announcements,
    required this.onRefresh,
    required this.onAnnouncementTap,
    super.key,
  });

  final List<Announcement> announcements;
  final RefreshCallback onRefresh;
  final ValueChanged<Announcement> onAnnouncementTap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        itemCount: announcements.length,
        separatorBuilder: (_, _) => const Divider(height: 0),
        itemBuilder: (_, index) => AnnouncementListTile(
          announcement: announcements[index],
          onTap: () => onAnnouncementTap(announcements[index]),
        ),
      ),
    );
  }
}

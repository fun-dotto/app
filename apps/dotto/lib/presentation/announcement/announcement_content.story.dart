import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/presentation/announcement/announcement_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _announcements = [
  Announcement(
    id: '1',
    title: '新年度のお知らせ',
    date: DateTime(2026, 4),
    url: 'https://example.com/1',
  ),
  Announcement(
    id: '2',
    title: 'とても長いタイトルのお知らせです。折り返して表示されることを確認するために十分な長さの文字列を入れています。',
    date: DateTime(2026, 3, 15),
    url: 'https://example.com/2',
  ),
  Announcement(
    id: '3',
    title: 'メンテナンスのお知らせ',
    date: DateTime(2026, 2, 28),
    url: 'https://example.com/3',
  ),
];

@widgetbook.UseCase(name: 'Default', type: AnnouncementContent)
Widget announcementContentDefault(BuildContext context) => AnnouncementContent(
  announcements: _announcements,
  onRefresh: () async {},
  onAnnouncementTap: (_) {},
);

@widgetbook.UseCase(name: 'Empty', type: AnnouncementContent)
Widget announcementContentEmpty(BuildContext context) => AnnouncementContent(
  announcements: const [],
  onRefresh: () async {},
  onAnnouncementTap: (_) {},
);

import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/presentation/announcement/announcement_detail_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AnnouncementDetailContent)
Widget announcementDetailContentDefault(BuildContext context) =>
    AnnouncementDetailContent(
      announcement: Announcement(
        id: '1',
        title: '新年度のお知らせ',
        date: DateTime(2026, 4),
        url: 'https://example.com/1',
      ),
      onOpen: () {},
    );

@widgetbook.UseCase(name: 'Long title', type: AnnouncementDetailContent)
Widget announcementDetailContentLongTitle(BuildContext context) =>
    AnnouncementDetailContent(
      announcement: Announcement(
        id: '2',
        title: 'とても長いタイトルのお知らせです。折り返して表示されることを確認するために十分な長さの文字列を入れています。',
        date: DateTime(2026, 3, 15),
        url: 'https://example.com/2',
      ),
      onOpen: () {},
    );

//
//  Generated code. Do not modify.
//  source: app/v1/announcement.proto
//

import "package:connectrpc/connect.dart" as connect;
import "announcement.pb.dart" as appv1announcement;

/// おしらせを提供する。
abstract final class AnnouncementService {
  /// Fully-qualified name of the AnnouncementService service.
  static const name = 'app.v1.AnnouncementService';

  /// 公開中のおしらせの一覧を取得する。
  static const listAnnouncements = connect.Spec(
    '/$name/ListAnnouncements',
    connect.StreamType.unary,
    appv1announcement.ListAnnouncementsRequest.new,
    appv1announcement.ListAnnouncementsResponse.new,
  );
}

//
//  Generated code. Do not modify.
//  source: app/v1/announcement.proto
//

import "package:connectrpc/connect.dart" as connect;
import "announcement.pb.dart" as appv1announcement;
import "announcement.connect.spec.dart" as specs;

/// おしらせを提供する。
extension type AnnouncementServiceClient (connect.Transport _transport) {
  /// 公開中のおしらせの一覧を取得する。
  Future<appv1announcement.ListAnnouncementsResponse> listAnnouncements(
    appv1announcement.ListAnnouncementsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.AnnouncementService.listAnnouncements,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}

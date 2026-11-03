//
//  Generated code. Do not modify.
//  source: app/v1/reservation.proto
//

import "package:connectrpc/connect.dart" as connect;
import "reservation.pb.dart" as appv1reservation;

/// 教室の予約を提供する。
abstract final class ReservationService {
  /// Fully-qualified name of the ReservationService service.
  static const name = 'app.v1.ReservationService';

  /// 教室の予約の一覧を取得する。検索対象期間に一部でも重複する予約を取得する。
  static const listReservations = connect.Spec(
    '/$name/ListReservations',
    connect.StreamType.unary,
    appv1reservation.ListReservationsRequest.new,
    appv1reservation.ListReservationsResponse.new,
  );
}

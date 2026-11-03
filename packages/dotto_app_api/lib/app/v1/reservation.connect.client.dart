//
//  Generated code. Do not modify.
//  source: app/v1/reservation.proto
//

import "package:connectrpc/connect.dart" as connect;
import "reservation.pb.dart" as appv1reservation;
import "reservation.connect.spec.dart" as specs;

/// 教室の予約を提供する。
extension type ReservationServiceClient (connect.Transport _transport) {
  /// 教室の予約の一覧を取得する。検索対象期間に一部でも重複する予約を取得する。
  Future<appv1reservation.ListReservationsResponse> listReservations(
    appv1reservation.ListReservationsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ReservationService.listReservations,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}

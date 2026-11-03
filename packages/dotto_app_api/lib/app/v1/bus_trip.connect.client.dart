//
//  Generated code. Do not modify.
//  source: app/v1/bus_trip.proto
//

import "package:connectrpc/connect.dart" as connect;
import "bus_trip.pb.dart" as appv1bus_trip;
import "bus_trip.connect.spec.dart" as specs;

/// バスの運行情報を提供する。
extension type BusTripServiceClient (connect.Transport _transport) {
  /// バスの運行情報の一覧を取得する。
  Future<appv1bus_trip.ListBusTripsResponse> listBusTrips(
    appv1bus_trip.ListBusTripsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.BusTripService.listBusTrips,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}

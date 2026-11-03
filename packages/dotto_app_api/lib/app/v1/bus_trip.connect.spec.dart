//
//  Generated code. Do not modify.
//  source: app/v1/bus_trip.proto
//

import "package:connectrpc/connect.dart" as connect;
import "bus_trip.pb.dart" as appv1bus_trip;

/// バスの運行情報を提供する。
abstract final class BusTripService {
  /// Fully-qualified name of the BusTripService service.
  static const name = 'app.v1.BusTripService';

  /// バスの運行情報の一覧を取得する。
  static const listBusTrips = connect.Spec(
    '/$name/ListBusTrips',
    connect.StreamType.unary,
    appv1bus_trip.ListBusTripsRequest.new,
    appv1bus_trip.ListBusTripsResponse.new,
  );
}

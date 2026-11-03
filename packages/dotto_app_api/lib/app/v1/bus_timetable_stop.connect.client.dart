//
//  Generated code. Do not modify.
//  source: app/v1/bus_timetable_stop.proto
//

import "package:connectrpc/connect.dart" as connect;
import "bus_timetable_stop.pb.dart" as appv1bus_timetable_stop;
import "bus_timetable_stop.connect.spec.dart" as specs;

/// バスの停車情報を提供する。
extension type BusTimetableStopServiceClient (connect.Transport _transport) {
  /// 運行ごとのバスの停車情報の一覧を取得する。
  Future<appv1bus_timetable_stop.ListBusTimetableStopsResponse> listBusTimetableStops(
    appv1bus_timetable_stop.ListBusTimetableStopsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.BusTimetableStopService.listBusTimetableStops,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}

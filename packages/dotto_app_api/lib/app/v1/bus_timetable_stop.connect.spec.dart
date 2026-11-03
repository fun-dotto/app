//
//  Generated code. Do not modify.
//  source: app/v1/bus_timetable_stop.proto
//

import "package:connectrpc/connect.dart" as connect;
import "bus_timetable_stop.pb.dart" as appv1bus_timetable_stop;

/// バスの停車情報を提供する。
abstract final class BusTimetableStopService {
  /// Fully-qualified name of the BusTimetableStopService service.
  static const name = 'app.v1.BusTimetableStopService';

  /// 運行ごとのバスの停車情報の一覧を取得する。
  static const listBusTimetableStops = connect.Spec(
    '/$name/ListBusTimetableStops',
    connect.StreamType.unary,
    appv1bus_timetable_stop.ListBusTimetableStopsRequest.new,
    appv1bus_timetable_stop.ListBusTimetableStopsResponse.new,
  );
}

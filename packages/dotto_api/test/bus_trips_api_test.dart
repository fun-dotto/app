import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for BusTripsApi
void main() {
  final instance = Openapi().getBusTripsApi();

  group(BusTripsApi, () {
    // バスの運行情報を取得する
    //
    //Future<BusTripsV1List200Response> busTripsV1List(Date date) async
    test('test busTripsV1List', () async {
      // TODO
    });

  });
}

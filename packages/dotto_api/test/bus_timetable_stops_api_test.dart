import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for BusTimetableStopsApi
void main() {
  final instance = Openapi().getBusTimetableStopsApi();

  group(BusTimetableStopsApi, () {
    // バスの停車情報を取得する
    //
    //Future<BusTimetableStopsV1List200Response> busTimetableStopsV1List(String tripId) async
    test('test busTimetableStopsV1List', () async {
      // TODO
    });

  });
}

import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/data/room_data_source.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/imdf.dart';
import 'package:dotto/presentation/map/map_screen.dart';
import 'package:dotto/presentation/map/widget/map.dart';
import 'package:dotto/presentation/map/widget/map_floor_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_room_data_source.dart';
import '../../helpers/fun_map_for_test.dart';

const _rooms = {
  '3': {
    '301': {'header': '情報工房', 'classroom_no': '301'},
  },
  '4': {
    '406': {'header': '講義室', 'classroom_no': '406'},
  },
};

Future<void> _pumpMap(WidgetTester tester, {String? focusedRoomId}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        roomDataSourceProvider.overrideWithValue(
          const FakeRoomDataSource(rooms: _rooms),
        ),
        authDataSourceProvider.overrideWithValue(FakeAuthDataSource()),
        funMapProvider.overrideWith((ref) async => loadFunMapForTest()),
        imdfProvider.overrideWith((ref) async => loadImdfForTest()),
      ],
      child: MaterialApp(
        home: MapScreen(
          focusedRoomId: focusedRoomId,
          onGoToSettingButtonTapped: () {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('部屋を指定して開くと該当階と詳細を表示する', (tester) async {
    await _pumpMap(tester, focusedRoomId: '406');

    expect(
      tester.widget<MapFloorButton>(find.byType(MapFloorButton)).selectedFloor,
      Floor.fourth,
    );
    expect(find.text('講義室'), findsOneWidget);
    expect(find.text('設定に移動する'), findsOneWidget);
  });

  testWidgets('階を変更すると選択をリセットする', (tester) async {
    await _pumpMap(tester, focusedRoomId: '406');

    tester
        .widget<MapFloorButton>(find.byType(MapFloorButton))
        .onPressed(Floor.third);
    await tester.pumpAndSettle();

    final changed = tester.widget<Map>(find.byType(Map));
    expect(changed.selectedFloor, Floor.third);
    expect(changed.focusedMapTileProps, isNull);
    expect(find.text('設定に移動する'), findsNothing);
  });

  testWidgets('検索結果の部屋を選ぶとその階の詳細を表示する', (tester) async {
    await _pumpMap(tester);
    await tester.tap(find.byType(SearchBar));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '講義');
    await tester.pumpAndSettle();

    await tester.tap(find.text('講義室'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MapFloorButton>(find.byType(MapFloorButton)).selectedFloor,
      Floor.fourth,
    );
    expect(find.text('講義室'), findsOneWidget);
    expect(find.text('設定に移動する'), findsOneWidget);
  });
}

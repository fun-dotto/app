import 'package:dotto/data/funch_data_source.dart';
import 'package:dotto/presentation/common/funch/funch_menus_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_funch_data_source.dart';

void main() {
  test('ホーム用の献立は本日だけ取得し画面用は七日間取得する', () async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final outside = today.add(const Duration(days: 7));
    final container = ProviderContainer(
      overrides: [
        funchDataSourceProvider.overrideWithValue(
          FakeFunchDataSource(days: [today, tomorrow, outside]),
        ),
      ],
    );
    addTearDown(container.dispose);
    final home = await container.read(
      funchMenusStateProvider(isTodayOnly: true).future,
    );
    final screen = await container.read(funchMenusStateProvider().future);
    expect(home.keys, [today]);
    expect(screen.keys, [today, tomorrow]);
  });
}

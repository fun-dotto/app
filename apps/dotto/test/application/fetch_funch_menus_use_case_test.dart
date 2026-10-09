import 'package:dotto/application/fetch_funch_menus_use_case.dart';
import 'package:dotto/data/funch_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/funch_menu_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_funch_data_source.dart';

void main() {
  test('月を跨ぐ献立に各月の月次メニューと日次メニューを合わせる', () async {
    final from = DateTime(2026, 10, 31);
    final to = DateTime(2026, 11);
    final container = ProviderContainer(
      overrides: [
        funchDataSourceProvider.overrideWithValue(
          FakeFunchDataSource(days: [from, to]),
        ),
      ],
    );
    addTearDown(container.dispose);
    final menus = await container.read(fetchFunchMenusUseCaseProvider)(
      from: from,
      to: to,
    );
    expect(menus.keys, [from, to]);
    for (final menu in menus.values) {
      expect(menu.menuItems.map((item) => item.name), [
        '月次メニュー',
        '日次メニュー',
        'オリジナル',
      ]);
      expect(
        menu.getMenuByCategory(FunchMenuCategory.noodle).single.prices.large,
        400,
      );
      expect(() => menu.menuItems.clear(), throwsUnsupportedError);
    }
    expect(menus.clear, throwsUnsupportedError);
  });
  test('キャッシュの読み取りエラーをドメインのエラーとして通知する', () async {
    final from = DateTime(2026, 10, 8);
    final container = ProviderContainer(
      overrides: [
        funchDataSourceProvider.overrideWithValue(
          FakeFunchDataSource(days: [from], shouldFail: true),
        ),
      ],
    );
    addTearDown(container.dispose);
    await expectLater(
      container.read(fetchFunchMenusUseCaseProvider)(from: from, to: from),
      throwsA(isA<DomainError>()),
    );
  });
}

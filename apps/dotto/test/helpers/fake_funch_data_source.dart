import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotto/data/funch_data_source.dart';

final class FakeFunchDataSource implements FunchDataSource {
  new({required this.days, this.shouldFail = false});
  final List<DateTime> days;
  final bool shouldFail;
  @override
  Future<List<dynamic>> readCommonMenus() async {
    if (shouldFail) throw const FormatException('invalid JSON');
    return [
      {
        'item_code': 1,
        'title': '月次メニュー',
        'category': 1,
        'price': {'medium': 400},
        'image': '',
        'energy': 500,
      },
      {
        'item_code': 2,
        'title': '日次メニュー',
        'category': 11,
        'price': {'medium': 300, 'large': 400},
        'image': '',
        'energy': 200,
      },
    ];
  }

  @override
  Future<Map<String, Map<String, dynamic>>> readOriginalMenus() async => {
    'original': {
      'name': 'オリジナル',
      'category_id': 3,
      'prices': {'medium': 100},
    },
  };
  @override
  Future<List<Map<String, dynamic>>> readSchedules({
    required bool isMonthly,
    required DateTime from,
    required DateTime to,
  }) async => [
    if (isMonthly)
      for (final month
          in days.map((day) => DateTime(day.year, day.month)).toSet())
        {
          'date': Timestamp.fromDate(month),
          'common_menu_ids': [1],
          'original_menu_ids': <String>[],
        }
    else
      for (final day in days.where(
        (day) => !day.isBefore(from) && !day.isAfter(to),
      ))
        {
          'date': Timestamp.fromDate(day),
          'common_menu_ids': [2, 999],
          'original_menu_ids': ['original', 'missing'],
        },
  ];
}

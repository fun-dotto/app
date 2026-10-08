import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotto/helper/file_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'funch_data_source.g.dart';

@riverpod
FunchDataSource funchDataSource(Ref ref) =>
    FunchDataSource(FirebaseFirestore.instance);

/// 学食のローカルキャッシュと Firestore へのアクセスを担う。
class FunchDataSource {
  const new(this._firestore);
  final FirebaseFirestore _firestore;
  Future<List<dynamic>> readCommonMenus() =>
      FileHelper.getJSONData('funch/menu.json');
  Future<Map<String, Map<String, dynamic>>> readOriginalMenus() async {
    final snapshot = await _firestore.collection('funch_original_menu').get();
    return {for (final doc in snapshot.docs) doc.id: doc.data()};
  }

  Future<List<Map<String, dynamic>>> readSchedules({
    required bool isMonthly,
    required DateTime from,
    required DateTime to,
  }) async {
    final start = isMonthly
        ? DateTime(from.year, from.month)
        : DateTime(from.year, from.month, from.day);
    final end = isMonthly
        ? DateTime(to.year, to.month + 1)
        : DateTime(to.year, to.month, to.day + 1);
    final snapshot = await _firestore
        .collection(isMonthly ? 'funch_monthly_menu' : 'funch_daily_menu')
        .where('date', isGreaterThanOrEqualTo: start)
        .where('date', isLessThan: end)
        .get();
    return [for (final doc in snapshot.docs) doc.data()];
  }
}

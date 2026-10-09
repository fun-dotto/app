import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotto/data/funch_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/funch_menu.dart';
import 'package:dotto/domain/entity/funch_menu_schedule.dart';
import 'package:dotto/domain/entity/funch_price.dart';
import 'package:dotto/domain/repository/funch_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'funch_repository_impl.g.dart';

@riverpod
FunchRepository funchRepository(Ref ref) =>
    FunchRepositoryImpl(ref.watch(funchDataSourceProvider));

final class FunchRepositoryImpl implements FunchRepository {
  const new(this._source);
  final FunchDataSource _source;
  Future<T> _convertErrors<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
      // キャッシュと Firestore の型不整合を上位に漏らさない。
      // ignore: avoid_catching_errors
    } on TypeError catch (e, stackTrace) {
      throw DomainError(
        type: DomainErrorType.invalidResponse,
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  FunchPrice _price(Map<String, dynamic> value) => FunchPrice(
    medium: value['medium'] as int,
    large: value['large'] as int?,
    small: value['small'] as int?,
  );
  @override
  Future<List<FunchMenu>> fetchCommonMenus() => _convertErrors(
    () async => List.unmodifiable(
      (await _source.readCommonMenus()).map((value) {
        final item = value as Map<String, dynamic>;
        return FunchMenu(
          id: item['item_code'].toString(),
          name: item['title'] as String,
          categoryId: item['category'] as int,
          prices: _price(item['price'] as Map<String, dynamic>),
          imageUrl: item['image'] as String,
          energy: item['energy'] as int,
        );
      }),
    ),
  );
  @override
  Future<List<FunchMenu>> fetchOriginalMenus() => _convertErrors(
    () async => List.unmodifiable(
      (await _source.readOriginalMenus()).entries.map((entry) {
        final item = entry.value;
        return FunchMenu(
          id: entry.key,
          name: item['name'] as String,
          categoryId: item['category_id'] as int,
          prices: _price(item['prices'] as Map<String, dynamic>),
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/swift2023groupc.appspot.com/o/funch%2Fimages%2F${entry.key}.webp?alt=media',
        );
      }),
    ),
  );
  @override
  Future<List<FunchMenuSchedule>> fetchSchedules({
    required bool isMonthly,
    required DateTime from,
    required DateTime to,
  }) => _convertErrors(
    () async => List.unmodifiable(
      (await _source.readSchedules(
        isMonthly: isMonthly,
        from: from,
        to: to,
      )).map(
        (item) => FunchMenuSchedule(
          date: (item['date'] as Timestamp).toDate(),
          commonMenuIds: List<int>.from(item['common_menu_ids'] as List),
          originalMenuIds: List<String>.from(item['original_menu_ids'] as List),
        ),
      ),
    ),
  );
}

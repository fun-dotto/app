import 'package:dotto/domain/entity/funch_price.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'funch_menu.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: true)
abstract class FunchMenu with _$FunchMenu {
  const factory({
    required String id,
    required String name,
    required int categoryId,
    required FunchPrice prices,
    required String imageUrl,
    int? energy,
  }) = _FunchMenu;
}

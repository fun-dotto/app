import 'package:dotto/domain/entity/menu_size.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_price.freezed.dart';

@freezed
abstract class Price with _$Price {
  const factory({required Size size, required int price}) = _Price;
}

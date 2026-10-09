import 'package:freezed_annotation/freezed_annotation.dart';
part 'funch_price.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: true)
abstract class FunchPrice with _$FunchPrice {
  const factory({required int medium, int? large, int? small}) = _FunchPrice;
}

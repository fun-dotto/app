import 'package:dotto/application/fetch_campus_map_use_case.dart';
import 'package:dotto/domain/entity/campus_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_map_state.g.dart';

@riverpod
final class CampusMapState extends _$CampusMapState {
  @override
  Future<CampusMap> build() => ref.watch(fetchCampusMapUseCaseProvider)();
}

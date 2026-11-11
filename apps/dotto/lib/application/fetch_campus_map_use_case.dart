import 'package:dotto/data/campus_map_repository_impl.dart';
import 'package:dotto/domain/entity/campus_map.dart';
import 'package:dotto/domain/repository/campus_map_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_campus_map_use_case.g.dart';

@riverpod
FetchCampusMapUseCase fetchCampusMapUseCase(Ref ref) =>
    FetchCampusMapUseCase(ref.watch(campusMapRepositoryProvider));

final class FetchCampusMapUseCase {
  const new(this._repository);
  final CampusMapRepository _repository;

  Future<CampusMap> call() => _repository.getCampusMap();
}

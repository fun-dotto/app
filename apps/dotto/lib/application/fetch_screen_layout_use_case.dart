import 'package:dotto/data/screen_layout_repository_impl.dart';
import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/repository/screen_layout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_screen_layout_use_case.g.dart';

final class FetchScreenLayoutUseCase {
  const new(this._repository);
  final ScreenLayoutRepository _repository;
  Future<ScreenLayout> call() => _repository.fetch();
}

@riverpod
FetchScreenLayoutUseCase fetchScreenLayoutUseCase(Ref ref) =>
    FetchScreenLayoutUseCase(ref.watch(screenLayoutRepositoryProvider));

import 'package:dotto/data/app_initialization_repository_impl.dart';
import 'package:dotto/domain/repository/app_initialization_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'initialize_app_use_case.g.dart';

final class InitializeAppUseCase {
  const new(this._repository);
  final AppInitializationRepository _repository;
  Future<void> call() => _repository.initialize();
}

@riverpod
InitializeAppUseCase initializeAppUseCase(Ref ref) =>
    InitializeAppUseCase(ref.watch(appInitializationRepositoryProvider));

import 'package:dotto/data/app_version_repository_impl.dart';
import 'package:dotto/domain/entity/app_version_status.dart';
import 'package:dotto/domain/repository/app_version_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_app_version_use_case.g.dart';

final class FetchAppVersionUseCase {
  const new(this._repository);
  final AppVersionRepository _repository;
  Future<AppVersionStatus> call() => _repository.fetch();
}

@riverpod
FetchAppVersionUseCase fetchAppVersionUseCase(Ref ref) =>
    FetchAppVersionUseCase(ref.watch(appVersionRepositoryProvider));

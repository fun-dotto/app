import 'package:dotto/data/app_build_info_repository_impl.dart';
import 'package:dotto/domain/entity/app_build_info.dart';
import 'package:dotto/domain/repository/app_build_info_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_app_build_info_use_case.g.dart';

final class FetchAppBuildInfoUseCase {
  const new(this._repository);

  final AppBuildInfoRepository _repository;

  Future<AppBuildInfo> call() => _repository.fetch();
}

@riverpod
FetchAppBuildInfoUseCase fetchAppBuildInfoUseCase(Ref ref) =>
    FetchAppBuildInfoUseCase(ref.watch(appBuildInfoRepositoryProvider));

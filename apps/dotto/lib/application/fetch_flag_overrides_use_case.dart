import 'package:dotto/data/feature_flag_repository_impl.dart';
import 'package:dotto/domain/repository/feature_flag_repository.dart';
import 'package:dotto/foundation/flag/flags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_flag_overrides_use_case.g.dart';

final class FetchFlagOverridesUseCase {
  const new(this._repository);

  final FeatureFlagRepository _repository;

  Future<Map<String, bool>> call() => _repository.fetchOverrides(Flags.all);
}

@riverpod
FetchFlagOverridesUseCase fetchFlagOverridesUseCase(Ref ref) =>
    FetchFlagOverridesUseCase(ref.watch(featureFlagRepositoryProvider));

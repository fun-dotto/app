import 'package:dotto/data/feature_flag_repository_impl.dart';
import 'package:dotto/domain/repository/feature_flag_repository.dart';
import 'package:dotto/foundation/flag/flag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_remote_flag_value_use_case.g.dart';

final class FetchRemoteFlagValueUseCase {
  const new(this._repository);

  final FeatureFlagRepository _repository;

  T call<T>(Flag<T> flag) => _repository.fetchRemoteValue(flag);
}

@riverpod
FetchRemoteFlagValueUseCase fetchRemoteFlagValueUseCase(Ref ref) =>
    FetchRemoteFlagValueUseCase(ref.watch(featureFlagRepositoryProvider));

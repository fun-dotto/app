import 'package:dotto/data/feature_flag_repository_impl.dart';
import 'package:dotto/domain/repository/feature_flag_repository.dart';
import 'package:dotto/foundation/flag/flag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_flag_override_use_case.g.dart';

final class SaveFlagOverrideUseCase {
  const new(this._repository);

  final FeatureFlagRepository _repository;

  Future<void> call(Flag<bool> flag, {required bool? value}) =>
      _repository.saveOverride(flag, value: value);
}

@riverpod
SaveFlagOverrideUseCase saveFlagOverrideUseCase(Ref ref) =>
    SaveFlagOverrideUseCase(ref.watch(featureFlagRepositoryProvider));

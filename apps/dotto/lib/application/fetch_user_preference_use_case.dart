import 'package:dotto/data/user_preference_repository_impl.dart';
import 'package:dotto/domain/entity/dotto_user_preference.dart';
import 'package:dotto/domain/repository/user_preference_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_user_preference_use_case.g.dart';

@riverpod
FetchUserPreferenceUseCase fetchUserPreferenceUseCase(Ref ref) =>
    FetchUserPreferenceUseCase(ref.watch(userPreferenceRepositoryProvider));

final class FetchUserPreferenceUseCase {
  const new(this._repository);
  final UserPreferenceRepository _repository;
  Future<DottoUserPreference> call() => _repository.fetch();
}

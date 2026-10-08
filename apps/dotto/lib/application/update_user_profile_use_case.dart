import 'package:dotto/data/user_repository_impl.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_profile_use_case.g.dart';

final class UpdateUserProfileUseCase {
  const new(this._repository);

  final UserRepository _repository;

  Future<DottoUser> call(DottoUser user) => _repository.save(user);
}

@riverpod
UpdateUserProfileUseCase updateUserProfileUseCase(Ref ref) =>
    UpdateUserProfileUseCase(ref.watch(userRepositoryProvider));

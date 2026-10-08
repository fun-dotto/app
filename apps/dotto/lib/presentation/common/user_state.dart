import 'package:dotto/application/fetch_current_user_use_case.dart';
import 'package:dotto/application/sign_in_use_case.dart';
import 'package:dotto/application/sign_out_use_case.dart';
import 'package:dotto/application/update_user_profile_use_case.dart';
import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/presentation/common/auth_account_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state.g.dart';

/// ログイン中のユーザー。未ログインの場合は `null`。
@Riverpod(keepAlive: true)
final class UserState extends _$UserState {
  @override
  Future<DottoUser?> build() async {
    final account = await ref.watch(authAccountStateProvider.future);
    if (account == null) {
      return null;
    }
    return await ref.watch(fetchCurrentUserUseCaseProvider)(account);
  }

  /// ログインする。
  ///
  /// 成功時はログイン状態の変化を受けて [build] が再実行される。
  /// 失敗時は [AsyncError] として UI に伝える。
  Future<void> signIn() async {
    state = const AsyncLoading();
    try {
      await ref.read(signInUseCaseProvider)();
    } on DomainError catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await ref.read(signOutUseCaseProvider)();
    } on DomainError catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> setGrade(Grade? grade) =>
      _updateProfile((user) => user.copyWith(grade: grade));

  Future<void> setCourse(AcademicArea? course) =>
      _updateProfile((user) => user.copyWith(course: course));

  Future<void> setClass(AcademicClass? class_) =>
      _updateProfile((user) => user.copyWith(class_: class_));

  /// 画面へ即座に反映するため先に状態を更新し、保存に失敗したら元に戻して再送出する。
  Future<void> _updateProfile(DottoUser Function(DottoUser) update) async {
    final current = state.value;
    if (current == null) {
      return;
    }
    state = AsyncData(update(current));
    try {
      final saved = await ref.read(updateUserProfileUseCaseProvider)(
        update(current),
      );
      state = AsyncData(saved);
    } on DomainError {
      state = AsyncData(current);
      rethrow;
    }
  }
}

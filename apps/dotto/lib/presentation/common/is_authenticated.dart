import 'package:dotto/presentation/common/auth_account_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_authenticated.g.dart';

@riverpod
bool isAuthenticated(Ref ref) =>
    ref.watch(authAccountStateProvider).value != null;

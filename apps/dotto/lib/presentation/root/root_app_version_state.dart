import 'package:dotto/application/fetch_app_version_use_case.dart';
import 'package:dotto/domain/entity/app_version_status.dart';
import 'package:dotto/presentation/root/root_initialization_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'root_app_version_state.g.dart';

@riverpod
final class RootAppVersionState extends _$RootAppVersionState {
  @override
  Future<AppVersionStatus> build() async {
    await ref.watch(rootInitializationStateProvider.future);
    return await ref.watch(fetchAppVersionUseCaseProvider)();
  }
}

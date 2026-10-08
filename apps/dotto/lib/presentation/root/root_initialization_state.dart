import 'package:dotto/application/initialize_app_use_case.dart';
import 'package:dotto/presentation/common/flag_override_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'root_initialization_state.g.dart';

@Riverpod(keepAlive: true)
final class RootInitializationState extends _$RootInitializationState {
  @override
  Future<void> build() async {
    await ref.watch(initializeAppUseCaseProvider)();
    await ref.read(flagOverrideStateProvider.notifier).load();
  }
}

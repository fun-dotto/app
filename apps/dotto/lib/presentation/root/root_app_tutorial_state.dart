import 'package:dotto/application/complete_tutorial_use_case.dart';
import 'package:dotto/application/fetch_tutorial_completion_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'root_app_tutorial_state.g.dart';

@riverpod
final class RootAppTutorialState extends _$RootAppTutorialState {
  @override
  Future<bool> build() => ref.watch(fetchTutorialCompletionUseCaseProvider)();
  Future<void> onAppTutorialDismissed() async {
    state = await AsyncValue.guard(() async {
      await ref.read(completeTutorialUseCaseProvider)();
      return true;
    });
  }
}

import 'package:dotto/foundation/progress_view.dart';
import 'package:dotto/foundation/screen_states.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class ScreenContainer extends ConsumerWidget {
  const ScreenContainer({required this.states, required this.child, super.key});

  final ScreenStates states;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [child, _screenLoading()]);
  }

  Widget _screenLoading() {
    if (states.isRequiredStatesLoading) {
      return const ProgressView();
    }
    return const SizedBox();
  }
}

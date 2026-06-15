import 'package:dotto/foundation/screen_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class ScreenContainer extends ConsumerWidget {
  const ScreenContainer({required this.states, required this.child, super.key});

  final ScreenStates states;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}

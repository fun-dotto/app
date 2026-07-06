import 'package:dotto/foundation/screen_states.dart';
import 'package:dotto_design_system/component/error_alert.dart';
import 'package:dotto_design_system/component/progress_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class ScreenContainer extends ConsumerWidget {
  const ScreenContainer({required this.states, required this.child, super.key});

  final ScreenStates states;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [child, _errorScreen(), _loadingScreen()]);
  }

  Widget _loadingScreen() {
    if (states.isRequiredStatesLoading) {
      return const Center(child: DottoProgressIndicator());
    }
    return const SizedBox();
  }

  Widget _errorScreen() {
    if (states.isRequiredStatesFailure) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: DottoErrorAlert(
            title: 'エラーが発生しました。',
            message: '時間を空けてもう一度お試しください。',
          ),
        ),
      );
    }
    return const SizedBox();
  }
}

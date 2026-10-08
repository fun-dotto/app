import 'package:dotto_design_system/component/progress_indicator.dart';
import 'package:flutter/widgets.dart';

final class LoadingView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: DottoProgressIndicator());
  }
}

import 'package:dotto_design_system/component/error_alert.dart';
import 'package:flutter/widgets.dart';

/// データの取得に失敗したことを伝える。
final class ErrorView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
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
}

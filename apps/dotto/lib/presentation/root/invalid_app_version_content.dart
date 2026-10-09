import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

/// アプリのアップデートを促す表示。
final class InvalidAppVersionContent extends StatelessWidget {
  const new({
    required this.currentAppVersion,
    required this.latestAppVersion,
    required this.onUpdate,
    super.key,
  });

  final String currentAppVersion;
  final String latestAppVersion;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dottoのアップデートが必要です',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 64,
          children: [
            Text(
              '現在のバージョン: $currentAppVersion\n最新バージョン: $latestAppVersion',
              textAlign: TextAlign.center,
            ),
            DottoButton(onPressed: onUpdate, child: const Text('今すぐアップデート')),
          ],
        ),
      ),
    );
  }
}

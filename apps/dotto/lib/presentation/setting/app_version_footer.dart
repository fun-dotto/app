import 'package:flutter/widgets.dart';

/// アプリのバージョン表示。
///
/// 開発用ビルドでは [onTap] で Debug 画面を開ける。
final class AppVersionFooter extends StatelessWidget {
  const new({required this.versionLabel, this.onTap, super.key});

  final String versionLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Text(versionLabel));
  }
}

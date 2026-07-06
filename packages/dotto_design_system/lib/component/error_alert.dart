import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final class DottoErrorAlert extends StatelessWidget {
  const DottoErrorAlert({
    required this.title,
    required this.message,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 32,
      children: [
        Icon(
          Icons.error_outline,
          color: SemanticColor.light.accentError,
          size: 64,
        ),
        Column(
          spacing: 16,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: SemanticColor.light.labelPrimary,
              ),
            ),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: SemanticColor.light.labelSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final class _Demo extends StatelessWidget {
  const _Demo({
    required this.title,
    required this.message,
    //
    // ignore: unused_element_parameter
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DottoErrorAlert(
            title: title,
            message: message,
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'ErrorAlert', type: DottoErrorAlert)
Widget errorAlert(BuildContext context) {
  return const _Demo(title: 'エラーが発生しました。', message: '時間を空けてもう一度お試しください。');
}

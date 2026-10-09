import 'package:dotto/presentation/root/invalid_app_version_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: InvalidAppVersionContent)
Widget invalidAppVersionContentDefault(BuildContext context) =>
    InvalidAppVersionContent(
      currentAppVersion: '1.0.0',
      latestAppVersion: '2.0.0',
      onUpdate: () {},
    );

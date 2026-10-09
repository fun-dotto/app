import 'package:dotto/presentation/common/error_view.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ErrorView)
Widget errorViewDefault(BuildContext context) => const ErrorView();

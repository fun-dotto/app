import 'package:dotto/domain/entity/debug_tokens.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/presentation/debug/debug_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _flags = <DebugFlagStatus>[
  (flag: Flags.funch, override: null, effectiveValue: true),
  (flag: Flags.web, override: false, effectiveValue: false),
  (flag: Flags.opinionBox, override: true, effectiveValue: true),
];

@widgetbook.UseCase(name: 'Default', type: DebugContent)
Widget debugContentDefault(BuildContext context) => DebugContent(
  tokens: const DebugTokens(
    appCheckToken: 'app-check-token',
    idToken: 'id-token-that-is-very-long-and-should-be-ellipsized-at-the-end',
    fcmToken: 'fcm-token',
  ),
  flavor: 'dev',
  flags: _flags,
  onTokenTap: (_) {},
  onFlagTap: (_) {},
);

@widgetbook.UseCase(name: 'No tokens', type: DebugContent)
Widget debugContentNoTokens(BuildContext context) => DebugContent(
  tokens: const DebugTokens(),
  flavor: null,
  flags: _flags,
  onTokenTap: (_) {},
  onFlagTap: (_) {},
);

import 'package:dotto/foundation/log/logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [Logger]を返すHook。
///
/// [WidgetRef]を必要としないため、HookWidgetからも利用できる。
Logger useLogger() {
  final container = ProviderScope.containerOf(useContext());
  return container.read(loggerProvider);
}

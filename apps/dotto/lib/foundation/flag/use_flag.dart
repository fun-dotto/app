import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/foundation/flag/flag_overrides_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// FeatureFlagの値を返すHook。
///
/// 値は [featureFlagProvider] を参照するため、Debug用overrideも反映される。
/// [WidgetRef] を必要としないため、HookWidgetからも利用できる。
T useFlag<T>(Flag<T> flag) {
  final container = ProviderScope.containerOf(useContext());
  final value = useState(container.read(featureFlagProvider(flag)));
  useEffect(() {
    final subscription = container.listen(
      featureFlagProvider(flag),
      (_, next) => value.value = next,
      fireImmediately: true,
    );
    return subscription.close;
  }, [container, flag]);
  return value.value;
}

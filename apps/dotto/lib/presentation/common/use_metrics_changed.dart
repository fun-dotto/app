import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 画面サイズや向きなどの変化を検知して [onChanged] を呼ぶ Hook。
void useMetricsChanged(VoidCallback onChanged) {
  final latest = useRef(onChanged)..value = onChanged;
  useEffect(() {
    final observer = _MetricsObserver(() => latest.value());
    WidgetsBinding.instance.addObserver(observer);
    return () => WidgetsBinding.instance.removeObserver(observer);
  }, const []);
}

final class _MetricsObserver with WidgetsBindingObserver {
  const new(this._onChanged);
  final VoidCallback _onChanged;

  @override
  void didChangeMetrics() => _onChanged();
}

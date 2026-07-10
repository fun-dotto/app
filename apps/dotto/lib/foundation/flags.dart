import 'package:dotto/foundation/flag.dart';

abstract final class Flags {
  /// Funch feature flag
  static const funch = Flag<bool>(
    key: 'is_funch_enabled',
    description: 'Funch',
    defaultValue: false,
  );

  /// Debug画面の一覧表示用。新しいフラグを追加したらここにも追記する。
  static const List<Flag<Object>> all = [funch];
}

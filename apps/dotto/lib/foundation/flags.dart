import 'package:dotto/foundation/flag.dart';

abstract final class Flags {
  /// Funch feature flag
  static const funch = Flag<bool>(
    key: 'is_funch_enabled',
    description: 'Funch',
    defaultValue: false,
  );

  /// Opinion box feature flag
  static const opinionBox = Flag<bool>(
    key: 'is_opinion_box_enabled',
    description: 'Opinion Box',
    defaultValue: false,
  );

  /// Debug画面の一覧表示用。新しいフラグを追加したらここにも追記する。
  static const List<Flag<Object>> all = [funch, opinionBox];
}

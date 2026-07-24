import 'package:dotto/foundation/flag/flag.dart';

abstract final class Flags {
  static const funch = Flag<bool>(
    key: 'funch',
    description: 'Funch',
    defaultValue: false,
  );

  static const web = Flag<bool>(
    key: 'web',
    description: 'Web版',
    defaultValue: false,
  );

  static const opinionBox = Flag<bool>(
    key: 'opinion_box',
    description: '意見箱',
    defaultValue: false,
  );

  /// Debug画面の一覧表示用。新しいフラグを追加したらここにも追記する。
  static const List<Flag<Object>> all = [funch, web, opinionBox];
}

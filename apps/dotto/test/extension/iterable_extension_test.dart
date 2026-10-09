import 'package:dotto/extension/iterable_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('空のコレクションは null に変換する', () {
    expect(<int>[].mapToBuiltListOrNull((e) => e), isNull);
  });

  test('要素を変換して BuiltList にする', () {
    expect([1, 2].mapToBuiltListOrNull((e) => '$e')?.toList(), ['1', '2']);
  });
}

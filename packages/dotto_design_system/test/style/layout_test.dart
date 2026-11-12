import 'package:dotto_design_system/style/layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DottoLayout.horizontalInsets', () {
    for (final (width, layout, expected) in [
      (360.0, DottoContentLayout.singleNarrow, 16.0),
      (639.0, DottoContentLayout.singleWide, 79.5),
      (1100.0, DottoContentLayout.singleNarrow, 310.0),
      (800.0, DottoContentLayout.singleWide, 16.0),
      (1100.0, DottoContentLayout.singleWide, 70.0),
    ]) {
      test('$width / ${layout.name} → $expected', () {
        final insets = DottoLayout.horizontalInsets(width, layout: layout);
        expect(insets.left, expected);
        expect(insets.right, expected);
      });
    }
  });

  group('DottoLayout.horizontalInsets(margin: false)', () {
    for (final (width, expected) in [
      (360.0, 0.0),
      (512.0, 0.0),
      (1100.0, 294.0),
    ]) {
      test('$width → $expected', () {
        expect(
          DottoLayout.horizontalInsets(width, margin: false).left,
          expected,
        );
      });
    }
  });
}

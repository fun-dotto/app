import 'package:dotto_design_system/component/content.dart';
import 'package:dotto_design_system/style/layout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _a = Key('a');
const _b = Key('b');

Future<void> _pump(WidgetTester tester, double width, Widget content) {
  tester.view
    ..physicalSize = Size(width, 800)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  return tester.pumpWidget(
    MaterialApp(
      home: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: width,
          height: 800,
          child: SingleChildScrollView(child: content),
        ),
      ),
    ),
  );
}

Widget _box(Key key) => SizedBox(key: key, height: 100);

double _width(WidgetTester tester, Key key) =>
    tester.getSize(find.byKey(key)).width;

void main() {
  group('DottoContent.single', () {
    for (final (width, layout, expected) in [
      (360.0, DottoContentLayout.singleNarrow, 328.0),
      (639.0, DottoContentLayout.singleWide, 480.0),
      (640.0, DottoContentLayout.singleWide, 608.0),
      (1100.0, DottoContentLayout.singleNarrow, 480.0),
      (1100.0, DottoContentLayout.singleWide, 960.0),
    ]) {
      testWidgets('$width / ${layout.name} → $expected', (tester) async {
        await _pump(
          tester,
          width,
          DottoContent.single(layout: layout, child: _box(_a)),
        );
        expect(_width(tester, _a), expected);
      });
    }

    testWidgets('最大幅に達したら中央寄せ', (tester) async {
      await _pump(tester, 1100, DottoContent.single(child: _box(_a)));
      expect(tester.getTopLeft(find.byKey(_a)).dx, (1100 - 480) / 2);
    });
  });

  group('DottoContent.twoColumn', () {
    testWidgets('639 では縦に積む', (tester) async {
      await _pump(
        tester,
        639,
        DottoContent.twoColumn(primary: _box(_a), secondary: _box(_b)),
      );
      expect(_width(tester, _a), 480);
      expect(
        tester.getTopLeft(find.byKey(_b)).dy,
        greaterThan(tester.getTopLeft(find.byKey(_a)).dy),
      );
    });

    testWidgets('primaryOnly では secondary を出さない', (tester) async {
      await _pump(
        tester,
        360,
        DottoContent.twoColumn(
          primary: _box(_a),
          secondary: _box(_b),
          collapse: DottoCollapse.primaryOnly,
        ),
      );
      expect(find.byKey(_b), findsNothing);
    });

    testWidgets('640 では2カラムに分ける', (tester) async {
      await _pump(
        tester,
        640,
        DottoContent.twoColumn(primary: _box(_a), secondary: _box(_b)),
      );
      expect(_width(tester, _a), 296);
      expect(_width(tester, _b), 296);
      expect(
        tester.getTopLeft(find.byKey(_a)).dy,
        tester.getTopLeft(find.byKey(_b)).dy,
      );
    });

    testWidgets('1100 では各カラム 480', (tester) async {
      await _pump(
        tester,
        1100,
        DottoContent.twoColumn(primary: _box(_a), secondary: _box(_b)),
      );
      expect(_width(tester, _a), 480);
      expect(_width(tester, _b), 480);
      expect(
        tester.getTopLeft(find.byKey(_b)).dx -
            tester.getTopRight(find.byKey(_a)).dx,
        DottoLayout.columnGutter,
      );
    });
  });

  group('DottoContent.flow', () {
    testWidgets('640 以上では交互に左右へ振り分ける', (tester) async {
      const c = Key('c');
      await _pump(
        tester,
        1100,
        DottoContent.flow(sections: [_box(_a), _box(_b), _box(c)]),
      );
      final a = tester.getTopLeft(find.byKey(_a));
      final b = tester.getTopLeft(find.byKey(_b));
      final cPos = tester.getTopLeft(find.byKey(c));
      expect(b.dx, greaterThan(a.dx));
      expect(cPos.dx, a.dx);
      expect(cPos.dy, greaterThan(a.dy));
    });
  });

  testWidgets('DottoContentPadding は余白だけを足す', (tester) async {
    await _pump(
      tester,
      1100,
      const DottoContentPadding(
        layout: DottoContentLayout.singleWide,
        vertical: 8,
        child: SizedBox(key: _a, height: 10),
      ),
    );
    expect(_width(tester, _a), 960);
    expect(tester.getTopLeft(find.byKey(_a)), const Offset(70, 8));
  });
}

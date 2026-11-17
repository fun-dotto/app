import 'package:dotto_design_system/component/list_detail.dart';
import 'package:dotto_design_system/style/layout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _list = Key('list');
const _detail = Key('detail');
const _placeholder = Key('placeholder');

Future<void> _pump(WidgetTester tester, double width) {
  tester.view
    ..physicalSize = Size(width, 800)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  return tester.pumpWidget(
    const MaterialApp(
      home: DottoListDetail(
        list: SizedBox(key: _list),
        detail: DottoListDetailRoot(
          placeholder: SizedBox(key: _placeholder),
          child: SizedBox(key: _detail),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('ブレイクポイント以上では一覧を左に並べ、右に未選択の案内を出す', (tester) async {
    await _pump(tester, DottoLayout.listDetailBreakpoint);

    expect(
      tester.getSize(find.byKey(_list)).width,
      DottoLayout.listPaneWidth,
    );
    expect(find.byKey(_placeholder), findsOneWidget);
    expect(find.byKey(_detail), findsNothing);
  });

  testWidgets('ブレイクポイント未満では一覧のルートだけを全面に出す', (tester) async {
    await _pump(tester, DottoLayout.listDetailBreakpoint - 1);

    expect(find.byKey(_list), findsNothing);
    expect(find.byKey(_placeholder), findsNothing);
    expect(find.byKey(_detail), findsOneWidget);
  });
}

import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:dotto_design_system/component/dotto_app_bar_action.dart';
import 'package:dotto_design_system/component/vertical_bar_scope.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

DottoAppBarAction _tuneAction() => DottoAppBarAction(
  icon: const Icon(Icons.tune),
  label: 'カスタム',
  action: () {},
);

DottoAppBarAction _closeAction() => DottoAppBarAction(
  role: DottoAppBarActionRole.dismiss,
  icon: const Icon(Icons.close),
  label: '閉じる',
  action: () {},
);

Widget _app({
  required ValueNotifier<List<Widget>> actions,
  bool isVisible = true,
}) => MaterialApp(
  home: VerticalBarScope(
    actions: actions,
    child: TickerMode(
      enabled: isVisible,
      child: Scaffold(
        appBar: DottoAppBar(title: const Text('講義'), actions: [_tuneAction()]),
      ),
    ),
  ),
);

void main() {
  testWidgets('縦バーがあるときはアクションをAppBarではなく縦バーに渡す', (tester) async {
    final actions = ValueNotifier<List<Widget>>(const []);
    addTearDown(actions.dispose);

    await tester.pumpWidget(_app(actions: actions));
    await tester.pump();

    expect(find.byIcon(Icons.tune), findsNothing);
    expect(actions.value, hasLength(1));
  });

  testWidgets('裏に回ったタブのアクションは縦バーから外す', (tester) async {
    final actions = ValueNotifier<List<Widget>>(const []);
    addTearDown(actions.dispose);
    await tester.pumpWidget(_app(actions: actions));
    await tester.pump();

    await tester.pumpWidget(_app(actions: actions, isVisible: false));
    await tester.pump();

    expect(actions.value, isEmpty);
  });

  testWidgets('縦バーがないときはAppBarにアクションを表示する', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: DottoAppBar(
            title: const Text('講義'),
            actions: [_tuneAction()],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.tune), findsOneWidget);
  });

  testWidgets('戻れる画面では、戻るボタンをAppBarではなく縦バーの先頭に渡す', (tester) async {
    final actions = ValueNotifier<List<Widget>>(const []);
    addTearDown(actions.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: VerticalBarScope(
          actions: actions,
          child: Navigator(
            pages: [
              const MaterialPage<void>(child: Scaffold(body: Text('一覧'))),
              MaterialPage<void>(
                child: Scaffold(
                  appBar: DottoAppBar(
                    title: const Text('詳細'),
                    actions: [_tuneAction()],
                  ),
                ),
              ),
            ],
            onDidRemovePage: (_) {},
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(BackButton), findsNothing);
    expect(find.byType(BackButtonIcon), findsNothing);
    expect(actions.value, hasLength(2));
    expect(actions.value.first, isNot(isA<DottoAppBarAction>()));
  });

  testWidgets('dismissのアクションは、縦バーがないときAppBarの先頭に表示する', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: DottoAppBar(
            title: const Text('投稿'),
            actions: [_tuneAction(), _closeAction()],
          ),
        ),
      ),
    );

    final closeX = tester.getCenter(find.byIcon(Icons.close)).dx;
    final titleX = tester.getCenter(find.text('投稿')).dx;
    final tuneX = tester.getCenter(find.byIcon(Icons.tune)).dx;
    expect(closeX, lessThan(titleX));
    expect(titleX, lessThan(tuneX));
  });

  testWidgets('dismissのアクションは、縦バーでは戻るボタンの代わりに先頭へ渡す', (tester) async {
    final actions = ValueNotifier<List<Widget>>(const []);
    addTearDown(actions.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: VerticalBarScope(
          actions: actions,
          child: Navigator(
            pages: [
              const MaterialPage<void>(child: Scaffold(body: Text('一覧'))),
              MaterialPage<void>(
                child: Scaffold(
                  appBar: DottoAppBar(
                    title: const Text('投稿'),
                    actions: [_tuneAction(), _closeAction()],
                  ),
                ),
              ),
            ],
            onDidRemovePage: (_) {},
          ),
        ),
      ),
    );
    await tester.pump();

    expect(actions.value, hasLength(2));
    expect(
      actions.value.first,
      isA<DottoAppBarAction>().having(
        (action) => action.role,
        'role',
        DottoAppBarActionRole.dismiss,
      ),
    );
  });

  testWidgets('アクションをタップするとactionを呼び、labelをツールチップに出す', (tester) async {
    var tapCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: DottoAppBar(
            title: const Text('講義'),
            actions: [
              DottoAppBarAction(
                icon: const Icon(Icons.tune),
                label: 'カスタム',
                action: () => tapCount++,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('カスタム'));

    expect(tapCount, 1);
  });
}

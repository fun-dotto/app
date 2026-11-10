import 'package:dotto/presentation/common/dotto_app_bar.dart';
import 'package:dotto/presentation/common/vertical_bar_scope.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _app({
  required ValueNotifier<List<Widget>> actions,
  bool isVisible = true,
}) => MaterialApp(
  home: VerticalBarScope(
    actions: actions,
    child: TickerMode(
      enabled: isVisible,
      child: const Scaffold(
        appBar: DottoAppBar(title: Text('講義'), actions: [Icon(Icons.tune)]),
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
      const MaterialApp(
        home: Scaffold(
          appBar: DottoAppBar(title: Text('講義'), actions: [Icon(Icons.tune)]),
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
            pages: const [
              MaterialPage<void>(child: Scaffold(body: Text('一覧'))),
              MaterialPage<void>(
                child: Scaffold(
                  appBar: DottoAppBar(
                    title: Text('詳細'),
                    actions: [Icon(Icons.tune)],
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
    expect(actions.value.first, isNot(isA<Icon>()));
  });
}

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// [home] を `/course` に置き、子パスへの遷移先をパス名のテキストで表示するルーター。
///
/// 画面から型付きルートで遷移した先を、遷移先の画面の依存なしに検証するために使う。
GoRouter routeRecorder(
  Widget home, {
  String path = '/course',
  List<String> childPaths = const [],
}) => GoRouter(
  initialLocation: path,
  routes: [
    GoRoute(
      path: path,
      builder: (_, _) => home,
      routes: [
        for (final childPath in childPaths)
          GoRoute(
            path: childPath,
            builder: (_, state) => Scaffold(body: Text(state.uri.path)),
          ),
      ],
    ),
  ],
);

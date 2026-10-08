import 'package:dotto/application/fetch_app_links_use_case.dart';
import 'package:dotto/domain/app_links.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_links_state.g.dart';

/// 外部ページの URL。
///
/// Remote Config の更新を拾うため keepAlive にせず、画面を開くたびに読み直す。
@riverpod
final class AppLinksState extends _$AppLinksState {
  @override
  AppLinks build() => ref.watch(fetchAppLinksUseCaseProvider)();
}

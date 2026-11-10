import 'package:dotto/application/fetch_screen_layout_use_case.dart';
import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_layout_state.g.dart';

/// 端末の画面形状。画面サイズの変化やアプリ復帰時に再取得される。
@riverpod
final class ScreenLayoutState extends _$ScreenLayoutState {
  @override
  Future<ScreenLayout> build() => ref.watch(fetchScreenLayoutUseCaseProvider)();
}

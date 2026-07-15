import 'dart:async';

import 'package:dotto/domain/user_preference_keys.dart';
import 'package:dotto/foundation/container/async_entity.dart';
import 'package:dotto/foundation/container/async_entity_notifier.dart';
import 'package:dotto/helper/user_preference_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root_app_tutorial_state.g.dart';

/// アプリチュートリアルを表示済みかどうか
@riverpod
final class RootAppTutorialState extends _$RootAppTutorialState
    with AsyncEntityNotifierMixin<bool> {
  @override
  AsyncEntity<bool> build() => initialState();

  @override
  Future<bool> fetch() async {
    return await UserPreferenceRepository.getBool(
          UserPreferenceKeys.isAppTutorialComplete,
        ) ??
        false;
  }

  void onAppTutorialDismissed() {
    state = state.copyWith(entity: true);
    unawaited(
      UserPreferenceRepository.setBool(
        UserPreferenceKeys.isAppTutorialComplete,
        value: true,
      ),
    );
  }
}

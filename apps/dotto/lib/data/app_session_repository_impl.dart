import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/user_preference_keys.dart';
import 'package:dotto/domain/repository/app_session_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_session_repository_impl.g.dart';

@riverpod
Future<SharedPreferences> sessionPreferences(Ref ref) =>
    SharedPreferences.getInstance();

@riverpod
DateTime sessionCurrentTime(Ref ref) => DateTime.now();

@riverpod
AppSessionRepository appSessionRepository(Ref ref) => AppSessionRepositoryImpl(
  ref.watch(sessionPreferencesProvider.future),
  ref.watch(sessionCurrentTimeProvider),
  isDebug: kDebugMode,
);

final class AppSessionRepositoryImpl implements AppSessionRepository {
  const new(this._preferences, this._now, {required this.isDebug});
  final Future<SharedPreferences> _preferences;
  final DateTime _now;
  final bool isDebug;
  static const _promptCooldown = Duration(days: 7);

  @override
  Future<bool> fetchTutorialCompletion() async =>
      (await _preferences).getBool(
        UserPreferenceKeys.isAppTutorialComplete.key,
      ) ??
      false;

  @override
  Future<void> completeTutorial() async {
    if (!await (await _preferences).setBool(
      UserPreferenceKeys.isAppTutorialComplete.key,
      true,
    )) {
      throw const DomainError(
        type: DomainErrorType.unknown,
        message: 'チュートリアルの完了状態を保存できませんでした',
      );
    }
  }

  @override
  Future<bool> shouldPromptNotification() async {
    if (isDebug) return true;
    final lastShown = (await _preferences).getInt(
      UserPreferenceKeys.notificationPromptLastShownAt.key,
    );
    return lastShown == null ||
        _now.difference(DateTime.fromMillisecondsSinceEpoch(lastShown)) >=
            _promptCooldown;
  }

  @override
  Future<void> recordNotificationPrompt() async {
    if (isDebug) return;
    if (!await (await _preferences).setInt(
      UserPreferenceKeys.notificationPromptLastShownAt.key,
      _now.millisecondsSinceEpoch,
    )) {
      throw const DomainError(
        type: DomainErrorType.unknown,
        message: '通知案内の表示日時を保存できませんでした',
      );
    }
  }
}

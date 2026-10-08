abstract interface class AppSessionRepository {
  Future<bool> fetchTutorialCompletion();
  Future<void> completeTutorial();
  Future<bool> shouldPromptNotification();
  Future<void> recordNotificationPrompt();
}

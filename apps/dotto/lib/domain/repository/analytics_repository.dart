abstract interface class AnalyticsRepository {
  Future<void> logLogin();

  Future<void> logLogout();
}

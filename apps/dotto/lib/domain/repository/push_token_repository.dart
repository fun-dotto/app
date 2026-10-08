abstract interface class PushTokenRepository {
  Stream<String> watchRefreshes();
  Future<void> synchronize([String? token]);
}

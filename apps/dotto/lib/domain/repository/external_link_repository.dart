abstract interface class ExternalLinkRepository {
  Future<bool> open(String url, {bool shouldOpenExternally = false});
}

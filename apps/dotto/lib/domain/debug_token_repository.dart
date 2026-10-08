import 'package:dotto/domain/debug_tokens.dart';

abstract interface class DebugTokenRepository {
  Future<DebugTokens> fetch();
}

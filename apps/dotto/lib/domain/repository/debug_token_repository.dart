import 'package:dotto/domain/entity/debug_tokens.dart';

abstract interface class DebugTokenRepository {
  Future<DebugTokens> fetch();
}

import 'package:dotto/data/debug_token_data_source.dart';
import 'package:dotto/domain/debug_token_repository.dart';
import 'package:dotto/domain/debug_tokens.dart';
import 'package:dotto/domain/domain_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_token_repository_impl.g.dart';

@riverpod
DebugTokenRepository debugTokenRepository(Ref ref) =>
    DebugTokenRepositoryImpl(ref.watch(debugTokenDataSourceProvider));

final class DebugTokenRepositoryImpl implements DebugTokenRepository {
  const new(this._dataSource);

  final DebugTokenDataSource _dataSource;

  @override
  Future<DebugTokens> fetch() async {
    try {
      final [appCheckToken, idToken, fcmToken] = await Future.wait([
        _dataSource.fetchAppCheckToken(),
        _dataSource.fetchIdToken(),
        _dataSource.fetchFcmToken(),
      ]);
      return DebugTokens(
        appCheckToken: appCheckToken,
        idToken: idToken,
        fcmToken: fcmToken,
      );
    } on Exception catch (e, stackTrace) {
      throw DomainError(
        type: DomainErrorType.unknown,
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

import 'package:dotto/data/url_launcher_helper.dart';
import 'package:dotto/domain/repository/external_link_repository.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'external_link_repository_impl.g.dart';

@riverpod
ExternalLinkRepository externalLinkRepository(Ref ref) =>
    ExternalLinkRepositoryImpl(ref.watch(loggerProvider));

final class ExternalLinkRepositoryImpl implements ExternalLinkRepository {
  const new(this._logger);
  final Logger _logger;
  @override
  Future<bool> open(String url, {bool shouldOpenExternally = false}) =>
      launchUrlSafely(
        url,
        logger: _logger,
        mode: shouldOpenExternally
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault,
      );
}

import 'package:dotto/domain/entity/course_link_event.dart';
import 'package:dotto/domain/repository/course_link_repository.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'course_link_repository_impl.g.dart';

@riverpod
CourseLinkRepository courseLinkRepository(Ref ref) =>
    CourseLinkRepositoryImpl(ref.watch(loggerProvider));

final class CourseLinkRepositoryImpl implements CourseLinkRepository {
  const new(this._logger);
  final Logger _logger;

  @override
  Future<bool> open(String url, {CourseLinkEvent? event}) async {
    if (event != null) {
      await _logger.logEvent(switch (event) {
        CourseLinkEvent.dottoWeb => .dottoWebButtonTapped,
        CourseLinkEvent.macSupport => .macSupportButtonTapped,
        CourseLinkEvent.opinionBox => .opinionBoxButtonTapped,
      });
    }
    try {
      return await launchUrlString(url, mode: LaunchMode.externalApplication);
    } on Exception catch (error, stackTrace) {
      await _logger.logError(error, stackTrace);
      return false;
    }
  }
}

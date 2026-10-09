import 'package:dotto/domain/entity/course_resources.dart';
import 'package:dotto/domain/repository/course_resource_repository.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/repository/config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_resource_repository_impl.g.dart';

@riverpod
CourseResourceRepository courseResourceRepository(Ref ref) =>
    CourseResourceRepositoryImpl(ref.watch(configRepositoryProvider));

final class CourseResourceRepositoryImpl implements CourseResourceRepository {
  const new(this._config);
  final ConfigRepository _config;

  @override
  CourseResources fetch() => CourseResources(
    dottoWebUrl: _config.get(RemoteConfigs.dottoWebUrl),
    macSupportDeskUrl: _config.get(RemoteConfigs.macSupportDeskUrl),
    opinionBoxUrl: _config.get(RemoteConfigs.opinionBoxUrl),
    officialCalendarUrl: _config.get(RemoteConfigs.officialCalendarPdfUrl),
    springTimetableUrl: _config.get(RemoteConfigs.timetable1PdfUrl),
    fallTimetableUrl: _config.get(RemoteConfigs.timetable2PdfUrl),
    breakingAnnouncement: _config.get(RemoteConfigs.breakingAnnouncement),
    hopeUrl: 'https://hope.fun.ac.jp/auth/saml2/login.php?idp=1bec319bca7458548c77d545a2a1b3de',
    hopeIconUrl: 'https://hope.fun.ac.jp/pluginfile.php/1/core_admin/favicon/64x64/1756948564/favicon.ico',
    studentPortalUrl: 'https://students.fun.ac.jp/Portal',
    studentPortalIconUrl: 'https://students.fun.ac.jp/favicon.ico',
  );
}

import 'package:dotto/domain/entity/app_version_status.dart';

abstract interface class AppVersionRepository {
  Future<AppVersionStatus> fetch();
}

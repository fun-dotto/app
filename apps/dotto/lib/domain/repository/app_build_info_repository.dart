import 'package:dotto/domain/entity/app_build_info.dart';

abstract interface class AppBuildInfoRepository {
  Future<AppBuildInfo> fetch();
}

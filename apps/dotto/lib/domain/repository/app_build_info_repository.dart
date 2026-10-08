import 'package:dotto/domain/app_build_info.dart';

abstract interface class AppBuildInfoRepository {
  Future<AppBuildInfo> fetch();
}

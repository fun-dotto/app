import 'package:dotto/domain/app_build_info.dart';
import 'package:dotto/domain/app_build_info_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_build_info_repository_impl.g.dart';

@riverpod
AppBuildInfoRepository appBuildInfoRepository(Ref ref) =>
    const AppBuildInfoRepositoryImpl();

final class AppBuildInfoRepositoryImpl implements AppBuildInfoRepository {
  const new();

  @override
  Future<AppBuildInfo> fetch() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return AppBuildInfo(
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}

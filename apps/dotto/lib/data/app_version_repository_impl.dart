import 'package:dotto/data/app_build_info_repository_impl.dart';
import 'package:dotto/domain/entity/app_version_status.dart';
import 'package:dotto/domain/repository/app_build_info_repository.dart';
import 'package:dotto/domain/repository/app_version_repository.dart';
import 'package:dotto/domain/service/app_version_evaluator.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/repository/config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version_repository_impl.g.dart';

@riverpod
AppVersionRepository appVersionRepository(Ref ref) => AppVersionRepositoryImpl(
  ref.watch(appBuildInfoRepositoryProvider),
  ref.watch(configRepositoryProvider),
);

final class AppVersionRepositoryImpl implements AppVersionRepository {
  const new(this._buildInfo, this._config);
  final AppBuildInfoRepository _buildInfo;
  final ConfigRepository _config;
  @override
  Future<AppVersionStatus> fetch() async {
    final version = (await _buildInfo.fetch()).version;
    final latest = _config.get(RemoteConfigs.latestAppVersion);
    final evaluation = AppVersionEvaluator.evaluate(
      currentAppVersion: version,
      validAppVersion: _config.get(RemoteConfigs.validAppVersion),
      latestAppVersion: latest,
    );
    return AppVersionStatus(
      isValidAppVersion: evaluation.isValidAppVersion,
      isLatestAppVersion: evaluation.isLatestAppVersion,
      currentAppVersion: version,
      latestAppVersion: latest,
      appStorePageUrl: _config.get(RemoteConfigs.appStorePageUrl),
    );
  }
}

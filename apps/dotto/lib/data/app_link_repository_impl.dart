import 'package:dotto/data/config_data_source.dart';
import 'package:dotto/domain/entity/app_links.dart';
import 'package:dotto/domain/repository/app_link_repository.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_link_repository_impl.g.dart';

@riverpod
AppLinkRepository appLinkRepository(Ref ref) =>
    AppLinkRepositoryImpl(ref.watch(configDataSourceProvider));

final class AppLinkRepositoryImpl implements AppLinkRepository {
  const new(this._configDataSource);

  final ConfigDataSource _configDataSource;

  @override
  AppLinks fetch() => AppLinks(
    feedbackFormUrl: _configDataSource.get(RemoteConfigs.feedbackFormUrl),
    termsOfServiceUrl: _configDataSource.get(RemoteConfigs.termsOfServiceUrl),
    privacyPolicyUrl: _configDataSource.get(RemoteConfigs.privacyPolicyUrl),
  );
}

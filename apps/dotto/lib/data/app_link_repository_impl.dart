import 'package:dotto/domain/app_link_repository.dart';
import 'package:dotto/domain/app_links.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/repository/config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_link_repository_impl.g.dart';

@riverpod
AppLinkRepository appLinkRepository(Ref ref) =>
    AppLinkRepositoryImpl(ref.watch(configRepositoryProvider));

final class AppLinkRepositoryImpl implements AppLinkRepository {
  const new(this._configRepository);

  final ConfigRepository _configRepository;

  @override
  AppLinks fetch() => AppLinks(
    feedbackFormUrl: _configRepository.get(RemoteConfigs.feedbackFormUrl),
    termsOfServiceUrl: _configRepository.get(RemoteConfigs.termsOfServiceUrl),
    privacyPolicyUrl: _configRepository.get(RemoteConfigs.privacyPolicyUrl),
  );
}

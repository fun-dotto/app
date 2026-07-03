import 'package:dotto/controller/config_controller.dart';
import 'package:dotto/domain/app_version_evaluator.dart';
import 'package:dotto/domain/config.dart';
import 'package:dotto/feature/root/root_app_version.dart';
import 'package:dotto/feature/root/root_initialization_state.dart';
import 'package:dotto/foundation/async_entity.dart';
import 'package:dotto/foundation/async_entity_notifier.dart';
import 'package:dotto/foundation/async_status.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'root_app_version_state.g.dart';

/// アプリバージョンの評価結果
///
/// Remote Configのセットアップ完了後に評価するため、
/// [RootInitializationState] の成功を待ってから読み込む。
@riverpod
final class RootAppVersionState extends _$RootAppVersionState
    with AsyncEntityNotifierMixin<RootAppVersion> {
  @override
  AsyncEntity<RootAppVersion> build() {
    final initialization = ref.watch(rootInitializationStateProvider);

    ref.listen(configProvider, (_, next) {
      final currentAppVersion = state.entity?.currentAppVersion;
      if (currentAppVersion == null) return;
      state = state.copyWith(
        entity: _evaluate(currentAppVersion: currentAppVersion, config: next),
      );
    });

    if (initialization.status != AsyncStatus.success) {
      return AsyncEntity(status: AsyncStatus.loading);
    }
    return initialState();
  }

  @override
  Future<RootAppVersion> fetch() async {
    final currentAppVersion = (await PackageInfo.fromPlatform()).version;
    return _evaluate(
      currentAppVersion: currentAppVersion,
      config: ref.read(configProvider),
    );
  }

  RootAppVersion _evaluate({
    required String currentAppVersion,
    required Config config,
  }) {
    final evaluation = AppVersionEvaluator.evaluate(
      currentAppVersion: currentAppVersion,
      validAppVersion: config.validAppVersion,
      latestAppVersion: config.latestAppVersion,
    );
    return RootAppVersion(
      isValidAppVersion: evaluation.isValidAppVersion,
      isLatestAppVersion: evaluation.isLatestAppVersion,
      currentAppVersion: currentAppVersion,
      latestAppVersion: config.latestAppVersion,
      appStorePageUrl: config.appStorePageUrl,
    );
  }
}

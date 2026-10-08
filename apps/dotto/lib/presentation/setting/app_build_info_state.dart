import 'package:dotto/application/fetch_app_build_info_use_case.dart';
import 'package:dotto/domain/entity/app_build_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_build_info_state.g.dart';

@riverpod
final class AppBuildInfoState extends _$AppBuildInfoState {
  @override
  Future<AppBuildInfo> build() => ref.watch(fetchAppBuildInfoUseCaseProvider)();
}

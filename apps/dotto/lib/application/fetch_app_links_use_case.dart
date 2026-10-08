import 'package:dotto/data/app_link_repository_impl.dart';
import 'package:dotto/domain/entity/app_links.dart';
import 'package:dotto/domain/repository/app_link_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_app_links_use_case.g.dart';

final class FetchAppLinksUseCase {
  const new(this._repository);

  final AppLinkRepository _repository;

  AppLinks call() => _repository.fetch();
}

@riverpod
FetchAppLinksUseCase fetchAppLinksUseCase(Ref ref) =>
    FetchAppLinksUseCase(ref.watch(appLinkRepositoryProvider));

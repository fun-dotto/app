import 'package:dotto/data/external_link_repository_impl.dart';
import 'package:dotto/domain/repository/external_link_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'open_external_link_use_case.g.dart';

@riverpod
OpenExternalLinkUseCase openExternalLinkUseCase(Ref ref) =>
    OpenExternalLinkUseCase(ref.watch(externalLinkRepositoryProvider));

final class OpenExternalLinkUseCase {
  const new(this._repository);
  final ExternalLinkRepository _repository;
  Future<bool> call(String url, {bool shouldOpenExternally = false}) =>
      _repository.open(url, shouldOpenExternally: shouldOpenExternally);
}

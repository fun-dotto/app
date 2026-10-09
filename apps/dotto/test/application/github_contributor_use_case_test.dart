import 'package:dotto/application/fetch_github_contributors_use_case.dart';
import 'package:dotto/data/github_api_client.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_http_client_adapter.dart';

Map<String, Object?> _contributor(
  String login,
  int contributions, {
  String? type,
}) => {
  'id': login.hashCode,
  'login': login,
  'avatar_url': 'https://example.com/$login.png',
  'html_url': 'https://github.com/$login',
  'contributions': contributions,
  'type': ?type,
};

ProviderContainer _container(FakeHttpClientAdapter adapter) {
  final container = ProviderContainer(
    overrides: [gitHubApiClientProvider.overrideWithValue(fakeDio(adapter))],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('ボットを除いた開発者を貢献数の多い順に並べる', () async {
    final container = _container(
      FakeHttpClientAdapter()..on(
        'GET',
        '/repos/fun-dotto/dotto/contributors',
        (_) => FakeResponse(200, [
          _contributor('alice', 3, type: 'User'),
          _contributor('dependabot', 100, type: 'Bot'),
          _contributor('bob', 10),
        ]),
      ),
    );

    final profiles = await container.read(
      fetchGitHubContributorsUseCaseProvider,
    )();

    expect(profiles.map((profile) => profile.login), ['bob', 'alice']);
  });

  test('取得に失敗したらドメインエラーにする', () async {
    final container = _container(FakeHttpClientAdapter());

    await expectLater(
      container.read(fetchGitHubContributorsUseCaseProvider)(),
      throwsA(isA<DomainError>()),
    );
  });
}

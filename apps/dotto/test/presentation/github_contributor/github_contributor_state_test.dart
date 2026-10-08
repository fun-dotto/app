import 'package:dotto/data/github_api_client.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_client_adapter.dart';

Map<String, Object?> _contributor(
  int id,
  String login, {
  required int contributions,
  String? type,
}) => {
  'id': id,
  'login': login,
  'avatar_url': 'https://example.com/$login.png',
  'html_url': 'https://github.com/$login',
  'contributions': contributions,
  'type': ?type,
};

void main() {
  test('Botを除いた開発者を貢献数の多い順に取得できる', () async {
    final adapter = FakeHttpClientAdapter()
      ..on(
        'GET',
        '/repos/fun-dotto/dotto/contributors',
        (_) => FakeResponse(200, [
          _contributor(1, 'alice', contributions: 10, type: 'User'),
          _contributor(2, 'dependabot', contributions: 100, type: 'Bot'),
          _contributor(3, 'bob', contributions: 30),
        ]),
      );
    final container = ProviderContainer(
      overrides: [gitHubApiClientProvider.overrideWithValue(fakeDio(adapter))],
    );
    addTearDown(container.dispose);

    final contributors = await container.read(
      gitHubContributorStateProvider.future,
    );

    expect(contributors.map((c) => c.login), ['bob', 'alice']);
  });
}

import 'fake_http_client_adapter.dart';

/// 履修登録APIの登録結果をメモリ内に保存する。
final class FakeCourseRegistrationApi {
  new({this.initialRegisteredIds = const []}) {
    for (final id in initialRegisteredIds) {
      registrations[id] = _registration(id);
    }
    adapter
      ..on(
        'GET',
        '/v1/courseRegistrations',
        (_) => FakeResponse(200, {
          'courseRegistrations': registrations.values.toList(),
        }),
      )
      ..on(
        'GET',
        '/v1/timetableItems',
        (_) => FakeResponse(200, {
          'timetableItems': [
            for (final id in ['first', 'second', 'target'])
              {
                'id': id,
                'subject': _subject(id),
                'slot': {'dayOfWeek': 'Monday', 'period': 'Period1'},
                'rooms': <Object>[],
              },
          ],
        }),
      )
      ..on('POST', '/v1/courseRegistrations', (options) {
        final id =
            (options.data as Map<String, dynamic>)['subjectId'] as String;
        final registration = _registration(id);
        registrations[id] = registration;
        return FakeResponse(201, {'courseRegistration': registration});
      })
      ..on('DELETE', '/v1/courseRegistrations/registration-target', (_) {
        registrations.remove('target');
        return const FakeResponse(204);
      });
  }
  final List<String> initialRegisteredIds;
  final adapter = FakeHttpClientAdapter();
  final registrations = <String, Map<String, dynamic>>{};
  Map<String, dynamic> _subject(String id) => {
    'id': id,
    'name': id,
    'faculties': <Object>[],
    'year': 2026,
    'semester': 'H1',
    'credit': 2,
  };
  Map<String, dynamic> _registration(String id) => {
    'id': 'registration-$id',
    'subject': _subject(id),
  };
}

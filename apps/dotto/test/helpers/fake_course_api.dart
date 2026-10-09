import 'package:dotto/domain/entity/subject_summary.dart';

import 'fake_http_client_adapter.dart';

/// 履修登録をHTTP境界で保持するインメモリAPI。
final class FakeCourseApi {
  new({Set<String> registeredSubjectIds = const {}})
    : registeredSubjectIds = {...registeredSubjectIds} {
    adapter
      ..on(
        'GET',
        '/v1/courseRegistrations',
        (_) => FakeResponse(200, {
          'courseRegistrations': [
            for (final id in this.registeredSubjectIds) _registration(id),
          ],
        }),
      )
      ..on(
        'GET',
        '/v1/timetableItems',
        (_) => FakeResponse(200, {
          'timetableItems': [
            for (final id in ['a', 'b', 'c'])
              {
                'id': 'item-$id',
                'subject': _subject(id),
                'slot': {'dayOfWeek': 'Monday', 'period': 'Period1'},
                'rooms': <Object?>[],
              },
          ],
        }),
      )
      ..on('POST', '/v1/courseRegistrations', (request) {
        final id = switch (request.data) {
          {'subjectId': final String id} => id,
          _ => throw StateError('Invalid request'),
        };
        this.registeredSubjectIds.add(id);
        return FakeResponse(201, {'courseRegistration': _registration(id)});
      });
    for (final id in ['a', 'b', 'c']) {
      adapter.on('DELETE', '/v1/courseRegistrations/registration-$id', (_) {
        this.registeredSubjectIds.remove(id);
        return const FakeResponse(204);
      });
    }
  }

  final adapter = FakeHttpClientAdapter();
  final Set<String> registeredSubjectIds;

  SubjectSummary subject(String id) =>
      SubjectSummary(id: id, name: '科目$id', faculties: const []);

  Map<String, Object?> _subject(String id) => {
    'id': id,
    'name': '科目$id',
    'faculties': <Object?>[],
    'year': 2026,
    'semester': 'H1',
    'credit': 2,
  };

  Map<String, Object?> _registration(String id) => {
    'id': 'registration-$id',
    'subject': _subject(id),
  };
}

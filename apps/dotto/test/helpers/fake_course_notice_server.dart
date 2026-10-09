import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import 'fake_http_client_adapter.dart';

/// HTTP 境界で科目と授業変更の応答を返す。
final class FakeCourseNoticeServer {
  new() {
    _adapter
      ..on(
        'GET',
        '/v1/courseRegistrations',
        (_) => FakeResponse(200, {
          'courseRegistrations': [
            for (final id in registeredSubjectIds)
              {'id': 'registration-$id', 'subject': subject(id)},
          ],
        }),
      )
      ..on(
        'GET',
        '/v1/cancelledClasses',
        (request) => response(request, 'cancelledClasses', cancellations),
      )
      ..on(
        'GET',
        '/v1/makeupClasses',
        (request) => response(request, 'makeupClasses', makeups),
      )
      ..on(
        'GET',
        '/v1/roomChanges',
        (request) => response(request, 'roomChanges', roomChanges),
      );
  }

  final _adapter = FakeHttpClientAdapter();
  List<String> registeredSubjectIds = ['s1'];
  bool shouldFail = false;
  List<Map<String, Object?>> cancellations = [
    cancellation('cancel-1', 's1'),
    cancellation('cancel-2', 's2'),
  ];
  List<Map<String, Object?>> makeups = [makeup('makeup-1', 's1')];
  List<Map<String, Object?>> roomChanges = [roomChange('change-1', 's1')];

  Openapi get apiClient => Openapi(dio: fakeDio(_adapter));

  FakeResponse response(
    RequestOptions request,
    String key,
    List<Map<String, Object?>> items,
  ) {
    if (shouldFail) return const FakeResponse(500);
    final rawFilter = request.uri.queryParameters['subjectIds'];
    final filter = rawFilter?.toString().split(',');
    return FakeResponse(200, {
      key: [
        for (final item in items)
          if (filter == null ||
              filter.contains((item['subject'] as Map?)?['id']))
            item,
      ],
    });
  }

  static Map<String, Object?> subject(String id) => {
    'id': id,
    'name': id == 's1' ? '数学' : '英語',
    'faculties': <Object>[],
    'year': 2026,
    'semester': 'H1',
    'credit': 2,
  };

  static Map<String, Object?> cancellation(String id, String subjectId) => {
    'id': id,
    'subject': subject(subjectId),
    'date': '2026-04-01',
    'period': 'Period1',
    'comment': '  休講連絡  ',
  };

  static Map<String, Object?> makeup(String id, String subjectId) => {
    'id': id,
    'subject': subject(subjectId),
    'date': '2026-04-02',
    'period': 'Period2',
    'comment': '補講連絡',
  };

  static Map<String, Object?> roomChange(String id, String subjectId) => {
    'id': id,
    'subject': subject(subjectId),
    'date': '2026-04-03',
    'period': 'Period3',
    'originalRoom': {'id': 'r1', 'name': 'R101', 'floor': 'Floor1'},
    'newRoom': {'id': 'r2', 'name': 'R202', 'floor': 'Floor2'},
  };
}

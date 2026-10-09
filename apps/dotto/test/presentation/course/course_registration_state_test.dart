import 'package:dotto/data/api_client.dart';
import 'package:dotto/presentation/course/course_registration_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_course_api.dart';
import '../../helpers/fake_http_client_adapter.dart';

void main() {
  test('時間割候補に履修登録状況を反映して表示できる', () async {
    final api = FakeCourseApi(registeredSubjectIds: {'b'});
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(api.adapter))),
      ],
    );
    addTearDown(container.dispose);

    final semesters = await container.read(
      courseRegistrationStateProvider.future,
    );

    for (final items in semesters.values) {
      expect(
        items
            .where((item) => item.isAddedToTimetable ?? false)
            .map((item) => item.subject.id),
        ['b'],
      );
    }
  });
}

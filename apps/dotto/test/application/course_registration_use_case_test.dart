import 'package:dotto/api/api_client.dart';
import 'package:dotto/application/register_course_use_case.dart';
import 'package:dotto/application/unregister_course_use_case.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

import '../helpers/fake_course_registration_api.dart';
import '../helpers/fake_http_client_adapter.dart';

void main() {
  test('履修登録と解除をAPIの登録結果へ反映する', () async {
    final api = FakeCourseRegistrationApi();
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(api.adapter))),
      ],
    );
    addTearDown(container.dispose);
    await container.read(registerCourseUseCaseProvider)('target');
    expect(api.registrations.keys, ['target']);
    await container.read(unregisterCourseUseCaseProvider)('target');
    expect(api.registrations, isEmpty);
  });
  test('同じコマに二科目登録されている場合は三科目目を登録しない', () async {
    final api = FakeCourseRegistrationApi(
      initialRegisteredIds: ['first', 'second'],
    );
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(api.adapter))),
      ],
    );
    addTearDown(container.dispose);
    await expectLater(
      container.read(registerCourseUseCaseProvider)('target'),
      throwsA(
        isA<DomainError>().having(
          (error) => error.type,
          '種別',
          DomainErrorType.invalidData,
        ),
      ),
    );
    expect(api.registrations.keys, ['first', 'second']);
  });
}

import 'dart:async';

import 'package:dotto/application/save_subject_feedback_use_case.dart';
import 'package:dotto/application/search_subjects_use_case.dart';
import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/data/past_exam_data_source.dart';
import 'package:dotto/data/subject_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/presentation/subject/past_exams_state.dart';
import 'package:dotto/presentation/subject/search_subject_state.dart';
import 'package:dotto/presentation/subject/subject_detail_state.dart';
import 'package:dotto/presentation/subject/subject_feedbacks_state.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart' as api;
import 'package:dotto_app_api/app/v1/subject.connect.spec.dart';
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;
import 'package:dotto_app_api/app/v1/timetable_item.connect.spec.dart';
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart' as api;
import 'package:dotto_app_api/google/type/dayofweek.pbenum.dart' as api;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_subject.dart';
import '../../helpers/fake_app_api_transport.dart';
import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_past_exam_data_source.dart';
import '../../helpers/fake_subject_data_source.dart';

void main() {
  test('科目詳細のシラバスとローカルの過去問IDを合わせて取得する', () async {
    final syllabus = apiSyllabus(id: '123', fields: {'summary': '授業概要'});
    final transport = FakeAppApiTransport()
      ..on(
        SubjectService.getSubject,
        (_) => api.GetSubjectResponse(
          subject: apiSubjectDetail(
            'subject',
            name: '科目詳細',
            syllabus: syllabus,
          ),
        ),
      );
    final container = ProviderContainer(
      overrides: [
        appApiTransportProvider.overrideWithValue(transport),
        subjectDataSourceProvider.overrideWithValue(FakeSubjectDataSource()),
      ],
    );
    addTearDown(container.dispose);
    final subject = await container.read(
      subjectDetailStateProvider('subject').future,
    );
    expect(subject.name, '科目詳細');
    expect(subject.syllabus.summary, '授業概要');
    expect(subject.pastExamId, 'past-123');
    expect(subject.faculties.clear, throwsUnsupportedError);
  });
  test('投稿したレビューを読み込み同じ利用者の再投稿で置き換える', () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        appApiTransportProvider.overrideWithValue(FakeAppApiTransport()),
        subjectDataSourceProvider.overrideWithValue(FakeSubjectDataSource()),
      ],
    );
    addTearDown(container.dispose);
    final save = container.read(saveSubjectFeedbackUseCaseProvider);
    await save(
      userId: 'user',
      lessonId: '123',
      feedback: SubjectFeedback(score: 3, comment: '最初'),
    );
    await save(
      userId: 'user',
      lessonId: '123',
      feedback: SubjectFeedback(score: 5, comment: '更新'),
    );
    final feedbacks = await container.read(
      subjectFeedbacksStateProvider('123').future,
    );
    expect(feedbacks.single, SubjectFeedback(score: 5, comment: '更新'));
    expect(feedbacks.clear, throwsUnsupportedError);
  });
  test('レビュー取得の失敗をドメインエラーで通知する', () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        appApiTransportProvider.overrideWithValue(FakeAppApiTransport()),
        subjectDataSourceProvider.overrideWithValue(
          FakeSubjectDataSource()..shouldFail = true,
        ),
      ],
    );
    addTearDown(container.dispose);
    await expectLater(
      container.read(subjectFeedbacksStateProvider('123').future),
      throwsA(isA<DomainError>()),
    );
  });
  test('過去問一覧を不変なコレクションとして読み込む', () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        pastExamDataSourceProvider.overrideWithValue(
          const FakePastExamDataSource({
            'past': ['past/exam.pdf'],
          }),
        ),
      ],
    );
    addTearDown(container.dispose);
    final exams = await container.read(pastExamsStateProvider('past').future);
    expect(exams, ['past/exam.pdf']);
    expect(exams.clear, throwsUnsupportedError);
  });
  test('科目検索に時間割のコマと現在の履修状態を合わせる', () async {
    final subject = apiSubjectSummary('subject', name: '科目');
    final transport = FakeAppApiTransport()
      ..on(
        SubjectService.listSubjects,
        (_) => api.ListSubjectsResponse(subjects: [subject]),
      )
      ..on(
        TimetableItemService.listTimetableItems,
        (_) => api.ListTimetableItemsResponse(
          timetableItems: [
            api.TimetableItem(
              id: 'item',
              subject: subject,
              slot: api.TimetableItemSlot(
                dayOfWeek: api.DayOfWeek.MONDAY,
                period: api.Period.PERIOD_1,
              ),
            ),
          ],
        ),
      )
      ..on(
        CourseRegistrationService.listCourseRegistrations,
        (_) => api.ListCourseRegistrationsResponse(
          courseRegistrations: [
            api.CourseRegistration(id: 'registration', subject: subject),
          ],
        ),
      );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        appApiTransportProvider.overrideWithValue(transport),
        subjectDataSourceProvider.overrideWithValue(FakeSubjectDataSource()),
      ],
    );
    addTearDown(container.dispose);
    final subjects = await container.read(searchSubjectsUseCaseProvider)(
      query: '科目',
      filter: const SubjectFilter(),
      isAuthenticated: true,
    );
    expect(subjects.single.isAddedToTimetable, isTrue);
    expect(subjects.single.slots, hasLength(1));
    expect(subjects.clear, throwsUnsupportedError);
  });
  test('後から実行した科目検索を遅い先行リクエストで上書きしない', () async {
    final requested = Completer<void>();
    final resume = Completer<void>();
    final transport = FakeAppApiTransport()
      ..on(SubjectService.listSubjects, (request) async {
        if (request.query == '遅い') {
          requested.complete();
          await resume.future;
        }
        return api.ListSubjectsResponse(
          subjects: [apiSubjectSummary(request.query, name: request.query)],
        );
      })
      ..on(
        TimetableItemService.listTimetableItems,
        (_) => api.ListTimetableItemsResponse(),
      );
    final container = ProviderContainer(
      overrides: [
        appApiTransportProvider.overrideWithValue(transport),
        authDataSourceProvider.overrideWithValue(FakeAuthDataSource()),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      searchSubjectStateProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    await container.read(searchSubjectStateProvider.future);
    final notifier = container.read(searchSubjectStateProvider.notifier);
    final first = notifier.search(query: '遅い', filter: const SubjectFilter());
    await requested.future;
    await notifier.search(query: '新しい', filter: const SubjectFilter());
    resume.complete();
    await first;
    expect(
      container.read(searchSubjectStateProvider).requireValue.single.name,
      '新しい',
    );
  });
}

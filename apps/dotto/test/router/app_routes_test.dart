import 'package:dotto/router/app_router.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('app routes', () {
    test('tab root locations match existing route names', () {
      expect(const CourseRouteData().location, '/course');
      expect(const FunchRouteData().location, '/funch');
      expect(const MapRouteData().location, '/map');
      expect(const BusRouteData().location, '/bus');
      expect(const SettingsRouteData().location, '/setting');
      expect(const SubjectsRouteData().location, '/subjects');
    });

    test('course nested route locations', () {
      expect(const CourseCustomizeRouteData().location, '/course/preferences');
      expect(
        const CourseRegistrationRouteData().location,
        '/course/personal-weekly-timetable',
      );
      expect(
        const CourseNoticeCancellationsRouteData().location,
        '/course/notice/cancellations',
      );
      expect(
        const CourseNoticeMakeupsRouteData().location,
        '/course/notice/makeups',
      );
      expect(
        const CourseNoticeRoomChangesRouteData().location,
        '/course/notice/room-changes',
      );
      expect(const CourseSubjectsRouteData().location, '/course/subjects');
      expect(
        const CourseSubjectSyllabusRouteData(id: 'subject-1').location,
        '/course/subjects/subject-1/syllabus',
      );
      expect(
        const CourseSubjectReviewsRouteData(id: 'subject-1').location,
        '/course/subjects/subject-1/reviews',
      );
      expect(
        const CourseSubjectReviewNewRouteData(id: 'subject-1').location,
        '/course/subjects/subject-1/reviews/new',
      );
      expect(
        const CourseSubjectPastExamsRouteData(id: 'subject-1').location,
        '/course/subjects/subject-1/past-exams',
      );
      expect(
        const CourseCalendarRouteData(year: 2026).location,
        '/course/calendars/2026',
      );
      expect(
        const CourseSpringTimetableRouteData(year: 2026).location,
        '/course/timetables/2026/spring',
      );
      expect(
        const CourseFallTimetableRouteData(year: 2026).location,
        '/course/timetables/2026/fall',
      );
    });

    test('map, bus and setting nested route locations', () {
      expect(const MapRoomRouteData(id: 'R-301').location, '/map/rooms/R-301');
      expect(const BusStopSelectRouteData().location, '/bus/stop-selection');
      expect(
        const BusTripRouteData(id: 'to_fun-weekday-3').location,
        '/bus/trips/to_fun-weekday-3',
      );
      expect(const AnnouncementsRouteData().location, '/setting/announcements');
      expect(
        const AnnouncementDetailRouteData(id: 'announcement-1').location,
        '/setting/announcements/announcement-1',
      );
      expect(const DevelopersRouteData().location, '/setting/developers');
      expect(
        const SettingOnboardingRouteData().location,
        '/setting/onboarding',
      );
      expect(const SettingsLicenseRouteData().location, '/setting/licenses');
      expect(const DebugRouteData().location, '/setting/debug');
    });

    test('path and query parameters are encoded', () {
      expect(
        const SubjectDetailRouteData(id: 'subject 1').location,
        '/subjects/subject%201',
      );
      expect(
        const CourseSubjectSyllabusRouteData(id: 'subject 1').location,
        '/course/subjects/subject%201/syllabus',
      );
      // 過去問のキーはスラッシュを含むため、1つのパスセグメントとして
      // エンコードされる。
      expect(
        const CourseSubjectPastExamRouteData(
          id: 'subject-1',
          pastExamId: '1234/2025_final.pdf',
        ).location,
        '/course/subjects/subject-1/past-exams/1234%2F2025_final.pdf',
      );
    });

    test('root deep links redirect to the default tab', () {
      final uri = Uri.parse('https://dotto.furari.co/');

      expect(appRedirectLocation(uri), const CourseRouteData().location);
    });

    test('deep links with app paths are not redirected', () {
      final uri = Uri.parse('https://dotto.furari.co/subjects/subject-1');

      expect(appRedirectLocation(uri), isNull);
    });
  });
}

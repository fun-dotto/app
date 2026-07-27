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

    test('nested route locations keep existing paths', () {
      expect(const CourseSubjectsRouteData().location, '/course/subjects');
      expect(
        const CourseCancellationRouteData().location,
        '/course/irregular_classes',
      );
      expect(
        const CourseRegistrationRouteData().location,
        '/course/registration',
      );
      expect(const CourseCustomizeRouteData().location, '/course/preferences');
    });

    test('setting routes are flattened to the top level', () {
      expect(const AnnouncementsRouteData().location, '/announcements');
      expect(const DevelopersRouteData().location, '/developers');
      expect(const SettingOnboardingRouteData().location, '/onboarding');
      expect(const SettingsLicenseRouteData().location, '/licenses');
      expect(const DebugRouteData().location, '/debug');
    });

    test('path and query parameters are encoded', () {
      expect(
        const SubjectDetailRouteData(id: 'subject 1').location,
        '/subjects/subject%201',
      );
      expect(
        const CourseSubjectDetailRouteData(id: 'subject 1').location,
        '/course/subjects/subject%201',
      );
      expect(
        const BusTimetableRouteData(route: 'L-1').location,
        '/bus/timetable?route=L-1',
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

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
      expect(const AnnouncementsRouteData().location, '/setting/announcements');
      expect(const DevelopersRouteData().location, '/setting/developers');
      expect(const SettingsLicenseRouteData().location, '/setting/licenses');
      expect(const DebugRouteData().location, '/setting/debug');
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
  });
}

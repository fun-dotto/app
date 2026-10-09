// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get rootUpdateRequired => 'Update required';

  @override
  String get rootLater => 'Later';

  @override
  String get rootUpdateNow => 'Update now';

  @override
  String get rootEnableNotifications => 'Enable notifications?';

  @override
  String get rootOpenSettings => 'Open settings';

  @override
  String get rootNotificationDenied =>
      'Notifications are denied. Enable notifications in system settings to receive class cancellation, makeup class and room change announcements.';

  @override
  String get rootNotificationProvisional =>
      'Only quiet notifications are allowed. Enable notifications in system settings to receive banners and sounds for class announcements.';

  @override
  String get rootNotificationAlertDisabled =>
      'Notification banners are disabled. Enable banners in system settings to receive class announcements prominently.';

  @override
  String rootVersionComparison(String currentVersion, String latestVersion) {
    return 'Current version: $currentVersion\nLatest version: $latestVersion';
  }

  @override
  String get busTitle => 'Bus';

  @override
  String get busStopSelectTitle => 'Select a bus stop';

  @override
  String get busTimetableTitle => 'Bus timetable';

  @override
  String get busWeekday => 'Weekdays';

  @override
  String get busHoliday => 'Holidays';

  @override
  String get busError => 'An error occurred';

  @override
  String get busTripNotFound => 'This trip could not be found.';

  @override
  String get busLoadError => 'Failed to load data.';

  @override
  String get busServiceEnded => 'Service has ended for today.';

  @override
  String get busUniversity => 'Future University Hakodate';

  @override
  String get busKameda => 'Kameda branch office';

  @override
  String busFromLandmark(String landmark) {
    return 'From $landmark';
  }

  @override
  String busToLandmark(String landmark) {
    return 'To $landmark';
  }

  @override
  String busTerminal(String terminal) {
    return 'Stop $terminal';
  }

  @override
  String get busLandmarkKameda => 'Kameda branch office';

  @override
  String get busLandmarkGoryokaku => 'Goryokaku';

  @override
  String get busLandmarkShowa => 'Showa';

  @override
  String get mapTitle => 'Map';

  @override
  String get mapSearchHint => 'Search rooms, teachers, or email addresses';

  @override
  String get mapNoResults => 'No results found';

  @override
  String get mapSearchError => 'Failed to load search results';

  @override
  String get mapLoading => 'Loading...';

  @override
  String get mapError => 'An error occurred';

  @override
  String get mapInUse => 'In use';

  @override
  String get mapRestrooms => 'Restrooms and kitchenettes';

  @override
  String get mapLoginDetails =>
      'Sign in with your Google account (@fun.ac.jp) to view details';

  @override
  String get mapGoToSettings => 'Go to settings';

  @override
  String get mapFood => 'Food';

  @override
  String get mapDrink => 'Drink';

  @override
  String get mapOutlet => 'Power outlets';

  @override
  String get mapCurrentTime => 'Now';

  @override
  String mapPeriod(int number) {
    return 'Period $number';
  }

  @override
  String get funchTitle => 'Cafeteria';

  @override
  String get funchNotice => 'Menus may change.';

  @override
  String get funchEmpty => 'No menu information available.';

  @override
  String get funchCategoryEmpty => 'No menus in this category.';

  @override
  String get funchSet => 'Set meals';

  @override
  String get funchDonCurry => 'Rice bowls and curry';

  @override
  String get funchNoodle => 'Noodles';

  @override
  String get funchSideDish => 'Side dishes';

  @override
  String get funchDessert => 'Desserts';

  @override
  String get funchLarge => 'L';

  @override
  String get funchMedium => 'M';

  @override
  String get funchSmall => 'S';

  @override
  String funchToday(String date) {
    return 'Cafeteria on $date';
  }

  @override
  String get pdfShareFailed => 'Could not share the PDF. Please try again.';

  @override
  String get subjectClearFilters => 'Clear filters';

  @override
  String get subjectSemesterRequirementsAndClassification =>
      'Semester, requirements and classification';

  @override
  String get subjectSemester => 'Semester';

  @override
  String get subjectRequirements => 'Requirements';

  @override
  String get subjectClassification => 'Classification';

  @override
  String get subjectCulturalCategory => 'Cultural category';

  @override
  String get subjectCoursesGradesAndClasses => 'Courses, grades and classes';

  @override
  String get subjectCoursesAndAreas => 'Courses and areas';

  @override
  String get subjectGrades => 'Grades';

  @override
  String get subjectClasses => 'Classes';

  @override
  String get subjectPostFeedback => 'Post feedback';

  @override
  String get subjectSelectARating => 'Select a rating.';

  @override
  String get subjectCouldNotSubmitFeedback => 'Could not submit feedback.';

  @override
  String get subjectSubmit => 'Submit';

  @override
  String get subjectTapToRate => 'Tap to rate:';

  @override
  String get subjectComment => 'Comment';

  @override
  String get subjectCreditsAttendanceExamsEtc =>
      'Credits, attendance, exams, etc.';

  @override
  String get subjectSignInWithAGoogleAccountFunAcJp =>
      'Sign in with a Google account (@fun.ac.jp).';

  @override
  String get subjectNoPastExamsAvailable => 'No past exams available';

  @override
  String get subjectNoFeedbackYet => 'No feedback yet';

  @override
  String get subjectSignInWithAGoogleAccountFunAcJpPrompt =>
      'Sign in with a Google account (@fun.ac.jp).';

  @override
  String get subjectFeedbackSubmitted => 'Feedback submitted.';

  @override
  String get subjectOutOf5 => 'out of 5';

  @override
  String get subjectSummary => 'Summary';

  @override
  String get subjectLearningOutcomes => 'Learning outcomes';

  @override
  String get subjectAssignments => 'Assignments';

  @override
  String get subjectEvaluationMethodsAndCriteria =>
      'Evaluation methods and criteria';

  @override
  String get subjectTextbooks => 'Textbooks';

  @override
  String get subjectReferenceBooks => 'Reference books';

  @override
  String get subjectPrerequisites => 'Prerequisites';

  @override
  String get subjectPreLearning => 'Pre-learning';

  @override
  String get subjectPostLearning => 'Post-learning';

  @override
  String get subjectNotes => 'Notes';

  @override
  String get subjectKeywords => 'Keywords';

  @override
  String get subjectTargetCoursesAndAreas => 'Target courses and areas';

  @override
  String get subjectTargetAreas => 'Target areas';

  @override
  String get subjectClassificationPrompt => 'Classification';

  @override
  String get subjectTeachingLanguage => 'Teaching language';

  @override
  String get subjectContentsAndSchedule => 'Contents and schedule';

  @override
  String get subjectTeachingAndExamFormat => 'Teaching and exam format';

  @override
  String get subjectDSOPSubject => 'DSOP subject';

  @override
  String get subjectCourseRegistrationFailed => 'Course registration failed.';

  @override
  String get subjectSubjectSearch => 'Subject search';

  @override
  String get subjectSearchBySubjectName => 'Search by subject name';

  @override
  String get subjectUnregister => 'Unregister';

  @override
  String get subjectRegister => 'Register';

  @override
  String get subjectNoSubjectsFound => 'No subjects found';

  @override
  String get subjectSubjectSearchFailed => 'Subject search failed.';

  @override
  String get subjectSyllabus => 'Syllabus';

  @override
  String get subjectReviews => 'Reviews';

  @override
  String get subjectPastExams => 'Past exams';

  @override
  String get subjectCouldNotLoadSubjectInformation =>
      'Could not load subject information.';

  @override
  String subjectOtherFacultyCount(String name, int count) {
    return '$name and $count others';
  }

  @override
  String subjectCredits(int credits) {
    return '$credits credits';
  }

  @override
  String subjectFeedbackCount(int count) {
    return '$count reviews';
  }
}

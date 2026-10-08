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
}

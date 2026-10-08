import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @login.
  ///
  /// In ja, this message translates to:
  /// **'ログイン'**
  String get login;

  /// No description provided for @rootUpdateRequired.
  ///
  /// In ja, this message translates to:
  /// **'アップデートが必要です'**
  String get rootUpdateRequired;

  /// No description provided for @rootLater.
  ///
  /// In ja, this message translates to:
  /// **'あとで'**
  String get rootLater;

  /// No description provided for @rootUpdateNow.
  ///
  /// In ja, this message translates to:
  /// **'今すぐアップデート'**
  String get rootUpdateNow;

  /// No description provided for @rootEnableNotifications.
  ///
  /// In ja, this message translates to:
  /// **'通知を有効にしますか？'**
  String get rootEnableNotifications;

  /// No description provided for @rootOpenSettings.
  ///
  /// In ja, this message translates to:
  /// **'設定を開く'**
  String get rootOpenSettings;

  /// No description provided for @rootNotificationDenied.
  ///
  /// In ja, this message translates to:
  /// **'通知が拒否されています。休講・補講・教室変更などのお知らせを受け取るには、設定アプリから通知を許可してください。'**
  String get rootNotificationDenied;

  /// No description provided for @rootNotificationProvisional.
  ///
  /// In ja, this message translates to:
  /// **'現在は静かな配信のみ許可されています。休講・補講・教室変更などのお知らせをバナーやサウンドで受け取るには、設定アプリから通知を許可してください。'**
  String get rootNotificationProvisional;

  /// No description provided for @rootNotificationAlertDisabled.
  ///
  /// In ja, this message translates to:
  /// **'通知バナーが無効になっています。休講・補講・教室変更などのお知らせを目立つ形で受け取るには、設定アプリから通知バナーを有効にしてください。'**
  String get rootNotificationAlertDisabled;

  /// No description provided for @rootVersionComparison.
  ///
  /// In ja, this message translates to:
  /// **'現在のバージョン: {currentVersion}\n最新バージョン: {latestVersion}'**
  String rootVersionComparison(String currentVersion, String latestVersion);

  /// No description provided for @busTitle.
  ///
  /// In ja, this message translates to:
  /// **'バス'**
  String get busTitle;

  /// No description provided for @busStopSelectTitle.
  ///
  /// In ja, this message translates to:
  /// **'バス停選択'**
  String get busStopSelectTitle;

  /// No description provided for @busTimetableTitle.
  ///
  /// In ja, this message translates to:
  /// **'バス時刻表'**
  String get busTimetableTitle;

  /// No description provided for @busWeekday.
  ///
  /// In ja, this message translates to:
  /// **'平日'**
  String get busWeekday;

  /// No description provided for @busHoliday.
  ///
  /// In ja, this message translates to:
  /// **'休日'**
  String get busHoliday;

  /// No description provided for @busError.
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました'**
  String get busError;

  /// No description provided for @busTripNotFound.
  ///
  /// In ja, this message translates to:
  /// **'この便の情報が見つかりませんでした。'**
  String get busTripNotFound;

  /// No description provided for @busLoadError.
  ///
  /// In ja, this message translates to:
  /// **'データの取得に失敗しました。'**
  String get busLoadError;

  /// No description provided for @busServiceEnded.
  ///
  /// In ja, this message translates to:
  /// **'今日の運行は終了しました。'**
  String get busServiceEnded;

  /// No description provided for @busUniversity.
  ///
  /// In ja, this message translates to:
  /// **'はこだて未来大学'**
  String get busUniversity;

  /// No description provided for @busKameda.
  ///
  /// In ja, this message translates to:
  /// **'亀田支所前'**
  String get busKameda;

  /// No description provided for @busFromLandmark.
  ///
  /// In ja, this message translates to:
  /// **'{landmark}から'**
  String busFromLandmark(String landmark);

  /// No description provided for @busToLandmark.
  ///
  /// In ja, this message translates to:
  /// **'{landmark}行き'**
  String busToLandmark(String landmark);

  /// No description provided for @busTerminal.
  ///
  /// In ja, this message translates to:
  /// **'{terminal}番乗り場'**
  String busTerminal(String terminal);

  /// No description provided for @busLandmarkKameda.
  ///
  /// In ja, this message translates to:
  /// **'亀田支所'**
  String get busLandmarkKameda;

  /// No description provided for @busLandmarkGoryokaku.
  ///
  /// In ja, this message translates to:
  /// **'五稜郭'**
  String get busLandmarkGoryokaku;

  /// No description provided for @busLandmarkShowa.
  ///
  /// In ja, this message translates to:
  /// **'昭和'**
  String get busLandmarkShowa;

  /// No description provided for @mapTitle.
  ///
  /// In ja, this message translates to:
  /// **'マップ'**
  String get mapTitle;

  /// No description provided for @mapSearchHint.
  ///
  /// In ja, this message translates to:
  /// **'部屋名、教員名、メールアドレスで検索'**
  String get mapSearchHint;

  /// No description provided for @mapNoResults.
  ///
  /// In ja, this message translates to:
  /// **'見つかりませんでした'**
  String get mapNoResults;

  /// No description provided for @mapSearchError.
  ///
  /// In ja, this message translates to:
  /// **'検索結果の取得に失敗しました'**
  String get mapSearchError;

  /// No description provided for @mapLoading.
  ///
  /// In ja, this message translates to:
  /// **'読み込み中...'**
  String get mapLoading;

  /// No description provided for @mapError.
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました'**
  String get mapError;

  /// No description provided for @mapInUse.
  ///
  /// In ja, this message translates to:
  /// **'使用中'**
  String get mapInUse;

  /// No description provided for @mapRestrooms.
  ///
  /// In ja, this message translates to:
  /// **'トイレ・給湯室'**
  String get mapRestrooms;

  /// No description provided for @mapLoginDetails.
  ///
  /// In ja, this message translates to:
  /// **'Googleアカウント (@fun.ac.jp) でログインして詳細を確認'**
  String get mapLoginDetails;

  /// No description provided for @mapGoToSettings.
  ///
  /// In ja, this message translates to:
  /// **'設定に移動する'**
  String get mapGoToSettings;

  /// No description provided for @mapFood.
  ///
  /// In ja, this message translates to:
  /// **'食べ物'**
  String get mapFood;

  /// No description provided for @mapDrink.
  ///
  /// In ja, this message translates to:
  /// **'飲み物'**
  String get mapDrink;

  /// No description provided for @mapOutlet.
  ///
  /// In ja, this message translates to:
  /// **'コンセント'**
  String get mapOutlet;

  /// No description provided for @mapCurrentTime.
  ///
  /// In ja, this message translates to:
  /// **'現在'**
  String get mapCurrentTime;

  /// No description provided for @mapPeriod.
  ///
  /// In ja, this message translates to:
  /// **'{number}限'**
  String mapPeriod(int number);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

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

  /// No description provided for @funchTitle.
  ///
  /// In ja, this message translates to:
  /// **'学食'**
  String get funchTitle;

  /// No description provided for @funchNotice.
  ///
  /// In ja, this message translates to:
  /// **'メニューは変更される可能性があります'**
  String get funchNotice;

  /// No description provided for @funchEmpty.
  ///
  /// In ja, this message translates to:
  /// **'情報が見つかりません'**
  String get funchEmpty;

  /// No description provided for @funchCategoryEmpty.
  ///
  /// In ja, this message translates to:
  /// **'このカテゴリーのメニューはありません。'**
  String get funchCategoryEmpty;

  /// No description provided for @funchSet.
  ///
  /// In ja, this message translates to:
  /// **'セット・単品'**
  String get funchSet;

  /// No description provided for @funchDonCurry.
  ///
  /// In ja, this message translates to:
  /// **'丼・カレー'**
  String get funchDonCurry;

  /// No description provided for @funchNoodle.
  ///
  /// In ja, this message translates to:
  /// **'麺'**
  String get funchNoodle;

  /// No description provided for @funchSideDish.
  ///
  /// In ja, this message translates to:
  /// **'副菜'**
  String get funchSideDish;

  /// No description provided for @funchDessert.
  ///
  /// In ja, this message translates to:
  /// **'デザート'**
  String get funchDessert;

  /// No description provided for @funchLarge.
  ///
  /// In ja, this message translates to:
  /// **'大'**
  String get funchLarge;

  /// No description provided for @funchMedium.
  ///
  /// In ja, this message translates to:
  /// **'中'**
  String get funchMedium;

  /// No description provided for @funchSmall.
  ///
  /// In ja, this message translates to:
  /// **'小'**
  String get funchSmall;

  /// No description provided for @funchToday.
  ///
  /// In ja, this message translates to:
  /// **'{date}の学食'**
  String funchToday(String date);

  /// No description provided for @pdfShareFailed.
  ///
  /// In ja, this message translates to:
  /// **'PDFの共有に失敗しました。もう一度お試しください。'**
  String get pdfShareFailed;

  /// No description provided for @subjectClearFilters.
  ///
  /// In ja, this message translates to:
  /// **'条件をクリア'**
  String get subjectClearFilters;

  /// No description provided for @subjectSemesterRequirementsAndClassification.
  ///
  /// In ja, this message translates to:
  /// **'開講時期・必修/選択・分類'**
  String get subjectSemesterRequirementsAndClassification;

  /// No description provided for @subjectSemester.
  ///
  /// In ja, this message translates to:
  /// **'開講時期'**
  String get subjectSemester;

  /// No description provided for @subjectRequirements.
  ///
  /// In ja, this message translates to:
  /// **'必修/選択'**
  String get subjectRequirements;

  /// No description provided for @subjectClassification.
  ///
  /// In ja, this message translates to:
  /// **'分類'**
  String get subjectClassification;

  /// No description provided for @subjectCulturalCategory.
  ///
  /// In ja, this message translates to:
  /// **'教養区分'**
  String get subjectCulturalCategory;

  /// No description provided for @subjectCoursesGradesAndClasses.
  ///
  /// In ja, this message translates to:
  /// **'コース/領域・学年・クラス'**
  String get subjectCoursesGradesAndClasses;

  /// No description provided for @subjectCoursesAndAreas.
  ///
  /// In ja, this message translates to:
  /// **'コース/領域'**
  String get subjectCoursesAndAreas;

  /// No description provided for @subjectGrades.
  ///
  /// In ja, this message translates to:
  /// **'学年'**
  String get subjectGrades;

  /// No description provided for @subjectClasses.
  ///
  /// In ja, this message translates to:
  /// **'クラス'**
  String get subjectClasses;

  /// No description provided for @subjectPostFeedback.
  ///
  /// In ja, this message translates to:
  /// **'フィードバックを投稿'**
  String get subjectPostFeedback;

  /// No description provided for @subjectSelectARating.
  ///
  /// In ja, this message translates to:
  /// **'満足度を入力してください。'**
  String get subjectSelectARating;

  /// No description provided for @subjectCouldNotSubmitFeedback.
  ///
  /// In ja, this message translates to:
  /// **'フィードバックの投稿に失敗しました。'**
  String get subjectCouldNotSubmitFeedback;

  /// No description provided for @subjectSubmit.
  ///
  /// In ja, this message translates to:
  /// **'投稿する'**
  String get subjectSubmit;

  /// No description provided for @subjectTapToRate.
  ///
  /// In ja, this message translates to:
  /// **'タップして評価:'**
  String get subjectTapToRate;

  /// No description provided for @subjectComment.
  ///
  /// In ja, this message translates to:
  /// **'コメント'**
  String get subjectComment;

  /// No description provided for @subjectCreditsAttendanceExamsEtc.
  ///
  /// In ja, this message translates to:
  /// **'単位、出席、テストの情報など...'**
  String get subjectCreditsAttendanceExamsEtc;

  /// No description provided for @subjectSignInWithAGoogleAccountFunAcJp.
  ///
  /// In ja, this message translates to:
  /// **'Googleアカウント (@fun.ac.jp) による認証が必要です'**
  String get subjectSignInWithAGoogleAccountFunAcJp;

  /// No description provided for @subjectNoPastExamsAvailable.
  ///
  /// In ja, this message translates to:
  /// **'過去問はありません'**
  String get subjectNoPastExamsAvailable;

  /// No description provided for @subjectNoFeedbackYet.
  ///
  /// In ja, this message translates to:
  /// **'フィードバックがありません'**
  String get subjectNoFeedbackYet;

  /// No description provided for @subjectSignInWithAGoogleAccountFunAcJpPrompt.
  ///
  /// In ja, this message translates to:
  /// **'Googleアカウント (@fun.ac.jp) による認証が必要です。'**
  String get subjectSignInWithAGoogleAccountFunAcJpPrompt;

  /// No description provided for @subjectFeedbackSubmitted.
  ///
  /// In ja, this message translates to:
  /// **'フィードバックを投稿しました。'**
  String get subjectFeedbackSubmitted;

  /// No description provided for @subjectOutOf5.
  ///
  /// In ja, this message translates to:
  /// **'5段階評価中'**
  String get subjectOutOf5;

  /// No description provided for @subjectSummary.
  ///
  /// In ja, this message translates to:
  /// **'概要'**
  String get subjectSummary;

  /// No description provided for @subjectLearningOutcomes.
  ///
  /// In ja, this message translates to:
  /// **'到達目標'**
  String get subjectLearningOutcomes;

  /// No description provided for @subjectAssignments.
  ///
  /// In ja, this message translates to:
  /// **'提出課題等'**
  String get subjectAssignments;

  /// No description provided for @subjectEvaluationMethodsAndCriteria.
  ///
  /// In ja, this message translates to:
  /// **'評価方法・基準'**
  String get subjectEvaluationMethodsAndCriteria;

  /// No description provided for @subjectTextbooks.
  ///
  /// In ja, this message translates to:
  /// **'テキスト'**
  String get subjectTextbooks;

  /// No description provided for @subjectReferenceBooks.
  ///
  /// In ja, this message translates to:
  /// **'参考書'**
  String get subjectReferenceBooks;

  /// No description provided for @subjectPrerequisites.
  ///
  /// In ja, this message translates to:
  /// **'履修条件'**
  String get subjectPrerequisites;

  /// No description provided for @subjectPreLearning.
  ///
  /// In ja, this message translates to:
  /// **'事前学習'**
  String get subjectPreLearning;

  /// No description provided for @subjectPostLearning.
  ///
  /// In ja, this message translates to:
  /// **'事後学習'**
  String get subjectPostLearning;

  /// No description provided for @subjectNotes.
  ///
  /// In ja, this message translates to:
  /// **'履修上の留意点'**
  String get subjectNotes;

  /// No description provided for @subjectKeywords.
  ///
  /// In ja, this message translates to:
  /// **'キーワード'**
  String get subjectKeywords;

  /// No description provided for @subjectTargetCoursesAndAreas.
  ///
  /// In ja, this message translates to:
  /// **'対象コース・領域'**
  String get subjectTargetCoursesAndAreas;

  /// No description provided for @subjectTargetAreas.
  ///
  /// In ja, this message translates to:
  /// **'対象領域'**
  String get subjectTargetAreas;

  /// No description provided for @subjectClassificationPrompt.
  ///
  /// In ja, this message translates to:
  /// **'科目群・科目区分'**
  String get subjectClassificationPrompt;

  /// No description provided for @subjectTeachingLanguage.
  ///
  /// In ja, this message translates to:
  /// **'教授言語'**
  String get subjectTeachingLanguage;

  /// No description provided for @subjectContentsAndSchedule.
  ///
  /// In ja, this message translates to:
  /// **'授業内容とスケジュール'**
  String get subjectContentsAndSchedule;

  /// No description provided for @subjectTeachingAndExamFormat.
  ///
  /// In ja, this message translates to:
  /// **'授業・試験の形式'**
  String get subjectTeachingAndExamFormat;

  /// No description provided for @subjectDSOPSubject.
  ///
  /// In ja, this message translates to:
  /// **'DSOP対象科目'**
  String get subjectDSOPSubject;

  /// No description provided for @subjectCourseRegistrationFailed.
  ///
  /// In ja, this message translates to:
  /// **'履修登録の更新に失敗しました'**
  String get subjectCourseRegistrationFailed;

  /// No description provided for @subjectSubjectSearch.
  ///
  /// In ja, this message translates to:
  /// **'科目検索'**
  String get subjectSubjectSearch;

  /// No description provided for @subjectSearchBySubjectName.
  ///
  /// In ja, this message translates to:
  /// **'科目名で検索'**
  String get subjectSearchBySubjectName;

  /// No description provided for @subjectUnregister.
  ///
  /// In ja, this message translates to:
  /// **'履修解除'**
  String get subjectUnregister;

  /// No description provided for @subjectRegister.
  ///
  /// In ja, this message translates to:
  /// **'履修登録'**
  String get subjectRegister;

  /// No description provided for @subjectNoSubjectsFound.
  ///
  /// In ja, this message translates to:
  /// **'科目が見つかりませんでした'**
  String get subjectNoSubjectsFound;

  /// No description provided for @subjectSubjectSearchFailed.
  ///
  /// In ja, this message translates to:
  /// **'科目の検索に失敗しました。'**
  String get subjectSubjectSearchFailed;

  /// No description provided for @subjectSyllabus.
  ///
  /// In ja, this message translates to:
  /// **'シラバス'**
  String get subjectSyllabus;

  /// No description provided for @subjectReviews.
  ///
  /// In ja, this message translates to:
  /// **'レビュー'**
  String get subjectReviews;

  /// No description provided for @subjectPastExams.
  ///
  /// In ja, this message translates to:
  /// **'過去問'**
  String get subjectPastExams;

  /// No description provided for @subjectCouldNotLoadSubjectInformation.
  ///
  /// In ja, this message translates to:
  /// **'科目情報の読み込みに失敗しました。'**
  String get subjectCouldNotLoadSubjectInformation;

  /// No description provided for @subjectOtherFacultyCount.
  ///
  /// In ja, this message translates to:
  /// **'{name} 他{count}名'**
  String subjectOtherFacultyCount(String name, int count);

  /// No description provided for @subjectCredits.
  ///
  /// In ja, this message translates to:
  /// **'{credits}単位'**
  String subjectCredits(int credits);

  /// No description provided for @subjectFeedbackCount.
  ///
  /// In ja, this message translates to:
  /// **'{count}件のフィードバック'**
  String subjectFeedbackCount(int count);

  /// No description provided for @courseTitle.
  ///
  /// In ja, this message translates to:
  /// **'講義'**
  String get courseTitle;

  /// No description provided for @courseSearch.
  ///
  /// In ja, this message translates to:
  /// **'科目検索'**
  String get courseSearch;

  /// No description provided for @courseNotices.
  ///
  /// In ja, this message translates to:
  /// **'休講・補講'**
  String get courseNotices;

  /// No description provided for @courseAcademicCalendar.
  ///
  /// In ja, this message translates to:
  /// **'学年歴'**
  String get courseAcademicCalendar;

  /// No description provided for @courseCalendarDocument.
  ///
  /// In ja, this message translates to:
  /// **'学年暦'**
  String get courseCalendarDocument;

  /// No description provided for @courseSpringTimetable.
  ///
  /// In ja, this message translates to:
  /// **'時間割 前期'**
  String get courseSpringTimetable;

  /// No description provided for @courseFallTimetable.
  ///
  /// In ja, this message translates to:
  /// **'時間割 後期'**
  String get courseFallTimetable;

  /// No description provided for @courseHope.
  ///
  /// In ja, this message translates to:
  /// **'HOPE'**
  String get courseHope;

  /// No description provided for @courseStudentPortal.
  ///
  /// In ja, this message translates to:
  /// **'学生ポータル'**
  String get courseStudentPortal;

  /// No description provided for @courseDottoWeb.
  ///
  /// In ja, this message translates to:
  /// **'Dotto Web'**
  String get courseDottoWeb;

  /// No description provided for @courseMacSupport.
  ///
  /// In ja, this message translates to:
  /// **'Macサポート'**
  String get courseMacSupport;

  /// No description provided for @courseOpinionBox.
  ///
  /// In ja, this message translates to:
  /// **'大学ポスト'**
  String get courseOpinionBox;

  /// No description provided for @courseWeeklyTimetable.
  ///
  /// In ja, this message translates to:
  /// **'1週間の時間割'**
  String get courseWeeklyTimetable;

  /// No description provided for @courseSignIn.
  ///
  /// In ja, this message translates to:
  /// **'ログインして時間割機能を使う'**
  String get courseSignIn;

  /// No description provided for @courseFetchError.
  ///
  /// In ja, this message translates to:
  /// **'データの取得に失敗しました'**
  String get courseFetchError;

  /// No description provided for @courseCustomize.
  ///
  /// In ja, this message translates to:
  /// **'カスタム'**
  String get courseCustomize;

  /// No description provided for @courseShowTime.
  ///
  /// In ja, this message translates to:
  /// **'時間割に時刻を表示'**
  String get courseShowTime;

  /// No description provided for @coursePreferenceError.
  ///
  /// In ja, this message translates to:
  /// **'ユーザー設定の読み込みに失敗しました'**
  String get coursePreferenceError;

  /// No description provided for @courseRegistration.
  ///
  /// In ja, this message translates to:
  /// **'科目登録'**
  String get courseRegistration;

  /// No description provided for @courseNoSubjects.
  ///
  /// In ja, this message translates to:
  /// **'対象の科目はありません'**
  String get courseNoSubjects;

  /// No description provided for @courseRemove.
  ///
  /// In ja, this message translates to:
  /// **'削除'**
  String get courseRemove;

  /// No description provided for @courseAdd.
  ///
  /// In ja, this message translates to:
  /// **'追加'**
  String get courseAdd;

  /// No description provided for @courseSlotFull.
  ///
  /// In ja, this message translates to:
  /// **'1つのコマに2科目以上を設定できません'**
  String get courseSlotFull;

  /// No description provided for @courseRegistrationError.
  ///
  /// In ja, this message translates to:
  /// **'履修登録の更新に失敗しました'**
  String get courseRegistrationError;

  /// No description provided for @courseLinkError.
  ///
  /// In ja, this message translates to:
  /// **'{label} を開けませんでした'**
  String courseLinkError(String label);

  /// No description provided for @courseDocumentName.
  ///
  /// In ja, this message translates to:
  /// **'{year}年度 {label}'**
  String courseDocumentName(int year, String label);

  /// No description provided for @courseSlotTitle.
  ///
  /// In ja, this message translates to:
  /// **'{semester} {day}曜{period}限'**
  String courseSlotTitle(String semester, String day, int period);

  /// No description provided for @courseNoticeTitle.
  ///
  /// In ja, this message translates to:
  /// **'休講・補講・教室変更'**
  String get courseNoticeTitle;

  /// No description provided for @courseNoticeSignInRequired.
  ///
  /// In ja, this message translates to:
  /// **'Googleアカウント(@fun.ac.jp)ログインが必要です。'**
  String get courseNoticeSignInRequired;

  /// No description provided for @courseNoticeRegistered.
  ///
  /// In ja, this message translates to:
  /// **'履修中'**
  String get courseNoticeRegistered;

  /// No description provided for @courseNoticeAll.
  ///
  /// In ja, this message translates to:
  /// **'すべて'**
  String get courseNoticeAll;

  /// No description provided for @courseNoticeCancellation.
  ///
  /// In ja, this message translates to:
  /// **'休講'**
  String get courseNoticeCancellation;

  /// No description provided for @courseNoticeMakeup.
  ///
  /// In ja, this message translates to:
  /// **'補講'**
  String get courseNoticeMakeup;

  /// No description provided for @courseNoticeRoomChange.
  ///
  /// In ja, this message translates to:
  /// **'教室変更'**
  String get courseNoticeRoomChange;

  /// No description provided for @courseNoticeEmptyCancellation.
  ///
  /// In ja, this message translates to:
  /// **'休講はありません。'**
  String get courseNoticeEmptyCancellation;

  /// No description provided for @courseNoticeEmptyMakeup.
  ///
  /// In ja, this message translates to:
  /// **'補講はありません。'**
  String get courseNoticeEmptyMakeup;

  /// No description provided for @courseNoticeEmptyRoomChange.
  ///
  /// In ja, this message translates to:
  /// **'教室変更はありません。'**
  String get courseNoticeEmptyRoomChange;

  /// No description provided for @courseNoticeLoadError.
  ///
  /// In ja, this message translates to:
  /// **'データの取得に失敗しました。'**
  String get courseNoticeLoadError;

  /// No description provided for @courseNoticePeriod.
  ///
  /// In ja, this message translates to:
  /// **'{period}限'**
  String courseNoticePeriod(int period);
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

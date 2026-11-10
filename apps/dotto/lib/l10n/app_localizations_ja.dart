// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get login => 'ログイン';

  @override
  String get rootUpdateRequired => 'アップデートが必要です';

  @override
  String get rootLater => 'あとで';

  @override
  String get rootUpdateNow => '今すぐアップデート';

  @override
  String get rootEnableNotifications => '通知を有効にしますか？';

  @override
  String get rootOpenSettings => '設定を開く';

  @override
  String get rootNotificationDenied =>
      '通知が拒否されています。休講・補講・教室変更などのお知らせを受け取るには、設定アプリから通知を許可してください。';

  @override
  String get rootNotificationProvisional =>
      '現在は静かな配信のみ許可されています。休講・補講・教室変更などのお知らせをバナーやサウンドで受け取るには、設定アプリから通知を許可してください。';

  @override
  String get rootNotificationAlertDisabled =>
      '通知バナーが無効になっています。休講・補講・教室変更などのお知らせを目立つ形で受け取るには、設定アプリから通知バナーを有効にしてください。';

  @override
  String rootVersionComparison(String currentVersion, String latestVersion) {
    return '現在のバージョン: $currentVersion\n最新バージョン: $latestVersion';
  }

  @override
  String get busTitle => 'バス';

  @override
  String get busStopSelectTitle => 'バス停選択';

  @override
  String get busTimetableTitle => 'バス時刻表';

  @override
  String get busWeekday => '平日';

  @override
  String get busHoliday => '休日';

  @override
  String get busError => 'エラーが発生しました';

  @override
  String get busTripNotFound => 'この便の情報が見つかりませんでした。';

  @override
  String get busLoadError => 'データの取得に失敗しました。';

  @override
  String get busServiceEnded => '今日の運行は終了しました。';

  @override
  String get busUniversity => 'はこだて未来大学';

  @override
  String get busKameda => '亀田支所前';

  @override
  String busFromLandmark(String landmark) {
    return '$landmarkから';
  }

  @override
  String busToLandmark(String landmark) {
    return '$landmark行き';
  }

  @override
  String busTerminal(String terminal) {
    return '$terminal番乗り場';
  }

  @override
  String get busLandmarkKameda => '亀田支所';

  @override
  String get busLandmarkGoryokaku => '五稜郭';

  @override
  String get busLandmarkShowa => '昭和';

  @override
  String get mapTitle => 'マップ';

  @override
  String get mapSearchHint => '部屋名、教員名、メールアドレスで検索';

  @override
  String get mapNoResults => '見つかりませんでした';

  @override
  String get mapSearchError => '検索結果の取得に失敗しました';

  @override
  String get mapLoading => '読み込み中...';

  @override
  String get mapError => 'エラーが発生しました';

  @override
  String get mapInUse => '使用中';

  @override
  String get mapRestrooms => 'トイレ・給湯室';

  @override
  String get mapLoginDetails => 'Googleアカウント (@fun.ac.jp) でログインして詳細を確認';

  @override
  String get mapGoToSettings => '設定に移動する';

  @override
  String get mapFood => '食べ物';

  @override
  String get mapDrink => '飲み物';

  @override
  String get mapOutlet => 'コンセント';

  @override
  String get mapCurrentTime => '現在';

  @override
  String mapPeriod(int number) {
    return '$number限';
  }

  @override
  String get funchTitle => '学食';

  @override
  String get funchNotice => 'メニューは変更される可能性があります';

  @override
  String get funchEmpty => '情報が見つかりません';

  @override
  String get funchCategoryEmpty => 'このカテゴリーのメニューはありません。';

  @override
  String get funchSet => 'セット・単品';

  @override
  String get funchDonCurry => '丼・カレー';

  @override
  String get funchNoodle => '麺';

  @override
  String get funchSideDish => '副菜';

  @override
  String get funchDessert => 'デザート';

  @override
  String get funchLarge => '大';

  @override
  String get funchMedium => '中';

  @override
  String get funchSmall => '小';

  @override
  String funchToday(String date) {
    return '$dateの学食';
  }

  @override
  String get pdfShare => '共有';

  @override
  String get pdfShareFailed => 'PDFの共有に失敗しました。もう一度お試しください。';

  @override
  String get subjectClearFilters => '条件をクリア';

  @override
  String get subjectSemesterRequirementsAndClassification => '開講時期・必修/選択・分類';

  @override
  String get subjectSemester => '開講時期';

  @override
  String get subjectRequirements => '必修/選択';

  @override
  String get subjectClassification => '分類';

  @override
  String get subjectCulturalCategory => '教養区分';

  @override
  String get subjectCoursesGradesAndClasses => 'コース/領域・学年・クラス';

  @override
  String get subjectCoursesAndAreas => 'コース/領域';

  @override
  String get subjectGrades => '学年';

  @override
  String get subjectClasses => 'クラス';

  @override
  String get subjectPostFeedback => 'フィードバックを投稿';

  @override
  String get subjectSelectARating => '満足度を入力してください。';

  @override
  String get subjectCouldNotSubmitFeedback => 'フィードバックの投稿に失敗しました。';

  @override
  String get subjectSubmit => '投稿する';

  @override
  String get subjectTapToRate => 'タップして評価:';

  @override
  String get subjectComment => 'コメント';

  @override
  String get subjectCreditsAttendanceExamsEtc => '単位、出席、テストの情報など...';

  @override
  String get subjectSignInWithAGoogleAccountFunAcJp =>
      'Googleアカウント (@fun.ac.jp) による認証が必要です';

  @override
  String get subjectNoPastExamsAvailable => '過去問はありません';

  @override
  String get subjectNoFeedbackYet => 'フィードバックがありません';

  @override
  String get subjectSignInWithAGoogleAccountFunAcJpPrompt =>
      'Googleアカウント (@fun.ac.jp) による認証が必要です。';

  @override
  String get subjectFeedbackSubmitted => 'フィードバックを投稿しました。';

  @override
  String get subjectOutOf5 => '5段階評価中';

  @override
  String get subjectSummary => '概要';

  @override
  String get subjectLearningOutcomes => '到達目標';

  @override
  String get subjectAssignments => '提出課題等';

  @override
  String get subjectEvaluationMethodsAndCriteria => '評価方法・基準';

  @override
  String get subjectTextbooks => 'テキスト';

  @override
  String get subjectReferenceBooks => '参考書';

  @override
  String get subjectPrerequisites => '履修条件';

  @override
  String get subjectPreLearning => '事前学習';

  @override
  String get subjectPostLearning => '事後学習';

  @override
  String get subjectNotes => '履修上の留意点';

  @override
  String get subjectKeywords => 'キーワード';

  @override
  String get subjectTargetCoursesAndAreas => '対象コース・領域';

  @override
  String get subjectTargetAreas => '対象領域';

  @override
  String get subjectClassificationPrompt => '科目群・科目区分';

  @override
  String get subjectTeachingLanguage => '教授言語';

  @override
  String get subjectContentsAndSchedule => '授業内容とスケジュール';

  @override
  String get subjectTeachingAndExamFormat => '授業・試験の形式';

  @override
  String get subjectDSOPSubject => 'DSOP対象科目';

  @override
  String get subjectCourseRegistrationFailed => '履修登録の更新に失敗しました';

  @override
  String get subjectSubjectSearch => '科目検索';

  @override
  String get subjectSearchBySubjectName => '科目名で検索';

  @override
  String get subjectUnregister => '履修解除';

  @override
  String get subjectRegister => '履修登録';

  @override
  String get subjectNoSubjectsFound => '科目が見つかりませんでした';

  @override
  String get subjectSubjectSearchFailed => '科目の検索に失敗しました。';

  @override
  String get subjectSyllabus => 'シラバス';

  @override
  String get subjectReviews => 'レビュー';

  @override
  String get subjectPastExams => '過去問';

  @override
  String get subjectCouldNotLoadSubjectInformation => '科目情報の読み込みに失敗しました。';

  @override
  String subjectOtherFacultyCount(String name, int count) {
    return '$name 他$count名';
  }

  @override
  String subjectCredits(int credits) {
    return '$credits単位';
  }

  @override
  String subjectFeedbackCount(int count) {
    return '$count件のフィードバック';
  }

  @override
  String get courseTitle => '講義';

  @override
  String get courseSearch => '科目検索';

  @override
  String get courseNotices => '休講・補講';

  @override
  String get courseAcademicCalendar => '学年歴';

  @override
  String get courseCalendarDocument => '学年暦';

  @override
  String get courseSpringTimetable => '時間割 前期';

  @override
  String get courseFallTimetable => '時間割 後期';

  @override
  String get courseHope => 'HOPE';

  @override
  String get courseStudentPortal => '学生ポータル';

  @override
  String get courseDottoWeb => 'Dotto Web';

  @override
  String get courseMacSupport => 'Macサポート';

  @override
  String get courseOpinionBox => '大学ポスト';

  @override
  String get courseWeeklyTimetable => '1週間の時間割';

  @override
  String get courseSignIn => 'ログインして時間割機能を使う';

  @override
  String get courseFetchError => 'データの取得に失敗しました';

  @override
  String get courseCustomize => 'カスタム';

  @override
  String get courseShowTime => '時間割に時刻を表示';

  @override
  String get coursePreferenceError => 'ユーザー設定の読み込みに失敗しました';

  @override
  String get courseRegistration => '科目登録';

  @override
  String get courseNoSubjects => '対象の科目はありません';

  @override
  String get courseRemove => '削除';

  @override
  String get courseAdd => '追加';

  @override
  String get courseSlotFull => '1つのコマに2科目以上を設定できません';

  @override
  String get courseRegistrationError => '履修登録の更新に失敗しました';

  @override
  String courseLinkError(String label) {
    return '$label を開けませんでした';
  }

  @override
  String courseDocumentName(int year, String label) {
    return '$year年度 $label';
  }

  @override
  String courseSlotTitle(String semester, String day, int period) {
    return '$semester $day曜$period限';
  }

  @override
  String get courseNoticeTitle => '休講・補講・教室変更';

  @override
  String get courseNoticeSignInRequired => 'Googleアカウント(@fun.ac.jp)ログインが必要です。';

  @override
  String get courseNoticeRegistered => '履修中';

  @override
  String get courseNoticeAll => 'すべて';

  @override
  String get courseNoticeCancellation => '休講';

  @override
  String get courseNoticeMakeup => '補講';

  @override
  String get courseNoticeRoomChange => '教室変更';

  @override
  String get courseNoticeEmptyCancellation => '休講はありません。';

  @override
  String get courseNoticeEmptyMakeup => '補講はありません。';

  @override
  String get courseNoticeEmptyRoomChange => '教室変更はありません。';

  @override
  String get courseNoticeLoadError => 'データの取得に失敗しました。';

  @override
  String courseNoticePeriod(int period) {
    return '$period限';
  }

  @override
  String get commonNone => 'なし';

  @override
  String get commonUnset => '未設定';

  @override
  String get commonErrorTitle => 'エラーが発生しました。';

  @override
  String get commonErrorMessage => '時間を空けてもう一度お試しください。';

  @override
  String get tabCourse => '講義';

  @override
  String get tabFunch => '学食';

  @override
  String get tabMap => 'マップ';

  @override
  String get tabBus => 'バス';

  @override
  String get tabSetting => '設定';

  @override
  String get tabSubject => '科目検索';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsSignInFailedTitle => 'ログインに失敗しました';

  @override
  String get settingsSignInFailedMessage => '時間をおいてもう一度お試しください。';

  @override
  String get settingsOk => 'OK';

  @override
  String get settingsSignOutConfirmTitle => 'ログアウトしますか？';

  @override
  String get settingsCancel => 'キャンセル';

  @override
  String get settingsSignOut => 'ログアウト';

  @override
  String get settingsAboutApp => 'アプリについて';

  @override
  String get settingsAnnouncements => 'お知らせ';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsNotificationChecking => '確認中';

  @override
  String get settingsSendFeedback => 'フィードバックを送る';

  @override
  String get settingsDevelopers => '開発者';

  @override
  String get settingsHowToUse => 'アプリの使い方';

  @override
  String get settingsTermsOfService => '利用規約';

  @override
  String get settingsPrivacyPolicy => 'プライバシーポリシー';

  @override
  String get settingsLicenses => 'ライセンス';

  @override
  String get settingsMyInfo => 'あなたの情報';

  @override
  String get settingsGrade => '学年';

  @override
  String get settingsCourse => 'コース';

  @override
  String get settingsClass => 'クラス';

  @override
  String get settingsSaveFailed => '保存に失敗しました';

  @override
  String userInfoSignedInAs(String email) {
    return '${email}でログイン中';
  }

  @override
  String get userInfoSignInPrompt => 'Google アカウント (@fun.ac.jp) でログイン';

  @override
  String get notificationStatusEnabled => '有効';

  @override
  String get notificationStatusProvisional => '静かな配信';

  @override
  String get notificationStatusAlertDisabled => 'バナー無効';

  @override
  String get notificationStatusDenied => '拒否';

  @override
  String get notificationStatusNotDetermined => '未設定';

  @override
  String get invalidAppVersionTitle => 'Dottoのアップデートが必要です';

  @override
  String get announcementTitle => 'お知らせ';

  @override
  String get announcementNotFound => 'お知らせが見つかりませんでした。';

  @override
  String get announcementOpen => 'お知らせを開く';

  @override
  String get onboardingTitle => 'Dottoの使い方';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingStart => 'はじめる';

  @override
  String get onboardingWelcomeTitle => 'ようこそ';

  @override
  String get onboardingWelcomeBodyTop => 'Dottoで';

  @override
  String get onboardingWelcomeBodyBottom => 'はこだて未来大学のすべてを';

  @override
  String get onboardingTimetableTitle => '時間割の管理';

  @override
  String get onboardingTimetableDescription => '自分の時間割を設定して\n休講/補講情報を受け取ろう';

  @override
  String get onboardingBusTitle => 'バスの時刻表';

  @override
  String get onboardingBusDescription => '大学から最寄りのバス停までの\n時刻表を確認しよう';

  @override
  String get onboardingMapTitle => '学内マップ';

  @override
  String get onboardingMapDescription => '空き教室を確認したり\n研究室を検索しよう';

  @override
  String get onboardingSubjectTitle => '科目検索';

  @override
  String get onboardingSubjectDescription => 'レビューや過去問を\n閲覧しよう';

  @override
  String get onboardingFunchTitle => '学食メニュー';

  @override
  String get onboardingFunchDescription => '学食のメニューや価格を\n確認しよう';
}

import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/presentation/setting/settings_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

Widget _content({
  DottoUser? user,
  bool isUserLoading = false,
  String? notificationStatusLabel = '有効',
}) => SettingsContent(
  user: user,
  isUserLoading: isUserLoading,
  notificationStatusLabel: notificationStatusLabel,
  versionLabel: '1.0.0 (1)',
  onAccountTap: () {},
  onGradeSelected: (_) async {},
  onCourseSelected: (_) async {},
  onClassSelected: (_) async {},
  onAnnouncementsTap: () {},
  onNotificationTap: () {},
  onFeedbackTap: () {},
  onDevelopersTap: () {},
  onOnboardingTap: () {},
  onTermsOfServiceTap: () {},
  onPrivacyPolicyTap: () {},
  onLicenseTap: () {},
);

@widgetbook.UseCase(name: 'Signed out', type: SettingsContent)
Widget settingsContentSignedOut(BuildContext context) => _content();

@widgetbook.UseCase(name: 'Loading user', type: SettingsContent)
Widget settingsContentLoadingUser(BuildContext context) =>
    _content(isUserLoading: true, notificationStatusLabel: null);

// アバター画像はネットワークから取得しないよう、空の URL とする。
@widgetbook.UseCase(name: 'Signed in', type: SettingsContent)
Widget settingsContentSignedIn(BuildContext context) => _content(
  user: const DottoUser(
    id: '1',
    name: '未来 太郎',
    email: 'b1000000@fun.ac.jp',
    avatarUrl: '',
    grade: Grade.b1,
    course: AcademicArea.informationSystemCourse,
  ),
);

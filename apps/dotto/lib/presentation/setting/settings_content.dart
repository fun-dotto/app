import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/presentation/setting/app_version_footer.dart';
import 'package:dotto/presentation/setting/user_info_tile.dart';
import 'package:dotto/presentation/setting/user_profile_section.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

/// 設定画面の表示。
final class SettingsContent extends StatelessWidget {
  const new({
    required this.user,
    required this.isUserLoading,
    required this.notificationStatusLabel,
    required this.versionLabel,
    required this.onAccountTap,
    required this.onGradeSelected,
    required this.onCourseSelected,
    required this.onClassSelected,
    required this.onAnnouncementsTap,
    required this.onNotificationTap,
    required this.onFeedbackTap,
    required this.onDevelopersTap,
    required this.onOnboardingTap,
    required this.onTermsOfServiceTap,
    required this.onPrivacyPolicyTap,
    required this.onLicenseTap,
    this.onVersionTap,
    super.key,
  });

  /// ログイン中のユーザー。未ログインの場合は `null`。
  final DottoUser? user;
  final bool isUserLoading;

  /// 通知の許可状態。確認中の場合は `null`。
  final String? notificationStatusLabel;
  final String versionLabel;
  final VoidCallback onAccountTap;
  final Future<void> Function(Grade? grade) onGradeSelected;
  final Future<void> Function(AcademicArea? course) onCourseSelected;
  final Future<void> Function(AcademicClass? class_) onClassSelected;
  final VoidCallback onAnnouncementsTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onFeedbackTap;
  final VoidCallback onDevelopersTap;
  final VoidCallback onOnboardingTap;
  final VoidCallback onTermsOfServiceTap;
  final VoidCallback onPrivacyPolicyTap;
  final VoidCallback onLicenseTap;

  /// 開発用ビルドでのみ渡す。
  final VoidCallback? onVersionTap;

  @override
  Widget build(BuildContext context) {
    final user = this.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            UserInfoTile(
              user: user,
              isLoading: isUserLoading,
              onTap: onAccountTap,
            ),
            if (user != null)
              UserProfileSection(
                user: user,
                onGradeSelected: onGradeSelected,
                onCourseSelected: onCourseSelected,
                onClassSelected: onClassSelected,
              ),
            DottoListSection(
              header: const Text('アプリについて'),
              footer: AppVersionFooter(
                versionLabel: versionLabel,
                onTap: onVersionTap,
              ),
              children: [
                _LinkTile(
                  title: 'お知らせ',
                  icon: Icons.notifications,
                  onTap: onAnnouncementsTap,
                ),
                DottoListTile(
                  firstLine: const Text('通知'),
                  leading: const Icon(Icons.notifications_active),
                  secondLine: Text(notificationStatusLabel ?? '確認中'),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: onNotificationTap,
                ),
                _LinkTile(
                  title: 'フィードバックを送る',
                  icon: Icons.messenger_rounded,
                  onTap: onFeedbackTap,
                ),
                _LinkTile(
                  title: '開発者',
                  icon: Icons.person,
                  onTap: onDevelopersTap,
                ),
                _LinkTile(
                  title: 'アプリの使い方',
                  icon: Icons.assignment,
                  onTap: onOnboardingTap,
                ),
                _LinkTile(
                  title: '利用規約',
                  icon: Icons.verified_user,
                  onTap: onTermsOfServiceTap,
                ),
                _LinkTile(
                  title: 'プライバシーポリシー',
                  icon: Icons.admin_panel_settings,
                  onTap: onPrivacyPolicyTap,
                ),
                _LinkTile(
                  title: 'ライセンス',
                  icon: Icons.info,
                  onTap: onLicenseTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final class _LinkTile extends StatelessWidget {
  const new({required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DottoListTile(
      firstLine: Text(title),
      leading: Icon(icon),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: onTap,
    );
  }
}

import 'dart:async';

import 'package:dotto/controller/notification_status_controller.dart';
import 'package:dotto/controller/user_controller.dart';
import 'package:dotto/domain/academic_area.dart';
import 'package:dotto/domain/academic_class.dart';
import 'package:dotto/domain/grade.dart';
import 'package:dotto/feature/setting/widget/user_info_tile.dart';
import 'package:dotto/foundation/config/config.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/helper/notification_helper.dart';
import 'package:dotto/helper/url_launcher_helper.dart';
import 'package:dotto/repository/config_repository.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/component/dialog.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _showLogoutConfirmDialog(
    BuildContext context,
    VoidCallback onLogout,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return DottoDialog(
          type: .plain,
          title: 'ログアウトしますか？',
          message: '',
          actionButtons: [
            DottoButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              type: .outlined,
              child: const Text('キャンセル'),
            ),
            DottoButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onLogout();
              },
              child: const Text('ログアウト'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLoginErrorDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return DottoDialog(
          type: .alert,
          title: 'ログインに失敗しました',
          message: '時間をおいてもう一度お試しください。',
          actionButtons: [
            DottoButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> canOpenDebugScreen() async {
    if (kDebugMode) {
      return true;
    }
    return switch (appFlavor) {
      'prd' || 'stg' || 'dev' => true,
      _ => false,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final feedbackFormUrl = ref.watch(
      configProvider(RemoteConfigs.feedbackFormUrl),
    );
    final termsOfServiceUrl = ref.watch(
      configProvider(RemoteConfigs.termsOfServiceUrl),
    );
    final privacyPolicyUrl = ref.watch(
      configProvider(RemoteConfigs.privacyPolicyUrl),
    );
    final notificationStatus = ref.watch(notificationStatusProvider);
    final isAuthenticated = user.value != null;

    // 設定を取得（初回マウント時のみ）
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.invalidate(configRepositoryProvider);
      });
      return null;
    }, const []);

    // ログイン失敗時にエラーダイアログを表示する
    ref.listen<AsyncValue<dynamic>>(userProvider, (previous, next) {
      final wasUnauthenticated =
          previous?.value == null && !(previous?.hasError ?? false);
      if (wasUnauthenticated && next.hasError) {
        unawaited(_showLoginErrorDialog(context));
      }
    });

    UserInfoTile buildUserInfoTile({bool isLoading = false}) {
      return UserInfoTile(
        user: user.value,
        isLoading: isLoading,
        onTap: isAuthenticated
            ? () async {
                await _showLogoutConfirmDialog(
                  context,
                  () => unawaited(ref.read(userProvider.notifier).signOut()),
                );
              }
            : () async {
                await ref.read(userProvider.notifier).signIn();
              },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: SemanticColor.light.accentPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            user.when(
              data: (_) => buildUserInfoTile(),
              loading: () => buildUserInfoTile(isLoading: true),
              error: (_, _) => buildUserInfoTile(),
            ),
            if (isAuthenticated)
              DottoListSection(
                header: const Text('あなたの情報'),
                children: [
                  DottoListTile(
                    firstLine: const Text('学年'),
                    leading: const Icon(Icons.school),
                    secondLine: Text(user.value?.grade?.label ?? '未設定'),
                    trailing: const DottoListTileTrailing.chevron(),
                    onTap: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('学年'),
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                await ref
                                    .read(userProvider.notifier)
                                    .setGrade(null);
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                title: const Text('なし'),
                                trailing: Icon(
                                  user.value?.grade == null
                                      ? Icons.check
                                      : null,
                                ),
                              ),
                            ),
                            ...Grade.values.map((grade) {
                              return MaterialButton(
                                onPressed: () async {
                                  await ref
                                      .read(userProvider.notifier)
                                      .setGrade(grade);
                                  if (!context.mounted) return;
                                  Navigator.of(context).pop();
                                },
                                child: ListTile(
                                  title: Text(grade.label),
                                  trailing: Icon(
                                    user.value?.grade == grade
                                        ? Icons.check
                                        : null,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                  DottoListTile(
                    firstLine: const Text('コース'),
                    leading: const Icon(Icons.school),
                    secondLine: Text(user.value?.course?.label ?? '未設定'),
                    trailing: const DottoListTileTrailing.chevron(),
                    onTap: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('コース'),
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                await ref
                                    .read(userProvider.notifier)
                                    .setCourse(null);
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                title: const Text('なし'),
                                trailing: Icon(
                                  user.value?.course == null
                                      ? Icons.check
                                      : null,
                                ),
                              ),
                            ),
                            ...AcademicArea.values.map((academicArea) {
                              return MaterialButton(
                                onPressed: () async {
                                  await ref
                                      .read(userProvider.notifier)
                                      .setCourse(academicArea);
                                  if (!context.mounted) return;
                                  Navigator.of(context).pop();
                                },
                                child: ListTile(
                                  title: Text(academicArea.label),
                                  trailing: Icon(
                                    user.value?.course == academicArea
                                        ? Icons.check
                                        : null,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                  DottoListTile(
                    firstLine: const Text('クラス'),
                    leading: const Icon(Icons.school),
                    secondLine: Text(user.value?.class_?.label ?? '未設定'),
                    trailing: const DottoListTileTrailing.chevron(),
                    onTap: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('クラス'),
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                await ref
                                    .read(userProvider.notifier)
                                    .setClass(null);
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                title: const Text('なし'),
                                trailing: Icon(
                                  user.value?.class_ == null
                                      ? Icons.check
                                      : null,
                                ),
                              ),
                            ),
                            ...AcademicClass.values.map((academicClass) {
                              return MaterialButton(
                                onPressed: () async {
                                  await ref
                                      .read(userProvider.notifier)
                                      .setClass(academicClass);
                                  if (!context.mounted) return;
                                  Navigator.of(context).pop();
                                },
                                child: ListTile(
                                  title: Text(academicClass.label),
                                  trailing: Icon(
                                    user.value?.class_ == academicClass
                                        ? Icons.check
                                        : null,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            DottoListSection(
              header: const Text('アプリについて'),
              // バージョン
              footer: GestureDetector(
                onTap: () async {
                  final canOpen = await canOpenDebugScreen();
                  if (!canOpen || !context.mounted) {
                    return;
                  }
                  unawaited(const DebugRouteData().push<void>(context));
                },
                child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return Text('${data.version} (${data.buildNumber})');
                    } else {
                      return const Text('');
                    }
                  },
                ),
              ),
              children: [
                // お知らせ
                DottoListTile(
                  firstLine: const Text('お知らせ'),
                  leading: const Icon(Icons.notifications),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async {
                    await const AnnouncementsRouteData().push<void>(context);
                  },
                ),
                // 通知設定
                DottoListTile(
                  firstLine: const Text('通知'),
                  leading: const Icon(Icons.notifications_active),
                  secondLine: Text(notificationStatus.value?.label ?? '確認中'),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async {
                    await ref
                        .read(notificationHelperProvider)
                        .openSystemSettings();
                  },
                ),
                // フィードバック
                DottoListTile(
                  firstLine: const Text('フィードバックを送る'),
                  leading: const Icon(Icons.messenger_rounded),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async => launchUrlSafely(feedbackFormUrl),
                ),
                // Contributors表示
                DottoListTile(
                  firstLine: const Text('開発者'),
                  leading: const Icon(Icons.person),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async {
                    await const DevelopersRouteData().push<void>(context);
                  },
                ),
                // アプリの使い方
                DottoListTile(
                  firstLine: const Text('アプリの使い方'),
                  leading: const Icon(Icons.assignment),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async {
                    await const SettingOnboardingRouteData().push<void>(
                      context,
                    );
                  },
                ),
                // 利用規約
                DottoListTile(
                  firstLine: const Text('利用規約'),
                  leading: const Icon(Icons.verified_user),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async => launchUrlSafely(termsOfServiceUrl),
                ),
                // プライバシーポリシー
                DottoListTile(
                  firstLine: const Text('プライバシーポリシー'),
                  leading: const Icon(Icons.admin_panel_settings),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async => launchUrlSafely(privacyPolicyUrl),
                ),
                // ライセンス
                DottoListTile(
                  firstLine: const Text('ライセンス'),
                  leading: const Icon(Icons.info),
                  trailing: const DottoListTileTrailing.chevron(),
                  onTap: () async {
                    await const SettingsLicenseRouteData().push<void>(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

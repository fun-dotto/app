import 'package:dotto/domain/entity/course_notice_scope.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/course_notice/course_cancellation_content.dart';
import 'package:dotto/presentation/course_notice/course_notices_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

export 'package:dotto/presentation/course_notice/course_cancellation_content.dart'
    show CourseNoticeTab;

final class CourseCancellationScreen extends HookConsumerWidget {
  const new({required this.initialTab, super.key});
  final CourseNoticeTab initialTab;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final scope = useState(CourseNoticeScope.registered);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    if (!isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.courseNoticeTitle)),
        body: Center(child: Text(l10n.courseNoticeSignInRequired)),
      );
    }
    final provider = courseNoticesStateProvider(scope.value);
    return CourseCancellationContent(
      initialTab: initialTab,
      scope: scope.value,
      onScopeToggled: () =>
          scope.value = scope.value == CourseNoticeScope.registered
          ? CourseNoticeScope.all
          : CourseNoticeScope.registered,
      body: switch (ref.watch(provider)) {
        AsyncData(:final value) => CourseNoticeTabView(
          notices: value,
          onRefresh: () => ref.read(provider.notifier).refresh(),
        ),
        AsyncLoading() => const CourseNoticeLoadingSkeleton(),
        AsyncError() => Center(child: Text(l10n.courseNoticeLoadError)),
      },
    );
  }
}

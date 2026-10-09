import 'dart:async';

import 'package:dotto/application/register_course_use_case.dart';
import 'package:dotto/application/unregister_course_use_case.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/subject/search_subject_content.dart';
import 'package:dotto/presentation/subject/search_subject_state.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class SearchSubjectScreen extends HookConsumerWidget {
  const new({required this.onSubjectSelected, super.key});

  /// 科目が選択されたときの処理。引数は科目ID。
  ///
  /// タブごとに科目詳細のパスが異なるため、遷移先は呼び出し側が決める。
  final void Function(String subjectId) onSubjectSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final query = useState('');
    final processingSubjectIds = useState(<String>{});
    final searchState = ref.watch(searchSubjectStateProvider);
    final selectedFilter = useState(const SubjectFilter());
    final filter = selectedFilter.value;

    Future<void> search() async {
      await ref
          .read(searchSubjectStateProvider.notifier)
          .search(query: query.value, filter: selectedFilter.value);
    }

    Future<void> toggleCourseRegistration({
      required String subjectId,
      required bool isAddedToTimetable,
    }) async {
      final processing = processingSubjectIds.value;
      if (processing.contains(subjectId)) {
        return;
      }
      processingSubjectIds.value = {...processing, subjectId};
      try {
        if (isAddedToTimetable) {
          await ref.read(unregisterCourseUseCaseProvider)(subjectId);
        } else {
          await ref.read(registerCourseUseCaseProvider)(subjectId);
        }
        await search();
      } on Exception catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.subjectL10n.subjectCourseRegistrationFailed,
              ),
            ),
          );
        }
      } finally {
        if (context.mounted) {
          processingSubjectIds.value = {
            ...processingSubjectIds.value.where((id) => id != subjectId),
          };
        }
      }
    }

    return SearchSubjectContent(
      filter: filter,
      onQueryChanged: (value) => query.value = value,
      onQuerySubmitted: () => unawaited(search()),
      onFilterChanged: (value) {
        selectedFilter.value = value;
        unawaited(
          ref
              .read(searchSubjectStateProvider.notifier)
              .search(query: query.value, filter: value),
        );
      },
      onFiltersCleared: () {
        selectedFilter.value = const SubjectFilter();
        ref.read(searchSubjectStateProvider.notifier).clear();
      },
      results: switch (searchState) {
        AsyncData(:final value) => SearchSubjectResults(
          subjects: value,
          filter: filter,
          isAuthenticated: isAuthenticated,
          processingIds: processingSubjectIds.value,
          onSelected: onSubjectSelected,
          onToggle: (id, {required isAddedToTimetable}) => unawaited(
            toggleCourseRegistration(
              subjectId: id,
              isAddedToTimetable: isAddedToTimetable,
            ),
          ),
        ),
        AsyncError() => Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(context.subjectL10n.subjectSubjectSearchFailed),
          ),
        ),
        AsyncLoading() => const SearchSubjectLoadingSkeleton(),
      },
    );
  }
}

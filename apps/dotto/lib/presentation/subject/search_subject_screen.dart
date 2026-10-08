import 'dart:async';

import 'package:dotto/application/register_course_use_case.dart';
import 'package:dotto/application/unregister_course_use_case.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/subject/search_subject_filter_section.dart';
import 'package:dotto/presentation/subject/search_subject_state.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:dotto_design_system/component/text_field.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

final class SearchSubjectScreen extends HookConsumerWidget {
  const new({required this.onSubjectSelected, super.key});

  /// 科目が選択されたときの処理。引数は科目ID。
  ///
  /// タブごとに科目詳細のパスが異なるため、遷移先は呼び出し側が決める。
  final void Function(String subjectId) onSubjectSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final textEditingController = useTextEditingController();
    final focusNode = useFocusNode();
    final processingSubjectIds = useState(<String>{});
    final searchState = ref.watch(searchSubjectStateProvider);
    final selectedFilter = useState(const SubjectFilter());
    final filter = selectedFilter.value;

    Future<void> search() async {
      await ref
          .read(searchSubjectStateProvider.notifier)
          .search(
            query: textEditingController.text,
            filter: selectedFilter.value,
          );
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.subjectL10n.subjectSubjectSearch,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: filter.hasActiveFilters
                ? () {
                    selectedFilter.value = const SubjectFilter();
                    ref.read(searchSubjectStateProvider.notifier).clear();
                  }
                : null,
            child: Text(context.subjectL10n.subjectClearFilters),
          ),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              DottoTextField(
                placeholder: context.subjectL10n.subjectSearchBySubjectName,
                controller: textEditingController,
                focusNode: focusNode,
                onSubmitted: (_) => search(),
              ),
              SearchSubjectFilterSection(
                filter: filter,
                onChanged: (value) {
                  selectedFilter.value = value;
                  final notifier = ref.read(
                    searchSubjectStateProvider.notifier,
                  );
                  unawaited(
                    notifier.search(
                      query: textEditingController.text,
                      filter: value,
                    ),
                  );
                },
              ),
              const Divider(height: 0),
              _SearchResults(
                searchState: searchState,
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
            ],
          ),
        ),
      ),
    );
  }
}

final class _SubjectTile extends StatelessWidget {
  const new({
    required this.subject,
    required this.isAuthenticated,
    required this.isProcessing,
    required this.onSelected,
    required this.onToggle,
  });
  final SubjectSummary subject;
  final bool isAuthenticated;
  final bool isProcessing;
  final ValueChanged<String> onSelected;
  final void Function(String, {required bool isAddedToTimetable}) onToggle;
  String? _facultyLabel(BuildContext context, List<SubjectFaculty> faculties) {
    if (faculties.isEmpty) {
      return null;
    }

    final primaryNames = faculties
        .where((faculty) => faculty.isPrimary)
        .map((faculty) => faculty.faculty.name)
        .toList();
    if (primaryNames.isNotEmpty) {
      final otherCount = faculties.length - primaryNames.length;
      return otherCount > 0
          ? context.subjectL10n.subjectOtherFacultyCount(
              primaryNames.join(', '),
              otherCount,
            )
          : primaryNames.join(', ');
    }

    final fallbackNames = faculties
        .map((faculty) => faculty.faculty.name)
        .toList();
    final otherCount = fallbackNames.length - 1;
    return otherCount > 0
        ? context.subjectL10n.subjectOtherFacultyCount(
            fallbackNames.first,
            otherCount,
          )
        : fallbackNames.first;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subject.name),
      subtitle: () {
        final lines = <String>[];
        final semesterLabel = subject.semester?.label;
        final slots = subject.slots;
        final slotLabel = slots != null && slots.isNotEmpty
            ? slots
                  .map((slot) => '${slot.dayOfWeek.label}${slot.period.number}')
                  .join(',')
            : null;
        final creditLabel = subject.credit != null
            ? context.subjectL10n.subjectCredits(subject.credit ?? 0)
            : null;
        final timeLine = [?semesterLabel, ?slotLabel, ?creditLabel].join(' ');
        if (timeLine.isNotEmpty) {
          lines.add(timeLine);
        }
        final facultyLabel = _facultyLabel(context, subject.faculties);
        if (facultyLabel != null) {
          lines.add(facultyLabel);
        }
        if (lines.isEmpty) {
          return null;
        }
        return Text(lines.join('\n'));
      }(),
      onTap: () => onSelected(subject.id),
      trailing: const Icon(Icons.chevron_right),
      leading: () {
        if (!isAuthenticated) {
          return null;
        }
        final isAddedToTimetable = subject.isAddedToTimetable;
        if (isAddedToTimetable == null) return null;

        return IconButton(
          onPressed: isProcessing
              ? null
              : () => onToggle(
                  subject.id,
                  isAddedToTimetable: isAddedToTimetable,
                ),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: isProcessing
                ? SizedBox(
                    key: const ValueKey('loading'),
                    width: 20,
                    height: 20,
                    child: Shimmer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                : Icon(
                    isAddedToTimetable ? Icons.check : Icons.add,
                    key: ValueKey(
                      isAddedToTimetable ? 'registered' : 'unregistered',
                    ),
                  ),
          ),
          tooltip: isAddedToTimetable
              ? context.subjectL10n.subjectUnregister
              : context.subjectL10n.subjectRegister,
        );
      }(),
    );
  }
}

final class _SearchLoadingSkeleton extends StatelessWidget {
  const new();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 8; i++) ...[
          if (i > 0) const Divider(height: 0),
          ListTile(
            title: Shimmer(
              child: Container(
                height: 16,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer(
                    child: Container(
                      height: 14,
                      width: 220,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Shimmer(
                    child: Container(
                      height: 14,
                      width: 180,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ),
        ],
      ],
    );
  }
}

final class _SearchResults extends StatelessWidget {
  const new({
    required this.searchState,
    required this.filter,
    required this.isAuthenticated,
    required this.processingIds,
    required this.onSelected,
    required this.onToggle,
  });
  final AsyncValue<List<SubjectSummary>> searchState;
  final SubjectFilter filter;
  final bool isAuthenticated;
  final Set<String> processingIds;
  final ValueChanged<String> onSelected;
  final void Function(String, {required bool isAddedToTimetable}) onToggle;
  @override
  Widget build(BuildContext context) {
    return switch (searchState) {
      AsyncData(:final value) =>
        value.isEmpty && filter.hasActiveFilters
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(context.subjectL10n.subjectNoSubjectsFound),
                ),
              )
            : Column(
                children: [
                  for (var index = 0; index < value.length; index++) ...[
                    if (index > 0) const Divider(height: 0),
                    _SubjectTile(
                      subject: value[index],
                      isAuthenticated: isAuthenticated,
                      isProcessing: processingIds.contains(value[index].id),
                      onSelected: onSelected,
                      onToggle: onToggle,
                    ),
                  ],
                ],
              ),
      AsyncError() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(context.subjectL10n.subjectSubjectSearchFailed),
        ),
      ),
      AsyncLoading() => const _SearchLoadingSkeleton(),
    };
  }
}

import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/presentation/subject/search_subject_filter_section.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:dotto_design_system/component/text_field.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// 科目検索画面の枠組み。
///
/// 検索結果の部分は [results] で受け取り、[SearchSubjectResults] などを渡す。
final class SearchSubjectContent extends StatelessWidget {
  const new({
    required this.filter,
    required this.results,
    required this.onQueryChanged,
    required this.onQuerySubmitted,
    required this.onFilterChanged,
    required this.onFiltersCleared,
    super.key,
  });

  final SubjectFilter filter;
  final Widget results;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onQuerySubmitted;
  final ValueChanged<SubjectFilter> onFilterChanged;
  final VoidCallback onFiltersCleared;

  @override
  Widget build(BuildContext context) {
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
            onPressed: filter.hasActiveFilters ? onFiltersCleared : null,
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
                onChanged: onQueryChanged,
                onSubmitted: (_) => onQuerySubmitted(),
              ),
              SearchSubjectFilterSection(
                filter: filter,
                onChanged: onFilterChanged,
              ),
              const Divider(height: 0),
              results,
            ],
          ),
        ),
      ),
    );
  }
}

/// 科目の検索結果。
final class SearchSubjectResults extends StatelessWidget {
  const new({
    required this.subjects,
    required this.filter,
    required this.isAuthenticated,
    required this.processingIds,
    required this.onSelected,
    required this.onToggle,
    super.key,
  });
  final List<SubjectSummary> subjects;
  final SubjectFilter filter;
  final bool isAuthenticated;

  /// 履修登録の変更中の科目ID。
  final Set<String> processingIds;
  final ValueChanged<String> onSelected;
  final void Function(String, {required bool isAddedToTimetable}) onToggle;
  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty && filter.hasActiveFilters) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text(context.subjectL10n.subjectNoSubjectsFound)),
      );
    }
    return Column(
      children: [
        for (var index = 0; index < subjects.length; index++) ...[
          if (index > 0) const Divider(height: 0),
          _SubjectTile(
            subject: subjects[index],
            isAuthenticated: isAuthenticated,
            isProcessing: processingIds.contains(subjects[index].id),
            onSelected: onSelected,
            onToggle: onToggle,
          ),
        ],
      ],
    );
  }
}

/// 検索中のプレースホルダー。
final class SearchSubjectLoadingSkeleton extends StatelessWidget {
  const new({super.key});
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

import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/cultural_subject_category.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_classification.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_requirement_type.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:dotto_design_system/style/theme_extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

final class SearchSubjectFilterSection extends HookWidget {
  const new({
    required this.filter,
    required this.onChanged,
    super.key,
    this.onClear,
  });

  final SubjectFilter filter;
  final ValueChanged<SubjectFilter> onChanged;
  final VoidCallback? onClear;
  static final List<Grade> _availableGrades = [
    Grade.b1,
    Grade.b2,
    Grade.b3,
    Grade.b4,
    Grade.m1,
    Grade.m2,
  ];

  @override
  Widget build(BuildContext context) {
    final hasCulturalClassification = filter.classifications.contains(
      SubjectClassification.cultural,
    );
    final isBasicAttributesExpanded = useState(false);
    final isOtherAttributesExpanded = useState(false);
    final basicFilterCount =
        filter.courses.length + filter.grades.length + filter.classes.length;
    final otherFilterCount =
        filter.semesters.length +
        filter.requirements.length +
        filter.classifications.length +
        filter.culturalSubjectCategories.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (onClear != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: filter.hasActiveFilters ? onClear : null,
              child: Text(context.subjectL10n.subjectClearFilters),
            ),
          ),
        ],
        _CollapsibleSection(
          label:
              context.subjectL10n.subjectSemesterRequirementsAndClassification,
          isExpanded: isOtherAttributesExpanded.value,
          onExpandedChanged: (value) => isOtherAttributesExpanded.value = value,
          badgeCount: otherFilterCount,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              _FilterChipGroup<Semester>(
                label: context.subjectL10n.subjectSemester,
                values: Semester.values,
                selected: filter.semesters,
                onChanged: (v) => onChanged(filter.copyWith(semesters: v)),
                labelBuilder: (v) => v.label,
              ),
              _FilterChipGroup<SubjectRequirementType>(
                label: context.subjectL10n.subjectRequirements,
                values: SubjectRequirementType.values,
                selected: filter.requirements,
                onChanged: (v) => onChanged(filter.copyWith(requirements: v)),
                labelBuilder: (v) => v.label,
              ),
              _FilterChipGroup<SubjectClassification>(
                label: context.subjectL10n.subjectClassification,
                values: SubjectClassification.values,
                selected: filter.classifications,
                onChanged: (v) {
                  final hasCultural = v.contains(
                    SubjectClassification.cultural,
                  );
                  onChanged(
                    filter.copyWith(
                      classifications: v,
                      culturalSubjectCategories: hasCultural
                          ? filter.culturalSubjectCategories
                          : [],
                    ),
                  );
                },
                labelBuilder: (v) => v.label,
              ),
              if (hasCulturalClassification)
                _FilterChipGroup<CulturalSubjectCategory>(
                  label: context.subjectL10n.subjectCulturalCategory,
                  values: CulturalSubjectCategory.values,
                  selected: filter.culturalSubjectCategories,
                  onChanged: (v) =>
                      onChanged(filter.copyWith(culturalSubjectCategories: v)),
                  labelBuilder: (v) => v.label,
                ),
            ],
          ),
        ),
        const Divider(height: 0),
        _CollapsibleSection(
          label: context.subjectL10n.subjectCoursesGradesAndClasses,
          isExpanded: isBasicAttributesExpanded.value,
          onExpandedChanged: (value) => isBasicAttributesExpanded.value = value,
          badgeCount: basicFilterCount,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              _FilterChipGroup<AcademicArea>(
                label: context.subjectL10n.subjectCoursesAndAreas,
                values: AcademicArea.values,
                selected: filter.courses,
                onChanged: (v) => onChanged(filter.copyWith(courses: v)),
                labelBuilder: (v) => v.label,
              ),
              _FilterChipGroup<Grade>(
                label: context.subjectL10n.subjectGrades,
                values: _availableGrades,
                selected: filter.grades,
                onChanged: (v) => onChanged(filter.copyWith(grades: v)),
                labelBuilder: (v) => v.label,
              ),
              _FilterChipGroup<AcademicClass>(
                label: context.subjectL10n.subjectClasses,
                values: AcademicClass.values,
                selected: filter.classes,
                onChanged: (v) => onChanged(filter.copyWith(classes: v)),
                labelBuilder: (v) => v.label,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final class _CollapsibleSection extends StatelessWidget {
  const new({
    required this.label,
    required this.isExpanded,
    required this.onExpandedChanged,
    required this.child,
    this.badgeCount = 0,
  });
  final String label;
  final bool isExpanded;
  final ValueChanged<bool> onExpandedChanged;
  final Widget child;
  final int badgeCount;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onExpandedChanged(!isExpanded),
          borderRadius: BorderRadius.circular(8),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black.withValues(alpha: 0.06);
            }
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return Colors.black.withValues(alpha: 0.03);
            }
            return null;
          }),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (badgeCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colors.accentPrimary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '$badgeCount',
                      style: Theme.of(context).textTheme.labelMedium
                          ?.copyWith(color: colors.labelTertiary),
                    ),
                  ),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: 0, end: isExpanded ? 1 : 0),
          child: Padding(padding: const EdgeInsets.only(top: 12), child: child),
          builder: (context, value, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: value,
                child: child,
              ),
            );
          },
        ),
      ],
    );
  }
}

final class _FilterChipGroup<T> extends StatelessWidget {
  const new({
    required this.label,
    required this.values,
    required this.selected,
    required this.onChanged,
    required this.labelBuilder,
  });
  final String label;
  final List<T> values;
  final List<T> selected;
  final ValueChanged<List<T>> onChanged;
  final String Function(T) labelBuilder;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        _FilterChipRow<T>(
          values: values,
          selected: selected,
          onChanged: onChanged,
          labelBuilder: labelBuilder,
        ),
      ],
    );
  }
}

final class _FilterChipRow<T> extends StatelessWidget {
  const new({
    required this.values,
    required this.selected,
    required this.onChanged,
    required this.labelBuilder,
  });
  final List<T> values;
  final List<T> selected;
  final ValueChanged<List<T>> onChanged;
  final String Function(T) labelBuilder;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).semanticColors;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [
          for (final value in values)
            () {
              final isSelected = selected.contains(value);
              return FilterChip(
                label: Text(labelBuilder(value)),
                selected: isSelected,
                onSelected: (newValue) {
                  if (newValue) {
                    onChanged([...selected, value]);
                  } else {
                    onChanged(selected.where((v) => v != value).toList());
                  }
                },
                showCheckmark: false,
                selectedColor: colors.accentPrimary.withValues(alpha: 0.2),
                side: BorderSide(
                  color: isSelected
                      ? colors.accentPrimary
                      : colors.borderPrimary,
                ),
              );
            }(),
        ],
      ),
    );
  }
}

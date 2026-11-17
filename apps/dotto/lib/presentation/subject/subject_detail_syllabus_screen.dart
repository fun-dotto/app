import 'package:dotto/domain/entity/syllabus.dart';
import 'package:dotto/extension/edge_insets_extension.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:dotto_design_system/component/content.dart';
import 'package:material_ui/material_ui.dart';

final class SubjectDetailSyllabusScreen extends StatelessWidget {
  const new({required this.syllabus, super.key});

  final Syllabus syllabus;

  @override
  Widget build(BuildContext context) {
    final l10n = context.subjectL10n;
    // API (SubjectSyllabus) のフィールド順に並べる。
    final items = <(String, String)>[
      (l10n.subjectSyllabusId, syllabus.id),
      (l10n.subjectLessonId, syllabus.lessonId),
      (l10n.subjectYear, syllabus.year.toString()),
      (l10n.subjectName, syllabus.name),
      (l10n.subjectEnName, syllabus.enName),
      (l10n.subjectGrades, syllabus.grades),
      (l10n.subjectTerm, syllabus.term),
      (l10n.subjectCredit, syllabus.credit),
      (l10n.subjectFacultyNames, syllabus.facultyNames),
      (l10n.subjectPracticalHomeFacultyCategory, syllabus.practicalHomeFacultyCategory),
      (l10n.subjectMultiplePersonTeachingForm, syllabus.multiplePersonTeachingForm),
      (l10n.subjectTeachingForm, syllabus.teachingForm),
      (l10n.subjectSummary, syllabus.summary),
      (l10n.subjectLearningOutcomes, syllabus.learningOutcomes),
      (l10n.subjectAssignments, syllabus.assignments),
      (l10n.subjectEvaluationMethodsAndCriteria, syllabus.evaluationMethod),
      (l10n.subjectTextbooks, syllabus.textbooks),
      (l10n.subjectReferenceBooks, syllabus.referenceBooks),
      (l10n.subjectPrerequisites, syllabus.prerequisites),
      (l10n.subjectPreLearning, syllabus.preLearning),
      (l10n.subjectPostLearning, syllabus.postLearning),
      (l10n.subjectNotes, syllabus.notes),
      (l10n.subjectKeywords, syllabus.keywords),
      (l10n.subjectTargetCoursesAndAreas, syllabus.targetCourses),
      (l10n.subjectClassificationPrompt, syllabus.classifications),
      (l10n.subjectDSOPSubject, syllabus.dsopSubject),
      (l10n.subjectTeachingLanguage, syllabus.teachingLanguage),
      (l10n.subjectTeachingAndExamFormat, syllabus.teachingAndExamForm),
      (l10n.subjectContentsAndSchedule, syllabus.contentsAndSchedule),
      (l10n.subjectEnSummary, syllabus.enSummary),
      (l10n.subjectEnLearningOutcomes, syllabus.enLearningOutcomes),
      (l10n.subjectEnContentsAndSchedule, syllabus.enContentsAndSchedule),
      (l10n.subjectEnEvaluationMethod, syllabus.enEvaluationMethod),
      (l10n.subjectEnTeachingLanguage, syllabus.enTeachingLanguage),
      (l10n.subjectEnPrerequisites, syllabus.enPrerequisites),
      (l10n.subjectEnPrePostLearning, syllabus.enPrePostLearning),
      (l10n.subjectEnTextbooks, syllabus.enTextbooks),
      (l10n.subjectEnNotes, syllabus.enNotes),
      (l10n.subjectEnTeachingAndExamForm, syllabus.enTeachingAndExamForm),
      (l10n.subjectDiplomaPolicies, syllabus.diplomaPolicies),
      (l10n.subjectDiplomaPolicyCorrespondence, syllabus.diplomaPolicyCorrespondence),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8)
          .withBottomBarInset(context),
      child: DottoContent.single(
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (index, (title, value)) in items.indexed) ...[
              if (index > 0) const Divider(height: 0),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(value),
            ],
          ],
        ),
      ),
    );
  }
}

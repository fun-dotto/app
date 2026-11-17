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
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    // 英語版がある項目は、英語表示かつ英語版が空でなければ英語版を使う。
    String localized(String ja, String en) =>
        isEnglish && en.isNotEmpty ? en : ja;
    final showEnPrePostLearning =
        isEnglish && syllabus.enPrePostLearning.isNotEmpty;
    // API (SubjectSyllabus) のフィールド順に並べる。
    final items = <(String, String)>[
      (l10n.subjectYear, syllabus.year.toString()),
      (l10n.subjectName, localized(syllabus.name, syllabus.enName)),
      (l10n.subjectSyllabusGrades, syllabus.grades),
      (l10n.subjectTerm, syllabus.term),
      (l10n.subjectCredit, syllabus.credit),
      (l10n.subjectFacultyNames, syllabus.facultyNames),
      (
        l10n.subjectPracticalHomeFacultyCategory,
        syllabus.practicalHomeFacultyCategory,
      ),
      (
        l10n.subjectMultiplePersonTeachingForm,
        syllabus.multiplePersonTeachingForm,
      ),
      (l10n.subjectTeachingForm, syllabus.teachingForm),
      (l10n.subjectSummary, localized(syllabus.summary, syllabus.enSummary)),
      (
        l10n.subjectLearningOutcomes,
        localized(syllabus.learningOutcomes, syllabus.enLearningOutcomes),
      ),
      (l10n.subjectAssignments, syllabus.assignments),
      (
        l10n.subjectEvaluationMethodsAndCriteria,
        localized(syllabus.evaluationMethod, syllabus.enEvaluationMethod),
      ),
      (
        l10n.subjectTextbooks,
        localized(syllabus.textbooks, syllabus.enTextbooks),
      ),
      (l10n.subjectReferenceBooks, syllabus.referenceBooks),
      (
        l10n.subjectPrerequisites,
        localized(syllabus.prerequisites, syllabus.enPrerequisites),
      ),
      if (showEnPrePostLearning)
        (l10n.subjectPrePostLearning, syllabus.enPrePostLearning)
      else ...[
        (l10n.subjectPreLearning, syllabus.preLearning),
        (l10n.subjectPostLearning, syllabus.postLearning),
      ],
      (l10n.subjectNotes, localized(syllabus.notes, syllabus.enNotes)),
      (l10n.subjectKeywords, syllabus.keywords),
      (l10n.subjectTargetCoursesAndAreas, syllabus.targetCourses),
      (l10n.subjectClassificationPrompt, syllabus.classifications),
      (l10n.subjectDSOPSubject, syllabus.dsopSubject),
      (
        l10n.subjectTeachingLanguage,
        localized(syllabus.teachingLanguage, syllabus.enTeachingLanguage),
      ),
      (
        l10n.subjectTeachingAndExamFormat,
        localized(syllabus.teachingAndExamForm, syllabus.enTeachingAndExamForm),
      ),
      (
        l10n.subjectContentsAndSchedule,
        localized(syllabus.contentsAndSchedule, syllabus.enContentsAndSchedule),
      ),
      (l10n.subjectDiplomaPolicies, syllabus.diplomaPolicies),
      (
        l10n.subjectDiplomaPolicyCorrespondence,
        syllabus.diplomaPolicyCorrespondence,
      ),
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

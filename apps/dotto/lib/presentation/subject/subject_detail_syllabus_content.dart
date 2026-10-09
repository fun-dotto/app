import 'package:dotto/domain/entity/syllabus.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:material_ui/material_ui.dart';

/// シラバスの各項目の表示。
final class SubjectDetailSyllabusContent extends StatelessWidget {
  const new({required this.syllabus, super.key});

  final Syllabus syllabus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.subjectL10n.subjectSummary,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.summary),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectLearningOutcomes,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.learningOutcomes),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectAssignments,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.assignments),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectEvaluationMethodsAndCriteria,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.evaluationMethod),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectTextbooks,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.textbooks),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectReferenceBooks,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.referenceBooks),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectPrerequisites,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.prerequisites),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectPreLearning,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.preLearning),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectPostLearning,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.postLearning),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectNotes,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.notes),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectKeywords,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.keywords),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectTargetCoursesAndAreas,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.targetCourses),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectTargetAreas,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.targetAreas),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectClassificationPrompt,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.classifications),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectTeachingLanguage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.teachingLanguage),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectContentsAndSchedule,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.contentsAndSchedule),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectTeachingAndExamFormat,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.teachingAndExamForm),
          const Divider(height: 0),
          Text(
            context.subjectL10n.subjectDSOPSubject,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(syllabus.dsopSubject),
        ],
      ),
    );
  }
}

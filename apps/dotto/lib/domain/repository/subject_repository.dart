import 'package:dotto/domain/entity/subject.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_summary.dart';

abstract interface class SubjectRepository {
  Future<List<SubjectSummary>> getSubjects(String query, SubjectFilter filter);
  Future<Subject> getSubject(String id);
  Future<List<SubjectFeedback>> getFeedbacks(String lessonId);
  Future<void> createFeedback({
    required String userId,
    required String lessonId,
    required int score,
    required String comment,
  });
}

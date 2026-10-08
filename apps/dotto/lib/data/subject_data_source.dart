import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotto/helper/syllabus_database_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'subject_data_source.g.dart';

@riverpod
SubjectDataSource subjectDataSource(Ref ref) => const SubjectDataSource();

/// シラバスのローカルデータと Firestore のレビューを読み書きする。
class SubjectDataSource {
  const new();
  Future<String?> readPastExamId(String lessonId) async {
    final db = await SyllabusDatabaseHelper.getDatabase();
    final records = await db.query(
      'detail',
      columns: ['過去問'],
      where: 'LessonId = ?',
      whereArgs: [lessonId],
    );
    return (records.firstOrNull?['過去問'] as int?)?.toString();
  }

  Future<List<Map<String, dynamic>>> readFeedbacks(String lessonId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('feedback')
        .where('lessonId', isEqualTo: int.parse(lessonId))
        .get();
    return [for (final doc in snapshot.docs) doc.data()];
  }

  Future<void> writeFeedback({
    required String userId,
    required String lessonId,
    required int score,
    required String comment,
  }) async {
    final collection = FirebaseFirestore.instance.collection('feedback');
    final snapshot = await collection
        .where('User', isEqualTo: userId)
        .where('lessonId', isEqualTo: int.parse(lessonId))
        .get();
    final data = {'score': score.toDouble(), 'detail': comment};
    if (snapshot.docs.firstOrNull case final doc?) {
      await doc.reference.update(data);
    } else {
      await collection.add({
        'User': userId,
        'lessonId': int.parse(lessonId),
        ...data,
      });
    }
  }
}

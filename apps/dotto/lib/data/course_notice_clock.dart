import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'course_notice_clock.g.dart';

@riverpod
DateTime Function() courseNoticeClock(Ref ref) => DateTime.now;

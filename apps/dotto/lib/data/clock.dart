import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

@riverpod
DateTime Function() clock(Ref ref) => DateTime.now;

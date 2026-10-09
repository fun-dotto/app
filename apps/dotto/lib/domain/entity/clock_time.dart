import 'package:freezed_annotation/freezed_annotation.dart';
part 'clock_time.freezed.dart';

/// 日付とタイムゾーンに依存しない授業の開始・終了時刻。
@freezed
abstract class ClockTime with _$ClockTime {
  const factory({required int hour, required int minute}) = _ClockTime;
}

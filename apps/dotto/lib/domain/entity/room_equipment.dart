import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_equipment.freezed.dart';

/// 部屋の設備の利用可否。
enum RoomEquipmentQuality { unknown, unavailable, limited, available }

/// 部屋での飲食・コンセントの利用可否。
@freezed
abstract class RoomEquipment with _$RoomEquipment {
  const factory({
    required RoomEquipmentQuality food,
    required RoomEquipmentQuality drink,
    required RoomEquipmentQuality outlet,
  }) = _RoomEquipment;
}

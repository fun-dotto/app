//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/bus_stop.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bus_timetable_stop.g.dart';

/// BusTimetableStop
///
/// Properties:
/// * [tripId] 
/// * [stop] 
/// * [departureTime] 
@BuiltValue()
abstract class BusTimetableStop implements Built<BusTimetableStop, BusTimetableStopBuilder> {
  @BuiltValueField(wireName: r'tripId')
  String get tripId;

  @BuiltValueField(wireName: r'stop')
  BusStop get stop;

  @BuiltValueField(wireName: r'departureTime')
  DateTime get departureTime;

  BusTimetableStop._();

  factory BusTimetableStop([void updates(BusTimetableStopBuilder b)]) = _$BusTimetableStop;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BusTimetableStopBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BusTimetableStop> get serializer => _$BusTimetableStopSerializer();
}

class _$BusTimetableStopSerializer implements PrimitiveSerializer<BusTimetableStop> {
  @override
  final Iterable<Type> types = const [BusTimetableStop, _$BusTimetableStop];

  @override
  final String wireName = r'BusTimetableStop';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BusTimetableStop object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tripId';
    yield serializers.serialize(
      object.tripId,
      specifiedType: const FullType(String),
    );
    yield r'stop';
    yield serializers.serialize(
      object.stop,
      specifiedType: const FullType(BusStop),
    );
    yield r'departureTime';
    yield serializers.serialize(
      object.departureTime,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BusTimetableStop object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BusTimetableStopBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tripId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tripId = valueDes;
          break;
        case r'stop':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BusStop),
          ) as BusStop;
          result.stop.replace(valueDes);
          break;
        case r'departureTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.departureTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BusTimetableStop deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BusTimetableStopBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


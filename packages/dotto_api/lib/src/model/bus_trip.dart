//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/bus_alert.dart';
import 'package:openapi/src/model/bus_stop.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/bus_route.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bus_trip.g.dart';

/// BusTrip
///
/// Properties:
/// * [id] 
/// * [departureTime] 
/// * [arrivalTime] 
/// * [route] 
/// * [stops] - 乗車バス停、乗り換えバス停、降車バス停のリスト
/// * [delay] 
/// * [alert] 
@BuiltValue()
abstract class BusTrip implements Built<BusTrip, BusTripBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'departureTime')
  DateTime get departureTime;

  @BuiltValueField(wireName: r'arrivalTime')
  DateTime get arrivalTime;

  @BuiltValueField(wireName: r'route')
  BusRoute get route;

  /// 乗車バス停、乗り換えバス停、降車バス停のリスト
  @BuiltValueField(wireName: r'stops')
  BuiltList<BusStop> get stops;

  @BuiltValueField(wireName: r'delay')
  String get delay;

  @BuiltValueField(wireName: r'alert')
  BusAlert get alert;
  // enum alertEnum {  None,  Cancellation,  };

  BusTrip._();

  factory BusTrip([void updates(BusTripBuilder b)]) = _$BusTrip;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BusTripBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BusTrip> get serializer => _$BusTripSerializer();
}

class _$BusTripSerializer implements PrimitiveSerializer<BusTrip> {
  @override
  final Iterable<Type> types = const [BusTrip, _$BusTrip];

  @override
  final String wireName = r'BusTrip';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BusTrip object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'departureTime';
    yield serializers.serialize(
      object.departureTime,
      specifiedType: const FullType(DateTime),
    );
    yield r'arrivalTime';
    yield serializers.serialize(
      object.arrivalTime,
      specifiedType: const FullType(DateTime),
    );
    yield r'route';
    yield serializers.serialize(
      object.route,
      specifiedType: const FullType(BusRoute),
    );
    yield r'stops';
    yield serializers.serialize(
      object.stops,
      specifiedType: const FullType(BuiltList, [FullType(BusStop)]),
    );
    yield r'delay';
    yield serializers.serialize(
      object.delay,
      specifiedType: const FullType(String),
    );
    yield r'alert';
    yield serializers.serialize(
      object.alert,
      specifiedType: const FullType(BusAlert),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BusTrip object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BusTripBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'departureTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.departureTime = valueDes;
          break;
        case r'arrivalTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.arrivalTime = valueDes;
          break;
        case r'route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BusRoute),
          ) as BusRoute;
          result.route.replace(valueDes);
          break;
        case r'stops':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BusStop)]),
          ) as BuiltList<BusStop>;
          result.stops.replace(valueDes);
          break;
        case r'delay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.delay = valueDes;
          break;
        case r'alert':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BusAlert),
          ) as BusAlert;
          result.alert = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BusTrip deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BusTripBuilder();
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


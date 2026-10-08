//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/bus_trip.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bus_trips_v1_list200_response.g.dart';

/// BusTripsV1List200Response
///
/// Properties:
/// * [busTrips] 
@BuiltValue()
abstract class BusTripsV1List200Response implements Built<BusTripsV1List200Response, BusTripsV1List200ResponseBuilder> {
  @BuiltValueField(wireName: r'busTrips')
  BuiltList<BusTrip> get busTrips;

  BusTripsV1List200Response._();

  factory BusTripsV1List200Response([void updates(BusTripsV1List200ResponseBuilder b)]) = _$BusTripsV1List200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BusTripsV1List200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BusTripsV1List200Response> get serializer => _$BusTripsV1List200ResponseSerializer();
}

class _$BusTripsV1List200ResponseSerializer implements PrimitiveSerializer<BusTripsV1List200Response> {
  @override
  final Iterable<Type> types = const [BusTripsV1List200Response, _$BusTripsV1List200Response];

  @override
  final String wireName = r'BusTripsV1List200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BusTripsV1List200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'busTrips';
    yield serializers.serialize(
      object.busTrips,
      specifiedType: const FullType(BuiltList, [FullType(BusTrip)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BusTripsV1List200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BusTripsV1List200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'busTrips':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BusTrip)]),
          ) as BuiltList<BusTrip>;
          result.busTrips.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BusTripsV1List200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BusTripsV1List200ResponseBuilder();
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


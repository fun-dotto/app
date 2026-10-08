//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bus_alert.g.dart';

class BusAlert extends EnumClass {

  @BuiltValueEnumConst(wireName: r'None')
  static const BusAlert none = _$none;
  @BuiltValueEnumConst(wireName: r'Cancellation')
  static const BusAlert cancellation = _$cancellation;

  static Serializer<BusAlert> get serializer => _$busAlertSerializer;

  const BusAlert._(String name): super(name);

  static BuiltSet<BusAlert> get values => _$values;
  static BusAlert valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class BusAlertMixin = Object with _$BusAlertMixin;


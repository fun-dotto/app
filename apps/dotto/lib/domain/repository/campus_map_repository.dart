import 'package:dotto/domain/entity/campus_map.dart';

abstract interface class CampusMapRepository {
  Future<CampusMap> getCampusMap();
}

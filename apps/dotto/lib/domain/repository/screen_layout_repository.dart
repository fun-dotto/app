import 'package:dotto/domain/entity/screen_layout.dart';

abstract interface class ScreenLayoutRepository {
  Future<ScreenLayout> fetch();
}

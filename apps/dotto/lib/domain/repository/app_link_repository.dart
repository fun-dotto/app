import 'package:dotto/domain/entity/app_links.dart';

abstract interface class AppLinkRepository {
  AppLinks fetch();
}

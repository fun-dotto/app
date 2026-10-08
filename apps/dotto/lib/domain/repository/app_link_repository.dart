import 'package:dotto/domain/app_links.dart';

abstract interface class AppLinkRepository {
  AppLinks fetch();
}

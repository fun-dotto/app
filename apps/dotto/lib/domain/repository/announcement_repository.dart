import 'package:dotto/domain/entity/announcement.dart';

abstract interface class AnnouncementRepository {
  Future<List<Announcement>> fetchAll();
}

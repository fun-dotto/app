import 'package:dotto/domain/announcement.dart';

abstract interface class AnnouncementRepository {
  Future<List<Announcement>> fetchAll();
}

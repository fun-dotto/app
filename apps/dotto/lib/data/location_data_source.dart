import 'package:dotto/foundation/log/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_data_source.g.dart';

@riverpod
LocationDataSource locationDataSource(Ref ref) =>
    LocationDataSource(ref.watch(loggerProvider));

final class LocationDataSource {
  const new(this._logger);
  final Logger _logger;
  static const double _universityLat = 41.841889;
  static const double _universityLng = 140.766962;
  static const double _nearThresholdMeters = 250;

  Future<bool> isNearUniversity() async {
    try {
      final position = await determinePosition().timeout(
        const Duration(seconds: 5),
      );
      if (position == null) return false;
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        _universityLat,
        _universityLng,
      );
      return distance <= _nearThresholdMeters;
    } on Exception catch (error, stack) {
      await _logger.logError(error, stack);
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    switch (await Geolocator.checkPermission()) {
      case .denied:
        switch (await Geolocator.requestPermission()) {
          case .denied:
            return false;
          case .deniedForever:
            return false;
          case .whileInUse:
            return true;
          case .always:
            return true;
          case .unableToDetermine:
            return true;
        }
      case .deniedForever:
        return false;
      case .whileInUse:
        return true;
      case .always:
        return true;
      case .unableToDetermine:
        return true;
    }
  }

  Future<Position?> determinePosition() async {
    if (await requestLocationPermission()) {
      return await Geolocator.getCurrentPosition();
    } else {
      return null;
    }
  }
}

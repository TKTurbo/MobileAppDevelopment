import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationHelper {
  static double calculateDistance(LatLng start, LatLng end) {
    const double radius = 6371; // Radius of Earth in km
    double lat1 = start.latitude * pi / 180;
    double lon1 = start.longitude * pi / 180;
    double lat2 = end.latitude * pi / 180;
    double lon2 = end.longitude * pi / 180;

    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;

    double a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = radius * c;
    return double.parse(distance.toStringAsFixed(3)); // Limit to 3 decimals
  }

  // TODO: Only retrieve occasional updates and cache
  // TODO: If it takes too long, or we are denied, we should correctly handle it
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
    if (lastKnownPosition != null) {
      return lastKnownPosition;
    }

    return await Geolocator.getCurrentPosition();
  }

}

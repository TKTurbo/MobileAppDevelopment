import 'dart:math';
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
}

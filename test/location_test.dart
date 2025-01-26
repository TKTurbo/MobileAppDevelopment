import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app_development/helpers/LocationHelper.dart';

void main() {
  test('Given start coordinates are (0.0) and end coordinates are (0.1) when calculateDistance is called then return 11.119', () {
    LatLng start = const LatLng(0.0, 0.0);
    LatLng end = const LatLng(0.0, 0.1);
    expect(LocationHelper.calculateDistance(start, end), 11.119);
  });

  test('Given start and end are equal when calculateDistance is called then return 0.00 km', () {
    LatLng start = const LatLng(0.0, 0.0);
    LatLng end = const LatLng(0.0, 0.0);
    expect(LocationHelper.calculateDistance(start, end), 0.0);
  });
}
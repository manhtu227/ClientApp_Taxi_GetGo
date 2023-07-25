import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  List<PointLatLng> polylinePoints;
  String totalDistance;
  String totalDuration;

  Directions({
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    // if ((map['routes'] as List).isEmpty) return null;

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // // Bounds
    // final northeast = data['bounds']['northeast'];
    // final southwest = data['bounds']['southwest'];
    // final bounds = LatLngBounds(
    //   northeast: LatLng(northeast['lat'], northeast['lng']),
    //   southwest: LatLng(southwest['lat'], southwest['lng']),
    // );

    // Distance & Duration
    // if ((data['legs'] as List).isNotEmpty) {
    // final leg = data['legs'][0];
    String distance = data['distanceMeters'].toString();
    String duration = data['duration'].toString();
    // }

    return Directions(
      polylinePoints:
          PolylinePoints().decodePolyline(data['polyline']['encodedPolyline']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}

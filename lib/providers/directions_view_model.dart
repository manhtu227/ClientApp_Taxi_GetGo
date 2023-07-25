import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/services/googlemap/api_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/directions.dart';

class DirectionsViewModel with ChangeNotifier {
  Directions _info = Directions(
    polylinePoints: [],
    totalDistance: '0',
    totalDuration: '0',
  );
  LocationModel _currentLocation =
      LocationModel(title: '', summary: '', placeID: '');
  LocationModel _desLocation =
      LocationModel(title: '', summary: '', placeID: '');
  LocationModel _myLocation =
      LocationModel(title: '', summary: '', placeID: '');
  LocationModel get myLocation => _myLocation;
  LocationModel get currentLocation => _currentLocation;
  LocationModel get desLocation => _desLocation;

  List<PointLatLng> get polylinePoints => _info.polylinePoints;
  String get totalDistance => _info.totalDistance;
  String get totalDuration => _info.totalDuration;
  // update

  void updatePolylinePoints(List<PointLatLng> polylinePoints) {
    _info.polylinePoints = polylinePoints;
    notifyListeners();
  }

  void updateTotalDistance(String totalDistance) {
    _info.totalDistance = totalDistance;
    notifyListeners();
  }

  void updateTotalDuration(String totalDuration) {
    _info.totalDuration = totalDuration;
    notifyListeners();
  }

  void updateCurrentLocation(LocationModel location) async {
    print('hi');
    print(location);
    location.coordinates = await APIPlace.getLatLng(location.placeID);
    _currentLocation = location;
    notifyListeners();
  }

  void updateMyLocation(LocationModel location) async {
    print(location);
    _myLocation = location;
    notifyListeners();
  }

  Future<void> updateDesLocation(LocationModel location) async {
    print(myLocation.coordinates);
    location.coordinates = await APIPlace.getLatLng(location.placeID);
    _desLocation = location;
    notifyListeners();
  }

  Future<void> createPolylines() async {
    print(_currentLocation.coordinates);
    print(_desLocation.coordinates);
    print('neeeee');
    final directions = await APIPlace.getDirections(
        origin: _currentLocation.coordinates,
        destination: _desLocation.coordinates);
    print('hehehhafabsfhasf');
    print(directions.polylinePoints);
    _info = directions;
    notifyListeners();
  }

  Future<void> updateLocationData() async {
    print('heeeeeeeeeee');
    LatLng currentLocation = await APIPlace.getCurrentLocation();
    _myLocation = await APIPlace.getAddressFromLatLng(currentLocation);
    _currentLocation = _myLocation;
    // notifyListeners();
  }
}

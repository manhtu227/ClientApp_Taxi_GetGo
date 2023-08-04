import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/services/googlemap/api_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/directions.dart';

class DirectionsViewModel with ChangeNotifier {
  Directions _info = Directions(
    polylinePoints: [],
    totalDistance: 0,
    totalDuration: '0',
  );
  LocationModel _currentLocation =
      LocationModel(title: '', summary: '', placeID: '');
  LocationModel _desLocation = LocationModel(
      title: '',
      summary: '',
      placeID: '',
      coordinates: LatLng(10.7757, 106.7004));
  LocationModel _myLocation =
      LocationModel(title: '', summary: '', placeID: '');
  LocationModel _driverLocation =
      LocationModel(title: '', summary: '', role: 'driver');
  List<PointLatLng> get polylinePoints => _info.polylinePoints;
  double get totalDistance => _info.totalDistance;
  String get totalDuration => _info.totalDuration;
  LocationModel get myLocation => _myLocation;
  LocationModel get currentLocation => _currentLocation;
  LocationModel get desLocation => _desLocation;

  // update

  void updatePolylinePoints(List<PointLatLng> polylinePoints) {
    _info.polylinePoints = polylinePoints;
    notifyListeners();
  }

  void updateTotalDistance(double totalDistance) {
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
    if (location.placeID != '') {
      location.coordinates = await APIPlace.getLatLng(location.placeID);
    }
    _currentLocation = location;
    notifyListeners();
  }

  void updateDriverLocation(LatLng location, double heading) async {
    // print('hi');
    // print(location);
    // if (location.placeID != '') {
    //   location.coordinates = await APIPlace.getLatLng(location.placeID);
    // }
    _driverLocation = LocationModel(title: '', summary: '',coordinates: location,heading: heading);
    notifyListeners();
  }

  void updateMyLocation(LocationModel location) async {
    print(location);
    _myLocation = location;
    notifyListeners();
  }

  Future<void> updateDesLocation(LocationModel location) async {
    if (location.placeID != '') {
      location.coordinates = await APIPlace.getLatLng(location.placeID);
    }
    _desLocation = location;
    notifyListeners();
  }

  Future<void> createPolylines(Function updatePrice) async {
    print(_currentLocation.coordinates);
    print(_desLocation.coordinates);
    print('neeeee');
    final directions = await APIPlace.getDirections(
        origin: _currentLocation.coordinates,
        destination: _desLocation.coordinates);
    updatePrice(directions.totalDuration, directions.totalDistance);
    Map<String, dynamic> map = {};
    // print('hehehheheeaaa');
    // String H = '';
    // for (PointLatLng k in directions.polylinePoints) {
    //   H += 'PointLatLng(${k.latitude.toString()},${k.longitude.toString()}),';
    //   print(k);
    // }
    // print(H);
    // _currentLocation.summary = H;
    // _currentLocation.summary = directions.polylinePoints as String;
    // print('hehehhafabsfhasf');
    // print(directions.polylinePoints);
    _info = directions;
    // _info = Directions.fromMap(map);

    notifyListeners();
  }

  Future<void> updateLocationData() async {
    print('heeeeeeeeeee');
    try {
      Location location = Location();
      location.getLocation().then((location) async {
        _myLocation = await APIPlace.getAddressFromLatLng(
            LatLng(location.latitude!, location.longitude!));
      });
      location.onLocationChanged.listen((newLocation) async {
        _myLocation = await APIPlace.getAddressFromLatLng(
            LatLng(newLocation.latitude!, newLocation.longitude!));
        notifyListeners();
      });
    } catch (e) {
      throw Exception('Request failed with status: $e}');
    }
    // _myLocation = await APIPlace.getAddressFromLatLng(currentLocation);
    // _currentLocation = _myLocation;
    // notifyListeners();
  }
}

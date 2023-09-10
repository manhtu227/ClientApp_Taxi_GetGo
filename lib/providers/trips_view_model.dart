import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/models/tripModel.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/list_trip_model.dart';
import 'package:clientapp_taxi_getgo/services/googlemap/api_places.dart';
import 'package:clientapp_taxi_getgo/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../models/directions.dart';

class TripsViewModel with ChangeNotifier {
  Directions _info = Directions(
    polylinePoints: [],
    totalDistance: 0,
    totalDuration: '0',
  );
  String statusTrip = '';
  int _idTrip = 0;
  LocationModel _currentLocation =
      LocationModel(title: '', summary: '', placeID: '');
  LocationModel _desLocation = LocationModel(
      title: '',
      summary: '',
      placeID: '',
      coordinates: LatLng(10.7757, 106.7004));

  LocationModel _driverLocation =
      LocationModel(title: '', summary: '', status: '');
  bool _isSchedule = false;
  bool _checkActive = false;

  DateTime _dateSchedule = DateTime.now();

  LocationModel _myLocation =
      LocationModel(title: '', summary: '', placeID: '');
  bool get schedule => _isSchedule;
  bool get checkActive => _checkActive;
  DateTime get dateSchedule => _dateSchedule;
  List<PointLatLng> get polylinePoints => _info.polylinePoints;
  int get tripId => _idTrip;
  double get totalDistance => _info.totalDistance;
  String get totalDuration => _info.totalDuration;
  LocationModel get myLocation => _myLocation;
  LocationModel get driverLocation => _driverLocation;
  LocationModel get currentLocation => _currentLocation;
  LocationModel get desLocation => _desLocation;
  Directions get info => _info;

  final List<Map<String, String>> _message = [
    {"5": 'Chào em', "time": '10:00'},
    {"0": 'Chào anh', "time": '10:05'}
  ];
  List<Map<String, String>> get message => _message;
  void pushMessage(String text, String id, String time) {
    _message.add({id: text, "time": time});
    notifyListeners();

  }

  void setShedule(bool isSchedule, DateTime schedule) {
    _isSchedule = isSchedule;
    _dateSchedule = schedule;
    notifyListeners(); // Thông báo cho các người nghe (listeners) về sự thay đổi
  }

  void updateCheckActive(bool check) {
    _checkActive = check;
  }

  // update
  void updateTripID(int id, BuildContext context) {
    _idTrip = id;
    TripModel trip = context.read<ListTripViewModel>().tripByID(id);
    _info = trip.info;
    statusTrip = trip.statusTrip;
    _currentLocation = trip.currentLocation;
    _desLocation = trip.desLocation;
    _isSchedule = trip.isSchedule;
    _dateSchedule = trip.dateSchedule;
  }

  void updatePolylinePoints(List<PointLatLng> polylinePoints) {
    _info.polylinePoints = polylinePoints;
    // notifyListeners();
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

  void updateDriverLocation(
      LatLng location, double heading, String status) async {
    // print('hi');
    // print(location);
    // if (location.placeID != '') {
    //   location.coordinates = await APIPlace.getLatLng(location.placeID);
    // }
    _driverLocation = LocationModel(
        title: '',
        summary: '',
        coordinates: location,
        heading: heading,
        status: status);
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

  Future<void> updatePolylines(LatLng current, LatLng des) async {
    // _info.polylinePoints .sublist(10);

    final directions =
        await APIPlace.getDirections(origin: current, destination: des);
    print('cout<< ' + directions.polylinePoints.toString());
    // if (_driverLocation.status == 'comming' &&
    //     directions.totalDistance <= 0.5) {
    //   Notifications show = new Notifications();
    //   show.showNotification("Tài xế sắp đến");
    // }
    _info = directions;
    // _info = Directions.fromMap(map);

    notifyListeners();
  }

  Future<void> updatePolylines1(String directions) async {
    _info.polylinePoints = PolylinePoints().decodePolyline(directions);

    notifyListeners();
  }

  Future<void> updateLocationData() async {
    print('heeeeeeeeeee');
    try {
      Location location = Location();
      location.getLocation().then((location) async {
        _myLocation = await APIPlace.getAddressFromLatLng(
            location.latitude!, location.longitude!);
      });
      location.onLocationChanged.listen((newLocation) async {
        _myLocation = await APIPlace.getAddressFromLatLng(
            newLocation.latitude!, newLocation.longitude!);
        // notifyListeners();
      });
    } catch (e) {
      throw Exception('Request failed with status: $e}');
    }
    // _myLocation = await APIPlace.getAddressFromLatLng(currentLocation);
    // _currentLocation = _myLocation;
    // notifyListeners();
  }

  void reset() {
    _info = Directions(
      polylinePoints: [],
      totalDistance: 0,
      totalDuration: '0',
    );
    statusTrip = '';
    _idTrip = 0;
    _currentLocation = LocationModel(title: '', summary: '', placeID: '');
    _desLocation = LocationModel(
        title: '',
        summary: '',
        placeID: '',
        coordinates: LatLng(10.7757, 106.7004));

    _driverLocation = LocationModel(title: '', summary: '', status: '');
    _dateSchedule = DateTime.now();
  }
}

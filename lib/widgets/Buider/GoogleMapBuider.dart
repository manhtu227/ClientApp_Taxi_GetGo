import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/widgets/map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapBuider {
  LocationModel _currentLocation;
  LocationModel? _desLocation;
  List<PointLatLng> _listPoint = [];
  List<LatLng> _listDrive = [];
  Function? _pickup;
  String _icon = "assets/images/CurrentDetail.png";
  GoogleMapBuider({required LocationModel currentLocation})
      : _currentLocation = currentLocation;

  GoogleMapBuider updateIconCurrent(String icon) {
    _icon = icon;
    return this;
  }

  GoogleMapBuider setDesLocation(LocationModel location) {
    _desLocation = location;
    return this;
  }

  GoogleMapBuider setPolyline(List<PointLatLng> listPoint) {
    _listPoint = listPoint;
    return this;
  }

  GoogleMapBuider setListDrive(List<LatLng> listDrive) {
    _listDrive = listDrive;
    return this;
  }

  GoogleMapBuider setPickUp(Function pickup) {
    _pickup = pickup;
    return this;
  }

  MapScreen build() {
    return MapScreen(
      icon: _icon,
      pickup: _pickup,
      currentLocation: _currentLocation,
      desLocation: _desLocation,
      listPoint: _listPoint,
      listDrive: _listDrive,
    );
  }
}

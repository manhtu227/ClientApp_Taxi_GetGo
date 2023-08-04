import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/services/apis/api_driver.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverProvider with ChangeNotifier {
  List<LatLng> _listDriver = [];

  List<LatLng> get listDriver => _listDriver;
  Future<void> updatelistDriver(LatLng position) async {
    Response reponse = await ApiDriver.getAllDriver(position);
    print(reponse.statusCode);
    if (reponse.statusCode == 200) {
      print(reponse.data['random']);
      _listDriver = reponse.data['random'].map<LatLng>((item) {
        double lat = item['lat'];
        double lng = item['lng'];
        return LatLng(lat, lng);
      }).toList();
    }

    notifyListeners();
  }
}

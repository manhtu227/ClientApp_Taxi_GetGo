import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/models/userModel.dart';
import 'package:clientapp_taxi_getgo/services/apis/api_driver.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserViewModel with ChangeNotifier {
  final UserModel _user = UserModel(
    avatar: "assets/imgs/avatar.jpg",
    name: "Nguyễn Đăng Mạnh Tú",
    phone: "0909100509",
    email: "tumanh222702@gmail.com",
    id: "5",
    gender: "đực",
    birthDate: "??/??/????",
    type: 'User_vip',
    token: '',
  );
  List<LatLng> _listDriver = [];
  Future<void> updateUser(Map<String, dynamic> data) async {
    _user.avatar = data["avatar"];
    _user.name = data["name"];
    _user.phone = data["phone"];
    _user.id = data["id"];
    _user.token = data["accessToken"];
    notifyListeners();
  }

  UserModel get user => _user;
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

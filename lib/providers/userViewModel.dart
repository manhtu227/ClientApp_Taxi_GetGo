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
    token:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwicGhvbmUiOiIrODQ1NTU1NTU1NTUiLCJ0eXBlIjoiVXNlciIsImlhdCI6MTY5NDA5MjQ3OSwiZXhwIjoxNjk1MTcyNDc5fQ.Zp05KJgetJGPndOc_9u7qcH99MHzFADFt9-RtD_iQ7c',
  );
  List<LatLng> _listDriver = [];
  void updateUser(Map<String, dynamic> data) {
    print('cout<<<<$data');
    _user.avatar =
        'https://inkythuatso.com/uploads/thumbnails/800/2022/03/anh-dai-dien-facebook-dep-cho-nam-53-28-16-28-17.jpg';
    _user.name = data["name"];
    _user.phone = data["phone"];
    _user.id = data["user_id"].toString();
    _user.token = data["accessToken"];
    // notifyListeners();
  }

  String get idUser => _user.id;
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

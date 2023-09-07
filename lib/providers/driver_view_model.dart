import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/models/userModel.dart';
import 'package:clientapp_taxi_getgo/services/apis/api_driver.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverProvider with ChangeNotifier {
  final UserModel _driver = UserModel(
    avatar: "assets/imgs/avatar.jpg",
    name: "Nguyễn Đăng Mạnh Tú",
    phone: "0909100509",
    email: "tumanh222702@gmail.com",
    id: "875876123",
    gender: "đực",
    birthDate: "??/??/????",
    typeCar: "xe 4 bánh",
    idCard: "59 - 74A -976237890146",
    type: 'driver',
    descriptionCar:
        "mecedes màu đen có 4 cái cữa, có 4 bánh xe, có 4 chỗ, có tay lái, có phanh xe và có đứa ngáo ngáo tên Tú lái nó",
  );
  List<LatLng> _listDriver = [];
  Future<void> updateDriver(Map<String, dynamic> data) async {
    print('cout<< may ne: ${data}');
    print('cout<< may ne: ${data["statics"]["successResult"]}');
    _driver.avatar = data["driver_info"]["avatar"];
    _driver.name = data["driver_info"]["name"];
    _driver.phone = data["driver_info"]["avatar"];
    // _driver.email = data["driver_info"]["email"];
    // _driver.gender = data["driver_info"]["gender"];
    // _driver.birthDate = data["driver_info"]["birthday"];
    _driver.typeCar = data["driver_info"]["type"];
    _driver.license_plate =
        data["driver_info"]["driver_vehicle"]["license_plate"];
    _driver.nameCar = data["driver_info"]["driver_vehicle"]["name"];
    _driver.rating = data["statics"]["starResult"]/1;
    _driver.number_of_trips = data["statics"]["number_of_trips"];
    _driver.successResult = data["statics"]["successResult"];
    print("cout<< may ne: $_driver");
    notifyListeners();
  }

  UserModel get driver => _driver;
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

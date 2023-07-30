import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:flutter/material.dart';

class CarTypeProvider with ChangeNotifier {
  final List<CarTypeModel> _listCar = [
    CarTypeModel(
      carType: '4',
      title: 'GetGo Car',
      iconAsset: 'assets/svgs/Car.svg',
      iconDistanceAsset: 'assets/images/lyingCar.png',
      duration: '4',
      capacity: '4 chỗ',
      price: 31,
      price1km: 11,
    ),
    CarTypeModel(
      carType: '7',
      title: 'GetGo CarXL',
      iconDistanceAsset: 'assets/images/lyingCarBlack.png',
      iconAsset: 'assets/svgs/Car.svg',
      duration: '4',
      capacity: '7 chỗ',
      price: 31,
      price1km: 14.5,
    ),
    CarTypeModel(
      carType: 'bike',
      title: 'GetGo Bike',
      iconDistanceAsset: 'assets/images/lyingMotobike.png',
      iconAsset: 'assets/svgs/Car.svg',
      duration: '4',
      capacity: '9 chỗ',
      price: 31,
      price1km: 5,
    ),
  ];
  String _selectedCarType = "4";

  String get selectedCarType => _selectedCarType;
  List<CarTypeModel> get listCar => _listCar;
  set selectedCarType(String type) {
    _selectedCarType = type;
    notifyListeners();
  }

  void updatePriceByType(String duration, double km) {
    print('heeeloot nè');
    for (final car in _listCar) {
      // if (CarType == "bike") {
      car.duration = duration;
      car.price = (car.price1km * km).roundToDouble();
      // }
    }
    notifyListeners();
  }
}

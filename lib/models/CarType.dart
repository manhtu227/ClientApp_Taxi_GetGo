import 'package:clientapp_taxi_getgo/configs/configDev.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarTypeModel {
  String carType;
  final String title;
  final String iconAsset;
  final String iconDistanceAsset;
  String duration;
  final String capacity;
  double price;
  final double price1km;

  CarTypeModel({
    required this.carType,
    required this.title,
    required this.iconAsset,
    required this.iconDistanceAsset,
    required this.duration,
    required this.capacity,
    required this.price1km,
    required this.price,
  });
}

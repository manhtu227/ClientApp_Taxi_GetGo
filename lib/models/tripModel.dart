import 'package:clientapp_taxi_getgo/models/directions.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/models/userModel.dart';

class TripModel {
  Directions info;
  String statusTrip;
  int idTrip;
  LocationModel currentLocation;
  LocationModel desLocation;
  bool isSchedule;
  DateTime dateSchedule;
  UserModel? driver;
  // LocationModel? driverLocation;
  TripModel(
      {required this.info,
      required this.statusTrip,
      required this.idTrip,
      required this.currentLocation,
      required this.desLocation,
      required this.isSchedule,
      required this.dateSchedule,
      this.driver});
}

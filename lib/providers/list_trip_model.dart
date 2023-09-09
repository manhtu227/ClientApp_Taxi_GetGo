import 'package:clientapp_taxi_getgo/models/directions.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/models/tripModel.dart';
import 'package:clientapp_taxi_getgo/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListTripViewModel with ChangeNotifier {
  final List<TripModel> _trips = [
    TripModel(
        info: Directions(
          polylinePoints: [],
          totalDistance: 0,
          totalDuration: '0',
        ),
        statusTrip: '',
        idTrip: 0,
        currentLocation: LocationModel(title: '', summary: '', placeID: ''),
        desLocation: LocationModel(
            title: '',
            summary: '',
            placeID: '',
            coordinates: LatLng(10.7757, 106.7004)),
        isSchedule: false,
        dateSchedule: DateTime.now(),
        driver: null)
  ];
  bool checkTrip(int id) {
    for (TripModel trip in _trips) {
      if (trip.idTrip == id) {
        return true;
      }
    }
    return false;
  }

  TripModel tripByID(int id) {
    print("print($id)");
    TripModel trip = _trips.firstWhere((trip) => trip.idTrip == id);
    return trip;
  }

  void updateDriverWithTrip(int idTrip, Map<String, dynamic> data) {
    double x = 5.3333;
    x.toStringAsFixed(2);
    print('thông tin driver${data["driver_info"]}');
    UserModel check = UserModel(
      avatar:
          'https://1.bp.blogspot.com/-mkEhP_QXSHI/WE9-UdNKnyI/AAAAAAAACpc/z5mdcFZbQz41dhnXknAeGTRhG1Xj3jfQgCLcB/s1600/15085502_591915637681021_5420424684372040797_n.jpg',
      name: data["driver_info"]["name"],
      phone: data["driver_info"]["avatar"],
      email: 'manhtu',
      id: data["driver_info"]['id'].toString(),
      type: data["driver_info"]["type"],
      gender: 'gender',
      typeCar: data["driver_info"]["type"],
      license_plate: data["driver_info"]["driver_vehicle"]["license_plate"],
      nameCar: data["driver_info"]["driver_vehicle"]["name"],
      rating: (data["statics"]["starResult"] / 1).toStringAsFixed(1),
      number_of_trips: data["statics"]["number_of_trips"],
      successResult: data["statics"]["successResult"],
    );
    final tripToUpdate = _trips.firstWhere((trip) => trip.idTrip == idTrip);
    tripToUpdate.driver = check;
  }

  void addTrip(TripModel trip) {
    _trips.add(trip);
  }
}

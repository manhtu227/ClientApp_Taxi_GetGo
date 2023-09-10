import 'dart:convert';

import 'package:clientapp_taxi_getgo/configs/api_config.dart';
import 'package:clientapp_taxi_getgo/models/directions.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/models/tripModel.dart';
import 'package:clientapp_taxi_getgo/providers/list_trip_model.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/userViewModel.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/dialogSuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService with ChangeNotifier {
  late io.Socket _socket;
  io.Socket get socket => _socket;
// const tk = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwicGhvbmUiOiIrODQ0NDQ0NDQ0NDQiLCJ0eXBlIjoiVXNlcl9WaXAiLCJpYXQiOjE2OTA5NjM0NzksImV4cCI6MTY5MjA0MzQ3OX0.o0kfUy4iiG5kyYoB3ea8URXpISHenDkopQdlKvwtNeU'

// const socket = io.connect("ws://localhost:3000", {
//     transports: ['websocket'], query: {
//         token: tk
//     }
// })
  void connectserver(BuildContext context) {
    // String tk =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwicGhvbmUiOiIrODQ0NDQ0NDQ0NDQiLCJ0eXBlIjoiVXNlcl9WaXAiLCJpYXQiOjE2OTA5NjM0NzksImV4cCI6MTY5MjA0MzQ3OX0.o0kfUy4iiG5kyYoB3ea8URXpISHenDkopQdlKvwtNeU";

    _socket = io.io(
        ApiConfig.baseUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .build());
    _socket.onConnect(
      (data) {
        _socket.emit('user-login', {"user_id": context.read<UserViewModel>().idUser});
        userFoundDriver(context);
        handleTripUpdate(context);
        scheduleStart(context);
        reconectSocket(context);
        receiptMessage(context);
        // getLocationDriver(context);
        print("connect " + _socket.id.toString());
      },
    );
    _socket.onDisconnect((data) {
      print("disconnect");
    });

    _socket.onConnectError((data) {
      print("err:");
      print(data);
    });
  }

  void disconnect() {
    _socket.disconnect();
  }

  void userFindTrip(Map<String, dynamic> data) {
    print("cout<< " + data["trip_info"].toString());

    _socket.emit('user-find-trip', data["trip_info"]);
  }

  TripModel getTrip(Map<String, dynamic> data, bool check) {
    return TripModel(
      info: Directions(
          polylinePoints: [],
          totalDistance:
              check ? data['distance'] : double.parse(data['distance']),
          totalDuration: '5'), //)data['duration']),
      statusTrip: data['status'],
      idTrip: check ? data['trip_id'] : data['id'],
      currentLocation: LocationModel(
        title: 'Điểm đi',
        summary: data['start']['place'],
        coordinates: LatLng(
          data['start']['lat'] / 1,
          data['start']['lng'] / 1,
        ),
      ),
      desLocation: LocationModel(
        title: 'Điểm đi',
        summary: data['end']['place'],
        coordinates: LatLng(
          data['end']['lat'] / 1,
          data['end']['lng'] / 1,
        ),
      ),
      // driverLocation: driverLocation,
      isSchedule: data['is_scheduled'],
      dateSchedule: DateTime.parse(data['schedule_time']), // DateTime.now()
    );
  }

  void reconectSocket(BuildContext context) {
    _socket.on('user-reconnect', (data) {
      print('cin>>1 ${data}');
      print('cin>>2 ${data['schedule']}');
      final providerTrip = context.read<TripsViewModel>();
      if (data['active'] != null) {
        TripModel add = getTrip(data['active'], true);
        context.read<ListTripViewModel>().addTrip(add);
        context
            .read<ListTripViewModel>()
            .updateDriverWithTrip(add.idTrip, data['active']['driver']);
        providerTrip.updateTripID(data['active']['trip_id'], context);
        providerTrip.updateDriverLocation(
            LatLng(data['active']['driver']['location']['lat'] / 1,
                data['active']['driver']['location']['lng'] / 1),
            data['active']['driver']['location']['heading'] / 1,
            'comming');
        providerTrip.updateCheckActive(true);
        context.read<DriverProvider>().updateDriver(data['active']['driver']);
      }
      print('cin>> ${(data['schedule']).length}');
      if (data['schedule'].length != 0) {
        for (Map<String, dynamic> tripSchedule in data['schedule']) {
          print('cin>> $tripSchedule');
          TripModel add = getTrip(tripSchedule, false);
          context.read<ListTripViewModel>().addTrip(add);
          if (tripSchedule['driver'] != null) {
            context.read<ListTripViewModel>().updateDriverWithTrip(
                tripSchedule['id'], tripSchedule['driver']);
          }
        }
      }
    });
  }

  void userFoundDriverSchedule(BuildContext context) {
    _socket.on('found-driver-schedule', (data) {});
  }

  void userFoundDriver(BuildContext context) {
    _socket.on('found-driver', (data) async {
      // if (data["is_scheduled"]) {
      //   context
      //       .read<ListTripViewModel>()
      //       .updateDriverWithTrip(data["trip_id"], data["driver_info"]);
      // } else {
      context.read<TripsViewModel>().updateTripID(data['trip_id'], context);
      context.read<TripsViewModel>().updateDriverLocation(
          LatLng(data['lat'] / 1, data['lng'] / 1),
          data['heading'] / 1,
          'comming');
      print("cout<< cho chet :${data["driver_info"]}");
      print("cout<< cho chet :$data");

      await context.read<TripsViewModel>().updatePolylines(
          LatLng(data['lat'] / 1, data['lng'] / 1),
          context.read<TripsViewModel>().currentLocation.coordinates);
      await context.read<DriverProvider>().updateDriver(data["driver_info"]);
      Navigator.of(context).pushNamed(Routes.DriverArrive,
          arguments: {'name': 'Driver is Arriving..', 'check': true});
      // Navigator.of(context).pushNamed(Routes.DriverArrive);
      // }
    });
  }

  void scheduleStart(BuildContext context) {
    _socket.on('schedule-start', (data) async {
      final providerTrip = context.read<TripsViewModel>();
      final providerListTrip = context.read<ListTripViewModel>();
      print('print( $data)');
      providerTrip.updateTripID(data['trip_id'], context);
      await context.read<DriverProvider>().updateDriver(data['driver_info']);
      await providerTrip.updatePolylines(
          LatLng(data['location']['lat'] / 1, data['location']['lng'] / 1),
          providerListTrip
              .tripByID(data['trip_id'])
              .currentLocation
              .coordinates);
      providerTrip.updateDriverLocation(
          LatLng(data['location']['lat'] / 1, data['location']['lng'] / 1),
          data['location']['heading'] / 1,
          'comming');
      providerListTrip.updateDriverWithTrip(
          data["trip_id"], data['driver_info']);
      Navigator.of(context).pushNamed(Routes.DriverArrive,
          arguments: {'name': 'Driver is Arriving..', 'check': true});
    });
  }

  void handleTripUpdate(BuildContext context) {
    _socket.on('trip-update', (data) async {
      print("cout<< cho vy : ${data['status']}");
      print("cout<< cho vy : ${data}");
      if (data['status'] == "Driving") {
        context.read<TripsViewModel>().updatePolylines1(data["directions"]);
        Navigator.of(context).pushNamed(Routes.DriverArrive,
            arguments: {'name': 'Đang đi tới đích', 'check': false});
      } else if (data['status'] == "Done") {
        context.read<TripsViewModel>().updateCheckActive(false);
        DialogMessage.show(context);
      }
    });
  }

  void cancelTrip(int trip_id) {
    _socket.emit("user-cancel-trip", {trip_id: trip_id});
  }

  void receiptMessage(BuildContext context) {
    _socket.on("message-to-user", (data) {
      print('cout<<<<<11$data');
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('HH:mm').format(now);
      context.read<TripsViewModel>().pushMessage(data, '0', formattedTime);
    });
  }

  void sendMessage(String text, BuildContext context) {
    _socket.emit("user-message", {
      'message': text,
      'user_id': context.read<DriverProvider>().driver.id,
      'trip_id': context.read<TripsViewModel>().tripId
    });
  }
  // void getLocationDriver(BuildContext context) {
  //   _socket.on('get-location-driver', (data) {
  //     // String? currentRoute = ModalRoute.of(context)?.settings.name;
  //     print('cout<< ' +
  //         context.read<DirectionsViewModel>().driverLocation.status);
  //     if (context.read<DirectionsViewModel>().driverLocation.status ==
  //         'comming') {
  //       print("cout<< socket tao nè");
  //       context.read<DirectionsViewModel>().updateDriverLocation(
  //           LatLng(data['lat'] / 1, data['lng'] / 1),
  //           data['heading'] / 1 ?? 0,
  //           'comming');
  //       context.read<DirectionsViewModel>().updatePolylines(
  //           LatLng(data['lat'] / 1, data['lng'] / 1),
  //           context.read<DirectionsViewModel>().currentLocation.coordinates);
  //     }
  //   });
  // }
}

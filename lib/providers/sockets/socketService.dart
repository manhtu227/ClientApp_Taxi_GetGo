import 'dart:convert';

import 'package:clientapp_taxi_getgo/configs/api_config.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/dialogSuccess.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
        io.OptionBuilder().setTransports(['websocket'])
            // .disableAutoConnect()
            .setQuery({'username': 'loc'}).build());
    _socket.onConnect(
      (data) {
        _socket.emit('user-login', {"user_id": 5});
        userFoundDriver(context);
        handleTripUpdate(context);
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

  void userFoundDriver(BuildContext context) {
    _socket.on('found-driver', (data) async {
      context.read<TripsViewModel>().updateDriverLocation(
          LatLng(data['lat'] / 1, data['lng'] / 1),
          data['heading'] / 1,
          'comming');
      context.read<TripsViewModel>().updateTripID(data['trip_id']);
      print("cout<< cho chet :${data["driver_info"]}");
      print("cout<< cho chet :$data");
      await context.read<TripsViewModel>().updatePolylines(
          LatLng(data['lat'] / 1, data['lng'] / 1),
          context.read<TripsViewModel>().currentLocation.coordinates);
      await context.read<DriverProvider>().updateDriver(data["driver_info"]);
      Navigator.of(context).pushNamed(Routes.DriverArrive,
          arguments: {'name': 'Driver is Arriving..', 'check': true});
      // Navigator.of(context).pushNamed(Routes.DriverArrive);
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
        DialogMessage.show(context);
      }
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

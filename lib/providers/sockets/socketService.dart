import 'dart:convert';

import 'package:clientapp_taxi_getgo/configs/api_config.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
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
  void connectserver() {
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
    _socket.emit('user-find-trip', data["trip_info"]);
  }

  void userFoundDriver(BuildContext context) {
    _socket.on('found-driver', (data) {
      Navigator.of(context).pushNamed(Routes.DriverArrive);
      
    });
  }

  void getLocationDriver(BuildContext context) {
    print('12451241');
    print('12345678');
    print('12345678');
    print('12345678');
    _socket.on('get-location-driver', (data) {
      // print(data);
      // print(data['heading'] is double);
      // print(data['heading'] is int);
      // print(data['heading'] is num);
      final jsonData = jsonDecode(data);
      context.read<DirectionsViewModel>().updateDriverLocation(
          LatLng(data['lat'], data['lng']),
          data['heading']??0);
    });
  }
}

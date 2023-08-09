import 'package:clientapp_taxi_getgo/configs/route_path_api.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/method_payment_view_model.dart';
import 'package:clientapp_taxi_getgo/services/DioInterceptorManager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ApiDriver {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;
  static Future<Response> getAllDriver(LatLng position) async {
    Response response = await _dio.post(RoutePathApi.getAllDriver,
        data: {'lat': position.latitude, 'lng': position.longitude});
    print('1111111111111111all');
    print(response);
    return response;
  }

  static Future<Response> bookDriver(BuildContext context) async {
    final location = context.read<DirectionsViewModel>();
    print('heehehee');
    Map<String, dynamic> data = {
      "start": {
        "lat": location.currentLocation.coordinates.latitude,
        "lng": location.currentLocation.coordinates.longitude,
        "place": location.currentLocation.summary
      },
      "end": {
        "lat": location.desLocation.coordinates.latitude,
        "lng": location.desLocation.coordinates.longitude,
        "place": location.desLocation.summary
      },
      "is_scheduled": false,
      "price": context.read<CarTypeProvider>().price,
      "is_paid": false,
      "paymentMethod":
          context.read<MethodPaymentViewModel>().selectedMethodType
    };
    Response response = await _dio.post(
      RoutePathApi.bookDriver,
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwicGhvbmUiOiIrODQ1NTU1NTU1NTUiLCJ0eXBlIjoiVXNlciIsImlhdCI6MTY5MTAzMjI1OCwiZXhwIjoxNjkyMTEyMjU4fQ.Q51Tb1OdLLLa2OEBGRs86VSTjUtilL0QGp0Xf3jh4qw",
      }),
    );
    print('1111111111111111ne');
    print(response);
    return response;
  }
}

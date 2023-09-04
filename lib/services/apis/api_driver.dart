import 'package:clientapp_taxi_getgo/configs/route_path_api.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
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
    final location = context.read<TripsViewModel>();
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
        "place": location.desLocation.summary,
      },
      "is_scheduled": location.schedule,
      "schedule_time": location.dateSchedule.toString(),
      "price": context.read<CarTypeProvider>().price,
      "is_paid": false,
      "paymentMethod": context.read<MethodPaymentViewModel>().selectedMethodType
    };
    print('cout<<<<<$data');
    Response response = await _dio.post(
      RoutePathApi.bookDriver,
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwicGhvbmUiOiIrODQ1NTU1NTU1NTUiLCJ0eXBlIjoiVXNlciIsImlhdCI6MTY5MzM3OTY0MywiZXhwIjoxNjk0NDU5NjQzfQ.cIz8vzmHl0KZYWXjW-cdeduW2ucJ8WDwVxgleaKbV44",
      }),
    );
    print('1111111111111111ne');
    print(response);
    return response;
  }

  static Future<Response> ratingTrip(
      BuildContext context, double rating) async {
    final trip = context.read<TripsViewModel>();
    print('heehehee');
    Map<String, dynamic> data = {"trip_id": trip.tripId, "star": rating};
    Response response = await _dio.post(
      RoutePathApi.rateTrip,
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }),
    );
    print('1111111111111111ne');
    print(response);
    return response;
  }
}

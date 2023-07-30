import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/services/DioInterceptorManager.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/directions.dart';

class APIPlace {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;
  static Future<List<LocationModel>> getSuccession1(String input) async {
    String bareURL = 'https://www.mapquestapi.com/search/v3/prediction';
    final body = {
      "key": '0XNzjc1tZ6kNX9TUezAsA0mXw3F39BhW',
      "collection":
          'address,airport,poi,postalCode,neighborhood,city,county,state,country',
      "countryCode": 'VN',
      'q': input
    };
    final response = await _dio.get(bareURL, queryParameters: body);
    List<LocationModel> locations = [];
    if (response.statusCode == 200) {
      List<dynamic> result = response.data['results'];
      print('ssssssssssss');
      print('ssssssssssss');
      print('ssssssssssss');
      for (int i = 0; i < result.length; i++) {
        print('i: $i');
        print(result[i]);
        String name = result[i]['name'];
        String description = result[i]['displayString'];
        String placeID = result[i]['id'];
        LatLng coordinates = LatLng(
            result[i]['place']['geometry']['coordinates'][1],
            result[i]['place']['geometry']['coordinates'][0]);
        print("neeee ba");
        print(coordinates);
        locations.add(LocationModel(
            title: name,
            summary: description,
            placeID: placeID,
            coordinates: coordinates));
      }
    }
    return locations;
  }

  static Future<List<LocationModel>> getSuccession(String input) async {
    String kPlace_API_Key = "AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w";
    String bareURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$bareURL?input=$input&components=country:VN&key=$kPlace_API_Key';
    final response = await _dio.get(request);
    print(response);
    print('responseaa');
    if (response.statusCode == 200) {
      List<dynamic> predictions = response.data['predictions'];
      List<LocationModel> locations = [];
      // Giới hạn chỉ lấy 5 địa điểm
      int limit = 5;
      for (int i = 0; i < predictions.length && i < limit; i++) {
        String name = predictions[i]['structured_formatting']['main_text'];
        String description = predictions[i]['description'];
        String placeID = predictions[i]['place_id'];
        locations.add(
            LocationModel(title: name, summary: description, placeID: placeID));
      }
      return locations;
    } else {
      throw Exception('fail to load data');
    }
  }

  static Future<LatLng> getLatLng(String placeID) async {
    String kPlace_API_Key = "AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w";
    String bareURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$bareURL?key=$kPlace_API_Key&place_id=$placeID';
    final response = await _dio.get(request);
    LatLng location = const LatLng(0, 0);

    if (response.statusCode == 200) {
      double lat = response.data['result']['geometry']['location']['lat'];
      double lng = response.data['result']['geometry']['location']['lng'];
      location = LatLng(lat, lng);
    }
    return location;
  }

  // static Future<Directions> getDirections({
  //   required LatLng origin,
  //   required LatLng destination,
  // }) async {
  //   const String _baseUrl =
  //       'https://maps.googleapis.com/maps/api/directions/json?';
  //   final response = await _dio.get(
  //     _baseUrl,
  //     queryParameters: {
  //       'origin': '${origin.latitude},${origin.longitude}',
  //       'destination': '${destination.latitude},${destination.longitude}',
  //       'key': 'AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w',
  //     },
  //   );

  //   // Check if response is successful
  //   if (response.statusCode == 200) {
  //     print('data neffffffffffffffffff');
  //     print(response.data);

  //     return Directions.fromMap(response.data);
  //   }
  //   throw Exception('Request failed with status: ${response.statusCode}');
  // }
  // static Future<Directions> getDirections(
  //     {required LatLng origin, required LatLng destination}) async {
  //   final url = 'https://www.mapquestapi.com/directions/v2/route';
  //   String kPlace_API_Key = "0XNzjc1tZ6kNX9TUezAsA0mXw3F39BhW";
  //   print(origin);
  //   print(destination);
  //   final body = {
  //     "key": '0XNzjc1tZ6kNX9TUezAsA0mXw3F39BhW',
  //     "from": '${origin.latitude},${origin.longitude}',
  //     "to": '${destination.latitude},${destination.longitude}',
  //   };
  //   final response = await _dio.get(url, queryParameters: body);
  //   print('helloq242');
  //   print('helloq242');
  //   print('helloq242');
  //   print('helloq242');
  //   print('helloq242');
  //   print('helloq242');
  //   print(response);
  //   if (response.statusCode == 200) {
  //     // Successful response
  //     // TODO: Handle and display the response data as per your requirement
  //     print(response.data);
  //     return Directions.fromMap(response.data);
  //   }
  //   throw Exception('Request failed with status: ${response.statusCode}');
  // }
  static Future<Directions> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    final url = 'https://routes.googleapis.com/directions/v2:computeRoutes';

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w',
      'X-Goog-FieldMask':
          'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
    };

    final body = {
      "origin": {
        "location": {
          "latLng": {"latitude": origin.latitude, "longitude": origin.longitude}
        }
      },
      "destination": {
        "location": {
          "latLng": {
            "latitude": destination.latitude,
            "longitude": destination.longitude
          }
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "departureTime": "2023-10-15T15:01:23.045123456Z",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    final response =
        await _dio.post(url, options: Options(headers: headers), data: body);
    print('helloq242');
    print(response);
    if (response.statusCode == 200) {
      // Successful response
      // TODO: Handle and display the response data as per your requirement
      print(response.data);
      return Directions.fromMap(response.data);
    }
    throw Exception('Request failed with status: ${response.statusCode}');
  }

  static Future<LatLng> getCurrentLocation() async {
    try {
      await Permission.location.request();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng location = LatLng(position.latitude, position.longitude);
      return location;
    } catch (e) {
      throw Exception('Request failed with status: $e}');
    }
  }

  static Future<LocationModel> getAddressFromLatLng(LatLng latLng) async {
    LocationModel location =
        LocationModel(title: '', summary: '', placeID: '', coordinates: latLng);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        location.title = placemark.subAdministrativeArea as String;
        location.summary =
            "${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}";
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      return location;
    }
  }
}

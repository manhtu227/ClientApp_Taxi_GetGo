// import 'package:flutter_application_1/models/userModel.dart';
import 'package:clientapp_taxi_getgo/configs/api_config.dart';
import 'package:clientapp_taxi_getgo/configs/route_path_api.dart';
import 'package:clientapp_taxi_getgo/services/DioInterceptorManager.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class ApiAuth {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;
  // static final Response response;
  static Future<Map<String, dynamic>> login(
      String phone, String password) async {
    final token = await FirebaseMessaging.instance.getToken();
    print('cout<<<<<<<<<$token');
    Response response = await _dio.post(RoutePathApi.login,
        data: {'phone': phone, 'password': password, 'token_fcm': token});

    return response.data;
  }

  static Future<Map<String, dynamic>> signup(
      String phone, String password, String name, String email) async {
    Response response = await _dio.post(RoutePathApi.signup, data: {
      'phone': phone,
      'password': password,
      'name': name,
      'email': email
    });
    return response.data;
  }

  static Future<Map<String, dynamic>> checkPhone(String phone) async {
    try {
      print('phone11');
      print(phone.substring(1));
      final response = await _dio.get(RoutePathApi.checkPhone,
          queryParameters: {'phone': phone.substring(1)});
      return response.data;
    } catch (error) {
      throw (error);
      // rethrow;
    }
  }

  static Future<Response> logout() async {
    try {
      // final url = Uri.parse('${ApiConfig.baseUrl}/v1/auth/logout');
      final response = await _dio.get('${ApiConfig.baseUrl}/v1/auth/logout');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // static Future<Map<String, dynamic>> signup(
  //     String phone, String password) async {
  //   try {
  //     final response = await _dio.post(RoutePathApi.signup,
  //         data: {"phone": phone, "password": password});
  //     return response.data;
  //   } catch (error) {
  //     // throw(error);
  //     rethrow;
  //   }
  // }

  static Future<Response> forgotPassword(String data) async {
    try {
      final response = await _dio.post(
          '${ApiConfig.baseUrl}/v1/auth/forgotPass',
          data: {"email": data});
      return response;
    } catch (error) {
      rethrow;
    }
  }
}

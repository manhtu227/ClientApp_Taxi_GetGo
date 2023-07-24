// import 'package:flutter_application_1/models/userModel.dart';
import 'package:clientapp_taxi_getgo/configs/api_config.dart';
import 'package:clientapp_taxi_getgo/configs/route_path_api.dart';
import 'package:clientapp_taxi_getgo/services/DioInterceptorManager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiAuth {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;
  // static final Response response;
  static Future<Map<String, dynamic>> login(
      String phone, String password) async {
    Response response = await _dio
        .post(RoutePathApi.login, data: {'phone': phone, 'password': password});
    return response.data;
  }

  static Future<Map<String, dynamic>> checkPhone(String phone) async {
    try {
      final response = await _dio
          .get(RoutePathApi.checkPhone, queryParameters: {'phone': phone});
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

  static Future<Map<String, dynamic>> signup(
      String phone, String password) async {
    try {
      final response = await _dio.post(RoutePathApi.signup,
          data: {"phone": phone, "password": password});
      return response.data;
    } catch (error) {
      // throw(error);
      rethrow;
    }
  }

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

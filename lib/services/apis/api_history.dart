import 'package:clientapp_taxi_getgo/configs/route_path_api.dart';
import 'package:clientapp_taxi_getgo/services/DioInterceptorManager.dart';
import 'package:dio/dio.dart';

class ApiHistory {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;
  static Future<Map<String, dynamic>> getAllHistory(String id) async {
    try {
      Response response = await _dio.get('${RoutePathApi.getAllHistory}/$id');
      print('cout<< 1111111111111111all');
      print('1111111111111111all ${response.data}');
      return response.data;
    } catch (error) {
      throw (error);
      // rethrow;
    }
  }
}

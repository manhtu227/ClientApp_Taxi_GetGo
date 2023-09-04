import 'package:clientapp_taxi_getgo/configs/route_path_api.dart';
import 'package:clientapp_taxi_getgo/services/DioInterceptorManager.dart';
import 'package:dio/dio.dart';

class ApiHistory {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;
  static Future<Map<String, dynamic>> getAllHistory(int id) async {
    try {
      Response response = await _dio.get('${RoutePathApi.getAllHistory}/$id');
      print('1111111111111111all');
      return response.data;
    } catch (error) {
      throw (error);
      // rethrow;
    }
  }
}

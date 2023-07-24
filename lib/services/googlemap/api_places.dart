import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/services/DioInterceptorManager.dart';
import 'package:dio/dio.dart';

class APIPlace {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;
  static Future<List<Location>> getSuccession(String input) async {
    print('heellooo');
    String kPlace_API_Key = "AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w";
    String bareURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$bareURL?input=$input&components=country:VN&key=$kPlace_API_Key';
    final response = await _dio.get(request);
    print('heellooo1');
    if (response.statusCode == 200) {
      print('heellooo2');
      // Lấy danh sách các địa điểm phù hợp từ kết quả trả về
      List<dynamic> predictions = response.data['predictions'];
      // Tạo danh sách locations để chứa các đối tượng Location
      List<Location> locations = [];
      // Giới hạn chỉ lấy 5 địa điểm
      int limit = 5;
      for (int i = 0; i < predictions.length && i < limit; i++) {
        String name = predictions[i]['structured_formatting']['main_text'];
        String description = predictions[i]['description'];
        locations.add(Location(name, description));
      }
      print(locations);
      return locations;
    } else {
      throw Exception('fail to load data');
    }
  }
}

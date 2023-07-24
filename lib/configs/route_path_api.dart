import 'api_config.dart';

class RoutePathApi {
  ///login
  static const String login = '${ApiConfig.baseUrl}/v1/users/login';
  static const String signup = '${ApiConfig.baseUrl}/v1/users/signup';
  static const String checkPhone = '${ApiConfig.baseUrl}/v1/phone';
}

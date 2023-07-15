import 'package:clientapp_taxi_getgo/screens/auth/login.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String signup = '/signup';
  static const String forgot = '/forgot';
  static const String login = '/login';
  static const String setting = '/setting';
  static const String report = '/report';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return null;
    }
  }
}

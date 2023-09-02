import 'package:clientapp_taxi_getgo/screens/auth/login.dart';
import 'package:clientapp_taxi_getgo/screens/auth/updateAccount.dart';
import 'package:clientapp_taxi_getgo/screens/auth/verify.dart';
import 'package:clientapp_taxi_getgo/screens/distance/Distance.dart';
import 'package:clientapp_taxi_getgo/screens/home/home.dart';
import 'package:clientapp_taxi_getgo/screens/order/SelectCar.dart';
import 'package:clientapp_taxi_getgo/screens/order/SelectPayment.dart';
import 'package:clientapp_taxi_getgo/screens/ratting/rating.dart';
import 'package:clientapp_taxi_getgo/screens/search/search_des_sreen.dart';
import 'package:clientapp_taxi_getgo/screens/search/search_driver_screen.dart';
import 'package:clientapp_taxi_getgo/screens/strip/StripScreen.dart';
import 'package:clientapp_taxi_getgo/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String search = '/search';
  static const String Detail = '/detailDistance';
  static const String verify = '/verify';
  static const String login = '/login';
  static const String order = '/order';
  static const String DriverArrive = '/DriverArrive';
  static const String SearchDriver = '/SearchDriver';
  static const String rating = '/rating';
  static const String paymentMethod = '/SelectePayment';
  static const String updateAccount = '/updateAccount';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => TabsScreen());
      case search:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case Detail:
        return MaterialPageRoute(builder: (_) => DetailDistance());
      case rating:
        return MaterialPageRoute(builder: (_) => RatingScreen());
      case verify:
        return MaterialPageRoute(
          builder: (_) => VerifyOTP(),
          settings: settings,
        );
      case order:
        return MaterialPageRoute(builder: (_) => SelectCar());
      case DriverArrive:
        return MaterialPageRoute(
            builder: (_) => TripScreen(), settings: settings);
      case SearchDriver:
        return MaterialPageRoute(builder: (_) => SearchDriverScreen());
      case paymentMethod:
        return MaterialPageRoute(builder: (_) => SelectPayment());
      case updateAccount:
        return MaterialPageRoute(builder: (_) => UpdateAccount(), settings: settings);
      default:
        return null;
    }
  }
}

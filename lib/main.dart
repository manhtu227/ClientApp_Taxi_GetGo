import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/screens/auth/login.dart';
import 'package:clientapp_taxi_getgo/screens/home/home.dart';
import 'package:clientapp_taxi_getgo/screens/tabs_screen.dart';
import 'package:clientapp_taxi_getgo/widgets/map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetGo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: const Color(0xFFFA8D1D),
        primaryTextTheme: const TextTheme(
          headline6: TextStyle(color: Colors.black), // Ví dụ cho headline6
          // Các kiểu chữ khác cho primaryTextTheme
        ),
        fontFamily: 'Inter',
      ),
      // home: MapScreen(),
      initialRoute: Routes.verify,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

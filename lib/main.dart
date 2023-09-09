import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/list_trip_model.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/method_payment_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/sockets/socketService.dart';
import 'package:clientapp_taxi_getgo/providers/userViewModel.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/utils/firebase_options.dart';
import 'package:clientapp_taxi_getgo/widgets/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: "taxi_getgo");
  runApp(ScreenUtilInit(
    designSize: const Size(360, 690),
    builder: (context, _) => const MyApp(),
  ));
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // FlutterLocalNotificationsPlugin fltNotification;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late final FirebaseMessaging _messaging;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('cout<<<<<<${getToken()}');
    registerNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TripsViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: CarTypeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MethodPaymentViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: DriverProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SocketService(),
        ),
        ChangeNotifierProvider.value(
          value: UserViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: ListTripViewModel(),
        ),
      ],
      child: MaterialApp(
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
        initialRoute: Routes.login,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    String? token = await _messaging.getToken();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      var initiizationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInit = const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      var initializationSettings = InitializationSettings(
          android: initiizationSettingsAndroid, iOS: iosInit);

      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              // selectNotification(notificationResponse.id.toString());
              break;
            case NotificationResponseType.selectedNotificationAction:
              // if (notificationResponse.actionId == navigationActionId) {
              //   selectNotificationStream.add(notificationResponse.payload);
              // }
              break;
          }
        },
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        var data = message.data;

        // AndroidNotification? android = message.notification?.android;
        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                  iOS: DarwinNotificationDetails(
                    presentAlert: true,
                    presentBadge: true,
                    presentSound: true,
                  ),
                  android: AndroidNotificationDetails('1', 'pushnotification',
                      channelDescription: 'Test',
                      color: Color(0xffff9d89),
                      colorized: true,
                      priority: Priority.max,
                      channelShowBadge: true,
                      importance: Importance.high,
                      playSound: true)));
        }
      });
    }
  }

  Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    // String token = FirebaseMessaging.instance.getToken();
    print(token);
    return token;
  }
}

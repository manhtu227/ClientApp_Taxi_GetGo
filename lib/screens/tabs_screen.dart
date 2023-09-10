import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/sockets/socketService.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/screens/history/MyBooking.dart';
import 'package:clientapp_taxi_getgo/screens/home/home.dart';
import 'package:clientapp_taxi_getgo/screens/profile/profile_screen.dart';
import 'package:clientapp_taxi_getgo/services/notifications.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Home',
    },
    {
      'page': MyBooking(),
      'title': 'My Booking',
    },
    // {
    //   'page': HomeScreen(),
    //   'title': 'Login',
    // },
    {
      'page': ProfileScreen(),
      'title': 'profile',
    },
  ];
  int _selectedPageIndex = 0;
  @override
  void initState() {
    super.initState();
    if (!context.read<SocketService>().socket.connected)
      context.read<SocketService>().connectserver(context);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void onTap() async {
    final providerTrip = context.read<TripsViewModel>();
    if (providerTrip.statusTrip == "Driving") {
      // context.read<TripsViewModel>().updatePolylines1(data["directions"]);
      await providerTrip.updatePolylines(
          providerTrip.driverLocation.coordinates,
          providerTrip.desLocation.coordinates);
      Navigator.of(context).pushNamed(Routes.DriverArrive,
          arguments: {'name': 'Đang đi tới đích', 'check': false});
    } else if (providerTrip.statusTrip == "Confirmed") {
      await providerTrip.updatePolylines(
          providerTrip.driverLocation.coordinates,
          providerTrip.currentLocation.coordinates);
      Navigator.of(context).pushNamed(Routes.DriverArrive,
          arguments: {'name': 'Driver is Arriving..', 'check': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('heee');
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _pages[_selectedPageIndex]['page'] as Widget,
            if (context.watch<TripsViewModel>().checkActive)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context)
                                .primaryColor, // Màu viền dưới màu xanh
                            width: 2.0, // Độ dày của viền
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.4), // Màu của shadow
                            blurRadius: 4.0, // Độ mờ của shadow
                            offset: const Offset(0,
                                -2), // Vị trí của shadow (y < 0 để shadow hiển thị lên trên)
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(width: 40),
                          SvgPicture.asset(
                            'assets/svgs/MarkerDes.svg',
                          ),
                          const SizedBox(width: 20),
                          const Expanded(child: Text("Đang trong chuyến đi")),
                          Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0), // Viền màu xanh
                              color: Colors.white, // Nền màu xanh
                            ),
                            child: Center(
                              child: Text(
                                "Kiểm tra",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),

                          // ButtonSizeL(
                          //   onTap: () {},
                          //   name: "Kiểm tra",
                          //   width: 50,
                          //   height: 30,
                          //   fontSize: 10,
                          // )
                        ],
                      )),
                ),
              ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 55,
          child: BottomNavigationBar(
            onTap: _selectPage,
            // backgroundColor: Theme.of(context).primaryColor,
            // unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).primaryColor,
            currentIndex: _selectedPageIndex,
            // type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.punch_clock),
                label: 'History',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:clientapp_taxi_getgo/providers/sockets/socketService.dart';
import 'package:clientapp_taxi_getgo/screens/history/MyBooking.dart';
import 'package:clientapp_taxi_getgo/screens/home/home.dart';
import 'package:flutter/material.dart';
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
      'title': 'History',
    },
    {
      'page': HomeScreen(),
      'title': 'Login',
    },
    {
      'page': HomeScreen(),
      'title': 'profile',
    },
  ];
  int _selectedPageIndex = 1;
  @override
  void initState() {
    super.initState();
    context.read<SocketService>().connectserver();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('heee');
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedPageIndex]['page'] as Widget,
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

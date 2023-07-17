import 'package:clientapp_taxi_getgo/screens/home/home.dart';
import 'package:flutter/material.dart';

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
      'page': HomeScreen(),
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
  int _selectedPageIndex = 0;
  @override
  void initState() {
    super.initState();
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
                label: 'Setting',
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

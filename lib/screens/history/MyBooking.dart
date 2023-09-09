import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/list_trip_model.dart';
import 'package:clientapp_taxi_getgo/providers/userViewModel.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/screens/history/ListItem.dart';
import 'package:clientapp_taxi_getgo/services/apis/api_history.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:clientapp_taxi_getgo/widgets/TextField.dart';
import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/TypeCar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyBooking extends StatefulWidget {
  MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with TickerProviderStateMixin {
  late final TabController _tabController;
  List<dynamic> _tripsDone = [];
  List<dynamic> _tripsCancel = [];
  List<dynamic> _trips = [];
  void fetchData() async {
    try {
      print('sao rồi');
      String id = context.read<UserViewModel>().idUser;
      print('cout<<<<<<<<<<<<<<<<<<<$id');
      Map<String, dynamic> newData = await ApiHistory.getAllHistory(id);
      // if(newData["trip"])
      List<dynamic> tripsDone = newData["trip"]
          .where((trip) => trip["status"] == "Done")
          .toList() as List<dynamic>;
      List<dynamic> tripsCancel = newData["trip"]
          .where((trip) =>
              trip["status"] == "Cancelled" &&
              trip["status"] != "Done" &&
              trip["status"] != "Pending")
          .toList() as List<dynamic>;
      List<dynamic> trips = newData["trip"]
          .where((trip) =>
              trip["status"] != "Cancelled" && trip["status"] != "Done")
          .toList() as List<dynamic>;
      Iterable<dynamic> tripss = trips.where(
          (trip) => context.read<ListTripViewModel>().checkTrip(trip['id']));

      List<dynamic> tripList = tripss.toList();
      // Map<String, dynamic> newDataDetail = await _apiReport.getDetail(context);
      setState(() {
        print('dsddddd');
        print(tripsDone);
        _tripsDone = tripsDone;
        _tripsCancel = tripsCancel;
        _trips = tripList;
      });
    } catch (e) {
      print('lỗi rồi');
      // Handle error
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_tabController.index);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xfff1f3f5),
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 30,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: SvgPicture.asset(
            'assets/svgs/CarNote.svg',
            // fit: BoxFit.cover,
            // width: 100,
            // height: 100,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            setState(() {
              _tabController.index = index;
            });
          },
          // physics:AlwaysScrollableScrollPhysics,
          indicator: BoxDecoration(
              // color: Colors.red,
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).primaryColor))),
          dividerColor: Colors.red,
          tabs: <Widget>[
            Tab(
              child: Text(
                "Active Now",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _tabController.index == 0
                      ? Theme.of(context).primaryColor
                      : Color(0x4c000000),
                ),
              ),
            ),
            Tab(
                child: Text(
              "Completed",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _tabController.index == 1
                    ? Theme.of(context).primaryColor
                    : Color(0x4c000000),
              ),
            )),
            Tab(
                child: Text(
              "Cancelled",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _tabController.index == 2
                    ? Theme.of(context).primaryColor
                    : Color(0x4c000000),
              ),
            )),
          ],
        ),
      ),
      body: Container(
        color: Color(0xfff1f3f5),
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            SingleChildScrollView(
              child: _trips.isNotEmpty
                  ? ListItem(
                      trips: _trips,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        'assets/images/empty.png',
                        height: 300,
                        width: 266,
                      ),
                    ),
            ),
            SingleChildScrollView(
              child: _tripsDone.isNotEmpty
                  ? ListItem(
                      trips: _tripsDone,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        'assets/images/empty.png',
                        height: 300,
                        width: 266,
                      ),
                    ),
            ),
            SingleChildScrollView(
              child: _tripsCancel.isNotEmpty
                  ? ListItem(
                      trips: _tripsCancel,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        'assets/images/empty.png',
                        height: 300,
                        width: 266,
                      ),
                    ),
            ),
          ],
        ),
      ),
    ));
  }
}

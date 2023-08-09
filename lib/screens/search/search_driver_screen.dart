import 'dart:convert';

import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/sockets/socketService.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/LoadingPainter.dart';
import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../services/apis/api_driver.dart';

class SearchDriverScreen extends StatefulWidget {
  const SearchDriverScreen({super.key});

  @override
  State<SearchDriverScreen> createState() => _SearchDriverScreenState();
}

class _SearchDriverScreenState extends State<SearchDriverScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animationsRadius;
  late List<Animation<double>> _animationsOpacity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    // Tạo danh sách các animation cho độ lớn và độ mờ của các đường tròn
    _animationsRadius = [
      Tween<double>(begin: 50, end: 150).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 70, end: 170).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 90, end: 190).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
    ];

    _animationsOpacity = [
      Tween<double>(begin: 0.8, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 0.6, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 0.4, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookDriverApi();
  }

  void bookDriverApi() async {
    final reponse = await ApiDriver.bookDriver(context);
    if (reponse.statusCode == 200) {
      context.read<SocketService>().userFindTrip(reponse.data);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('cout<<'+context.read<DirectionsViewModel>().currentLocation.coordinates.toString());
    print('cout<<'+context.read<DirectionsViewModel>().currentLocation.title.toString());
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Color(0xfff1f3f5),
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 30,
        title: const Text(
          'Searching for Driver',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Icon color is black
          ),
          onPressed: () {
            Navigator.of(context).pop();
            // Handle back button press here
          },
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 50,
            width: MediaQuery.of(context).size.width,
            child: GoogleMapBuider(
                    currentLocation:
                        context.read<DirectionsViewModel>().currentLocation)
                .build(),
          ),
          Positioned(
            top: 20,
            child: Container(
                width: MediaQuery.of(context).size.width,
                // width: double.infinity,
                // color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/CarNote.svg',
                        // fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextSizeL(name: "Searching Ride..."),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("This may take a few second..."),
                    ])),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Tấm ảnh ở giữa
                      Image.asset(
                        'assets/images/manhtu.png',
                        width: 100,
                        height: 100,
                      ),
                      // Các đường tròn ở ngoài
                      for (int i = 0; i < _animationsRadius.length; i++)
                        CustomPaint(
                          painter: LoadingPainter(_animationsRadius[i].value,
                              _animationsOpacity[i].value),
                          size: Size.square(_animationsRadius[i].value * 4),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            right: 50,
            left: 50,
            child: Container(
              // width: MediaQuery.of(context).size.width - 40,
              // padding: EdgeInsets.symmetric(vertical: 10),
              // margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd, // Kéo từ trái qua phải
                background: Container(
                  // color: Colors.green, // Màu nền khi kéo qua trái
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  // padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Xác nhận'),
                      content: Text('message'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Xác nhận'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Hủy bỏ'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    // Thực hiện hành động khi xác nhận
                  }
                },
                child: ListTile(
                  leading: FloatingActionButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nút FAB được nhấn
                      print('Floating Action Button pressed!');
                    },
                    child: Icon(Icons.close), // Icon hiển thị trên nút FAB
                    backgroundColor:
                        Theme.of(context).primaryColor, // Màu nền của nút FAB
                  ),
                  title: Text('Kéo qua trái để hủy bỏ'),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/method_payment_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:clientapp_taxi_getgo/widgets/List/ListTranport.dart';
import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/TextField.dart';

class DetailDistance extends StatefulWidget {
  const DetailDistance({super.key});

  @override
  State<DetailDistance> createState() => _DetailDistanceState();
}

class _DetailDistanceState extends State<DetailDistance> {
  late LocationModel _currentLocation;
  late LocationModel _desLocation;
  late double _totalDistance;
  late List<PointLatLng> _listPoint;
  late List<LatLng> _listDrive;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLocation = context.read<DirectionsViewModel>().currentLocation;
    _desLocation = context.read<DirectionsViewModel>().desLocation;
    _totalDistance = context.read<DirectionsViewModel>().totalDistance;
    _listPoint = context.read<DirectionsViewModel>().polylinePoints;
    _listDrive = context.read<DriverProvider>().listDriver;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            // height: MediaQuery.of(context).size.height -
            //     MediaQuery.of(context).size.height / 2.6,
            child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: MediaQuery.of(context).size.height / 3.1,
              child: GoogleMapBuider(currentLocation: _currentLocation)
                  .setDesLocation(_desLocation)
                  .setPolyline(_listPoint)
                  .setListDrive(_listDrive)
                  .build(),
            ),
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                onPressed: () {
                  print('hsgg');
                  print(context
                      .read<DirectionsViewModel>()
                      .currentLocation
                      .coordinates);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black, // Icon color is black
                ),
              ),
            ),
            Positioned(
              // top: MediaQuery.of(context).size.height / 2,
              left: 0,
              right: 0,
              bottom: 0,
              // top: MediaQuery.of(context).size.height -
              //     MediaQuery.of(context).size.height / 2.4,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),

                // height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 160),
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                5), // Điều chỉnh giá trị để thay đổi độ cong của Divider
                            color: const Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSizeL(
                            name: "Khoảng cách",
                            size: ScreenUtil().setSp(15),
                          ),
                          Text(
                            '$_totalDistance km',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xa53e4958),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        thickness: 1,
                        height: 8,
                        color: Color(0xFFACAAAA),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListTransport(),
                    Container(
                      // height: 50,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.paymentMethod);
                              },
                              child: IconText(
                                  icon: "iconPayment",
                                  text: context
                                      .watch<MethodPaymentViewModel>()
                                      .selectedMethodType)),
                          const SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              color: Colors.grey, // Màu sắc của đường kẻ dọc
                              thickness:
                                  3, // Độ dày của đường kẻ dọc (tùy chọn)
                            ),
                          ),
                          IconText(icon: "note", text: "Note"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextButton(
                        onPressed: () {
                          print('a');
                          print('ssssssssss');
                          print('lllllllllllllllllllllll');
                          Navigator.of(context).pushNamed(Routes.order);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 378,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: Text(
                              'Continue to order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(13),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

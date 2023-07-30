import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLocation = context.read<DirectionsViewModel>().currentLocation;
    _desLocation = context.read<DirectionsViewModel>().desLocation;
    _totalDistance = context.read<DirectionsViewModel>().totalDistance;
    _listPoint = context.read<DirectionsViewModel>().polylinePoints;
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
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 200,
              child: GoogleMapBuider(currentLocation: _currentLocation)
                  .setDesLocation(_desLocation)
                  .setPolyline(_listPoint)
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
                padding: EdgeInsets.all(16),
                // height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextSizeL(
                          name: "Distance",
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 8,
                      color: Color(0xFFACAAAA),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/CurrentDetail.svg',
                          width: 40,
                          height: 40,
                          // width: 13,
                          // height: 17.64,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _currentLocation.title,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(13),
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff3e4958),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                _currentLocation.summary,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff97adb6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svgs/edit.svg',
                          // width: 13,
                          // height: 17.64,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SvgPicture.asset(
                        'assets/svgs/line.svg',
                        // width: 13,
                        // height: 17.64,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/DesDetail.svg',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _desLocation.title,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(13),
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff3e4958),
                                ),
                              ),
                              SizedBox(height: 6),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  _desLocation.summary,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff97adb6),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svgs/edit.svg',
                          // width: 13,
                          // height: 17.64,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
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

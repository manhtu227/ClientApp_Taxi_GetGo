import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/widgets/List/ListPlace.dart';
import 'package:clientapp_taxi_getgo/widgets/List/ListServiceCar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double coverHeight = 170;
  final double buttonHeight = 51;
  late DirectionsViewModel locationProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = context.read<DirectionsViewModel>();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    locationProvider.updateLocationData();

    // });
  }

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - buttonHeight / 2;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xfff1f3f5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image(image: AssetImage('assets/images/homebanner.png')),
            SizedBox(
              // height: ScreenUtil().setHeight(190),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/homebanner.png',
                    fit: BoxFit.cover,
                    // width: coverHeight,
                    // height: coverHeight,
                  ),
                  Positioned(
                    left: ScreenUtil().setWidth(16),
                    right: ScreenUtil().setWidth(16),
                    top: top,
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<DirectionsViewModel>()
                            .updateCurrentLocation(locationProvider.myLocation);
                        Navigator.of(context).pushNamed(Routes.search);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        // width: screenWidth - 32,
                        width: double.infinity,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(25),
                              top: 2,
                              right: ScreenUtil().setWidth(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bạn muốn tới đâu?',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(13),
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff000000),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svgs/marker.svg',
                                // width: ScreenUtil().setWidth(13),
                                // height: ScreenUtil().setHeight(17.64),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(buttonHeight / 2),
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
              child: ListPlace(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            ListServiceCar(),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
              width: screenWidth - ScreenUtil().setWidth(32),
              height: ScreenUtil().setHeight(260),
              child: Image.asset(
                'assets/images/bannerHome.png',
                // fit: BoxFit.cover,
                // width: coverHeight,
                // height: coverHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

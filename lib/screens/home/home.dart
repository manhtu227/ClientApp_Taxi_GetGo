import 'package:clientapp_taxi_getgo/widgets/ListPlace.dart';
import 'package:clientapp_taxi_getgo/widgets/ListServiceCar.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double coverHeight = 170;
  final double buttonHeight = 51;
  @override
  Widget build(BuildContext context) {
    final top = coverHeight - buttonHeight / 2;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xfff1f3f5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image(image: AssetImage('assets/images/homebanner.png')),
          SizedBox(
            height: 208,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/homebanner.png',
                  // fit: BoxFit.cover,
                  // width: coverHeight,
                  height: coverHeight,
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  top: top,
                  child: TextButton(
                    onPressed: () {
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
                        margin: EdgeInsets.only(left: 25, top: 2, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Where can we take you to?',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/svgs/marker.svg',
                              width: 13,
                              height: 17.64,
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
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListPlace(),
          ),
          SizedBox(
            height: 15,
          ),
          ListServiceCar(),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            width: screenWidth - 32,
            height: 300,
            child: Image.asset(
              'assets/images/bannerHome.png',
              // fit: BoxFit.cover,
              // width: coverHeight,
              // height: coverHeight,
            ),
          ),
        ],
      ),
    );
  }
}

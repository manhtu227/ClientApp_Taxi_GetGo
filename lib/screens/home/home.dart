import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    return SafeArea(
      child: Scaffold(
        body: Container(
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
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: screenWidth - 32,
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
                            // wherecanwetakeyoutoiTX (425:8522)
                            margin:
                                EdgeInsets.only(left: 25, top: 2, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
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
              Container(
                height: 37,
                width: screenWidth - 32,
                margin: EdgeInsets.only(left: 16),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    TextButton(
                      // frame23Aiq (390:5221)
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(18, 9, 28, 9),
                        // margin: EdgeInsets.only(left: 16),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 116,
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/home.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      // frame23Aiq (390:5221)
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(18, 9, 28, 9),
                        margin: EdgeInsets.only(left: 16),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 116,
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/home.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      // frame23Aiq (390:5221)
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(18, 9, 28, 9),
                        margin: EdgeInsets.only(left: 16),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 116,
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/home.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

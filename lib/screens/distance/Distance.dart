import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/TextField.dart';

class DetailDistance extends StatefulWidget {
  const DetailDistance({super.key});

  @override
  State<DetailDistance> createState() => _DetailDistanceState();
}

class _DetailDistanceState extends State<DetailDistance> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                MapScreen(),
                Positioned(
                  // top: MediaQuery.of(context).size.height / 2,
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 2.4,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    // height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 160),
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  5), // Điều chỉnh giá trị để thay đổi độ cong của Divider
                              color: Color(0xFFACAAAA),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextSizeL(
                              name: "Distance",
                            ),
                            const Text(
                              "2km",
                              style: TextStyle(
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
                              // width: 13,
                              // height: 17.64,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Chuk Chuk',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff3e4958),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '277 Nguyễn Văn Cừ, Quận 5 TPHCM',
                                    style: TextStyle(
                                      fontSize: 13,
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
                          padding: const EdgeInsets.only(left: 16),
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
                              // width: 13,
                              // height: 17.64,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Chuk Chuk',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff3e4958),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '277 Nguyễn Văn Cừ, Quận 5 TPHCM',
                                    style: TextStyle(
                                      fontSize: 13,
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () async {},
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
                            child: const Center(
                              child: Text(
                                'Continue to order',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
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

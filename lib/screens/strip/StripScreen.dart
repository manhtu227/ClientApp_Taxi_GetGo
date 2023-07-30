import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/PlaceStrip.dart';
import 'package:clientapp_taxi_getgo/widgets/SummaryDriver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/TextSizeL.dart';
import '../../widgets/map.dart';

class TripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: Stack(clipBehavior: Clip.none, children: [
                  GoogleMapBuider(
                          currentLocation: context
                              .read<DirectionsViewModel>()
                              .currentLocation)
                      .build(),
                  Positioned(
                      // top: MediaQuery.of(context).size.height / 2,
                      left: 0,
                      right: 0,
                      top: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 1.9,
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
                              TextSizeL(
                                name: "Driver is Arriving..",
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
                              SummaryDriver(),
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
                              PlaceStrip(),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      backgroundColor: Color(
                                          0xfffa8d1d), // Màu nền của button

                                      child: Icon(
                                        Icons.close, // Biểu tượng dấu cộng
                                        size: 20,
                                        color:
                                            Colors.white, // Màu của biểu tượng
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      backgroundColor: Color(
                                          0xfffa8d1d), // Màu nền của button

                                      child: Icon(
                                        Icons.message, // Biểu tượng dấu cộng
                                        size: 20,
                                        color:
                                            Colors.white, // Màu của biểu tượng
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))),
                ]))));
  }
}

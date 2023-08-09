import 'package:clientapp_taxi_getgo/configs/configDev.dart';
import 'package:clientapp_taxi_getgo/models/directions.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/PlaceStrip.dart';
import 'package:clientapp_taxi_getgo/widgets/SummaryDriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';

import '../../providers/CarTypeViewModel.dart';
import '../../widgets/TextSizeL.dart';
import '../../widgets/map.dart';

class TripScreen extends StatefulWidget {
  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // onChange();
  }

  // void onChange() async {
  //   await context
  //       .read<DirectionsViewModel>()
  //       .createPolylines(context.read<CarTypeProvider>().updatePriceByType);
  // }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    print('cout<<' + data.toString());
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // height: MediaQuery.of(context).size.height - 200,
          child: Stack(clipBehavior: Clip.none, children: [
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 200,
              child: Selector<DirectionsViewModel, List<PointLatLng>>(
                  selector: (context, setting) => setting.polylinePoints,
                  builder: (context, polylinePoints, child) {
                    return GoogleMapBuider(
                            currentLocation: context
                                .read<DirectionsViewModel>()
                                .driverLocation)
                        .updateIconCurrent("assets/svgs/CarMap.svg")
                        .setDesLocation(data['check'] == true
                            ? context
                                .read<DirectionsViewModel>()
                                .currentLocation
                            : context.read<DirectionsViewModel>().desLocation)
                        .setPolyline(polylinePoints)
                        .build();
                  }),
            ),
            Positioned(
              // top: MediaQuery.of(context).size.height / 2,
              left: 0,
              right: 0,
              bottom: 0,
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
                      name: data['name'] as String,
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
                    // PlaceStrip(),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Theme.of(context).primaryColor),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Theme.of(context).primaryColor),
                          child: Icon(
                            Icons.message,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

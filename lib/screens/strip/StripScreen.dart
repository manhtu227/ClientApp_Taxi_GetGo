import 'package:clientapp_taxi_getgo/configs/configDev.dart';
import 'package:clientapp_taxi_getgo/models/directions.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/PlaceStrip.dart';
import 'package:clientapp_taxi_getgo/widgets/SummaryDriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../providers/CarTypeViewModel.dart';
import '../../widgets/TextSizeL.dart';
import '../../widgets/map.dart';

class TripScreen extends StatefulWidget {
  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  late RenderBox renderbox;
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
    Map<String, Object> data = {'name': 'Trip to Destination', 'check': false};
//   Map<String, Object> data =
    // ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    print('cout<<' + data.toString());
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // height: MediaQuery.of(context).size.height - 200,
          child: SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: .5,
            minHeight: 180,
            maxHeight: 400,
            body:
                // Container(
                //   // color: Colors.red,
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width,
                // ),
                Selector<DirectionsViewModel, List<PointLatLng>>(
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
            panelBuilder: (controller) => Container(
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
                        color: Color(0xFFD5DDE0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextSizeL(
                    name: data['name'] as String,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 8,
                    color: Color(0xFFACAAAA),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SummaryDriver(),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 8,
                    color: Color(0xFFACAAAA),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PlaceStrip(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
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
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                // title: Text('Custom Dialog'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      37.0), // Điều chỉnh bán kính của góc
                                ),
                                content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                          'assets/images/ArrivedSucces.png'),
                                      const SizedBox(
                                        height: 26,
                                      ),
                                      const Text(
                                        'Bạn đã đến đích',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff1e1e1e),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text(
                                        'Hẹn gặp lại các bạn ở chuyến tiếp theo :)',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff151b27),
                                        ),
                                      ),
                                      const SizedBox(height: 60),
                                      ButtonSizeL(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          name: 'OK')
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
        ),
      ),
    );
  }
}

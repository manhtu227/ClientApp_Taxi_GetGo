import 'package:clientapp_taxi_getgo/configs/configDev.dart';
import 'package:clientapp_taxi_getgo/models/directions.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
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
  late DriverProvider providerDriver;
  late TripsViewModel providerTrip;

  @override
  void initState() {
    // TODO: implement initState
    providerDriver = context.read<DriverProvider>();
    providerTrip = context.read<TripsViewModel>();

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
    // Map<String, Object> data = {'name': 'Trip to Destination', 'check': false};
    Map<String, Object> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    print('cout<<' + data.toString());
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // height: MediaQuery.of(context).size.height - 200,
          child: SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: .5,
            minHeight: data['check'] == false ? 180 : 260,
            maxHeight: data['check'] == false ? 360 : 260,
            body:
                // Container(
                //   // color: Colors.red,
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width,
                // ),
                Selector<TripsViewModel, List<PointLatLng>>(
                    selector: (context, setting) => setting.polylinePoints,
                    builder: (context, polylinePoints, child) {
                      return Stack(
                          // height: 300,
                          children: [
                            SizedBox(
                              // color: Colors.red,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                                child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black, // Icon color is black
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Handle back button press here
                              },
                            )),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              bottom: data['check'] == false ? 180 : 260,
                              child: GoogleMapBuider(
                                      currentLocation: context
                                          .read<TripsViewModel>()
                                          .driverLocation)
                                  .updateIconCurrent("assets/images/CarMap.png")
                                  .setDesLocation(data['check'] == true
                                      ? context
                                          .read<TripsViewModel>()
                                          .currentLocation
                                      : context
                                          .read<TripsViewModel>()
                                          .desLocation)
                                  .setPolyline(polylinePoints)
                                  .build(),
                            ),
                          ]);
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
                  SummaryDriver(
                      nameCar: providerDriver.driver.nameCar!,
                      license_plate: providerDriver.driver.license_plate!,
                      avatar: providerDriver.driver.avatar,
                      rating: providerDriver.driver.rating.toString(),
                      name: providerDriver.driver.name),
                  const SizedBox(
                    height: 16,
                  ),
                  data['check'] == false
                      ? Column(
                          children: [
                            const Divider(
                              thickness: 1,
                              height: 8,
                              color: Color(0xFFACAAAA),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            PlaceStrip(
                                start: providerTrip.currentLocation.summary,
                                end: providerTrip.desLocation.summary)
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  data['check'] == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Theme.of(context).primaryColor),
                              child: const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
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
                        )
                      : SizedBox(),
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

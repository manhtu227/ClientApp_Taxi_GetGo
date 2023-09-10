import 'package:clientapp_taxi_getgo/configs/configDev.dart';
import 'package:clientapp_taxi_getgo/models/directions.dart';
import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/services/apis/api_driver.dart';
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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatefulWidget {
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late RenderBox renderbox;
  double rate = 5;
  late DriverProvider providerDriver;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    providerDriver = context.read<DriverProvider>();
    // onChange();
  }

  // void onChange() async {
  //   await context
  //       .read<DirectionsViewModel>()
  //       .createPolylines(context.read<CarTypeProvider>().updatePriceByType);
  // }
  @override
  Widget build(BuildContext context) {
    Map<String, Object> data = {'name': 'Rate Driver', 'check': false};
//   Map<String, Object> data =
    // ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    print('cout<<' + data.toString());
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // height: MediaQuery.of(context).size.height - 200,
          child: SlidingUpPanel(
            // parallaxEnabled: true,
            // parallaxOffset: .5,
            minHeight: 450,
            maxHeight: 450,
            body:
                // Container(
                //   // color: Colors.red,
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width,
                // ),
                GoogleMapBuider(
                        currentLocation:
                            context.read<TripsViewModel>().myLocation)
                    .build(),
            panelBuilder: (controller) => Container(
              padding: EdgeInsets.all(16),
              // height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    color: Color(0xFFD5DDE0),
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
                  // SummaryDriver(this.rate=providerDriver.driver.rating.toString()),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 8,
                    color: Color(0xFFD5DDE0),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'How is your driver?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1e1e1e),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Please rate for driver',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff151b27),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: MediaQuery.of(context).size.width / 7,
                    itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        rate = rating;
                      });
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 8,
                    color: Color(0xFFD5DDE0),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ButtonSizeL(
                      onTap: () {
                        print('cout<<   sssss');
                        ApiDriver.ratingTrip(context, rate);
                        Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
                      },
                      name: "Submit"),
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

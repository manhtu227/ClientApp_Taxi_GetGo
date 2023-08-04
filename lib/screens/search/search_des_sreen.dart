import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/directions_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/services/googlemap/api_places.dart';
import 'package:clientapp_taxi_getgo/widgets/List/ListPlace.dart';
import 'package:clientapp_taxi_getgo/widgets/TextField.dart';
import 'package:clientapp_taxi_getgo/widgets/locationListTitle.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/location.dart';
import '../../widgets/TextSizeL.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _currentLocation = TextEditingController();
  FocusNode _currentFocus = FocusNode();
  TextEditingController _desLocation = TextEditingController();
  FocusNode _desFocus = FocusNode();
  List<LocationModel> locations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // APIPlace.getCurrentLocation();
    _currentLocation.text =
        context.read<DirectionsViewModel>().currentLocation.summary;
    _desFocus.requestFocus();
    _currentLocation.addListener(() {
      onChange(_currentLocation.text);
    });
    _desLocation.addListener(() {
      onChange(_desLocation.text);
    });
  }

  void onChange(String text) async {
    if (text.length > 2) {
      print('hihuiiiiiiiiii');
      EasyDebounce.debounce('my-debouncer', Duration(milliseconds: 200),
          () async {
        locations = await APIPlace.getSuccession(text);
        // locations = [
        //   LocationModel(
        //       title: 'Quận 1',
        //       summary: 'Quận 1, Thành phố Hồ Chí Minh, Viet Nam',
        //       placeID: 'hihii',
        //       coordinates: const LatLng(10.7757, 106.7004))
        // ];
      });
    } else
      locations = [];
    setState(() {});
  }

// Hàm xử lý khi click vào LocationListTitle
  void onLocationListTitleTap(LocationModel location) async {
    final provider = context.read<DirectionsViewModel>();
    if (_desFocus.hasFocus) {
      _desLocation.text = location.summary;
      await provider.updateDesLocation(location);

      await provider
          .createPolylines(context.read<CarTypeProvider>().updatePriceByType);
      await context
          .read<DriverProvider>()
          .updatelistDriver(provider.currentLocation.coordinates);
      Navigator.of(context).pushNamed(Routes.Detail);
    }
    if (_currentFocus.hasFocus) {
      _currentLocation.text = location.summary;
      provider.updateCurrentLocation(location);
      _desFocus.requestFocus();
    }
    locations = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<DirectionsViewModel>().currentLocation.coordinates);
    print(context.read<DirectionsViewModel>().currentLocation.title);
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: Color(0xfff1f3f5),
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 30,
            title: const Text(
              'Select destination',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black, // Icon color is black
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle back button press here
              },
            ),
            // actions: [
            //   Center(
            //     child: Text(
            //       'Choose your pick-up',
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold,
            //         color: Color(0xfffa8d1d),
            //       ),
            //     ),
            //   ),
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/MarkerCurrent.svg',
                      // width: 13,
                      // height: 17.64,
                    ),
                    SizedBox(width: 16),
                    TextInput(
                      focus: _currentFocus,
                      controller: _currentLocation,
                      hintText: "Enter pick-up ...",
                      iconHint: "currentlocation",
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: SvgPicture.asset(
                    'assets/svgs/line.svg',
                    // width: 13,
                    // height: 17.64,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 5),
                    SvgPicture.asset(
                      'assets/svgs/MarkerDes.svg',
                      // width: 13,
                      // height: 17.64,
                    ),
                    SizedBox(width: 22),
                    TextInput(
                      focus: _desFocus,
                      controller: _desLocation,
                      hintText: "Enter destination ...",
                      iconHint: "MarkerGrey",
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                locations.isNotEmpty
                    ? LocationListTitle(
                        locations: locations,
                        onClick: onLocationListTitleTap,
                      )
                    : Container(
                        child: Column(
                        children: [
                          // const Divider(
                          //   thickness: 1,
                          //   height: 8,
                          //   color: Color.fromARGB(140, 172, 170, 170),
                          // ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.bookmark,
                                    size: 25,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(width: 16),
                                  TextSizeL(
                                    name: "Save placed",
                                    size: ScreenUtil().setSp(13),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/svgs/next.svg',
                                // width: 13,
                                // height: 17.64,
                              ),
                            ],
                          ),
                          // const SizedBox(height: 10),
                          // const Divider(
                          //   thickness: 1,
                          //   height: 8,
                          //   color: Color.fromARGB(140, 172, 170, 170),
                          // ),
                          const SizedBox(height: 20),
                          ListPlace(color: const Color(0xfff1f3f5)),
                        ],
                      )),

                // const Divider(
                //   thickness: 1,
                //   height: 8,
                //   color: Color.fromARGB(140, 172, 170, 170),
                // ),
                // const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}

import 'dart:async';

import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/services/googlemap/api_places.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/List/ListPlace.dart';
import 'package:clientapp_taxi_getgo/widgets/TextField.dart';
import 'package:clientapp_taxi_getgo/widgets/locationListTitle.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
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
  final TextEditingController _currentLocation = TextEditingController();
  final FocusNode _currentFocus = FocusNode();
  final TextEditingController _desLocation = TextEditingController();
  final FocusNode _desFocus = FocusNode();
  List<LocationModel> locations = [];
  bool checkPickUp = false;
  int pick = 1;
  late TripsViewModel _provider;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = context.read<TripsViewModel>();
    // APIPlace.getCurrentLocation();
    _currentLocation.text =
        context.read<TripsViewModel>().currentLocation.summary;
    _desFocus.requestFocus();
    _currentLocation.addListener(() {
      onChange(_currentLocation.text);
    });
    _desLocation.addListener(() {
      onChange(_desLocation.text);
    });
    _currentFocus.addListener(() {
      setState(() {
        checkPickUp = false;
      });
    });
    _desFocus.addListener(() {
      setState(() {
        checkPickUp = false;
      });
    });
  }

  void onChange(String text) async {
    if (text.length > 2) {
      Timer(Duration(seconds: 1), () async {
        locations = await APIPlace.getSuccession(text);
      });
    } else
      locations = [];
    setState(() {});
  }

// Hàm xử lý khi click vào LocationListTitle
  void onLocationListTitleTap(LocationModel location) async {
    if (_desFocus.hasFocus) {
      _desLocation.text = location.summary;
      checkPickUp = false;
      await _provider.updateDesLocation(location);

      if (_currentLocation.text != '') {
        await _provider
            .createPolylines(context.read<CarTypeProvider>().updatePriceByType);
        await context
            .read<DriverProvider>()
            .updatelistDriver(_provider.currentLocation.coordinates);
        Navigator.of(context).pushNamed(Routes.Detail);
      }
    }
    if (_currentFocus.hasFocus) {
      _currentLocation.text = location.summary;
      _provider.updateCurrentLocation(location);
      _desFocus.requestFocus();
      checkPickUp = false;
    }
    locations = [];
    setState(() {});
  }

  bool check = true;
  void onPickUp(CameraPosition? composition) async {
    final LocationModel address;
    print('cout<<s: ' + composition.toString());
    if (composition != null) {
      address = await APIPlace.getAddressFromLatLng(
          composition.target.latitude, composition.target.longitude);
      if (pick == 1) {
        _currentLocation.text = address.summary;
        _provider.updateCurrentLocation(address);
        _desFocus.requestFocus();
      } else {
        _desLocation.text = address.summary;
        double result = Geolocator.distanceBetween(
          _provider.currentLocation.coordinates.latitude,
          _provider.currentLocation.coordinates.longitude,
          composition.target.latitude,
          composition.target.longitude,
        );
        print('cout<<11 ' + result.toString());
        if (_currentLocation.text != '' && result > 1000 && check) {
          _provider.updateDesLocation(address);
          check = false;
          await _provider.createPolylines(
              context.read<CarTypeProvider>().updatePriceByType);
          await context
              .read<DriverProvider>()
              .updatelistDriver(_provider.currentLocation.coordinates);
          Navigator.of(context).pushNamed(Routes.Detail);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: Color(0xfff1f3f5),
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 30,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Điểm đến',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_currentFocus.hasFocus) {
                        pick = 1;
                        _currentFocus.unfocus();
                      } else {
                        _desFocus.unfocus();
                        pick = 2;
                      }
                      checkPickUp = true;
                    });
                  },
                  child: Text(
                    'Chọn từ bản đồ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
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
          body: Stack(
            children: [
              checkPickUp
                  ? Container(
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMapBuider(
                              currentLocation:
                                  context.read<TripsViewModel>().myLocation)
                          .setPickUp(onPickUp)
                          .build(),
                    )
                  : Container(
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
              checkPickUp
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: Image.asset(
                          'assets/images/pickup.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                    )
                  : SizedBox(),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // Điều chỉnh vị trí của đổ bóng
                                ),
                              ],
                            ),
                            child: Column(
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
                                      width:
                                          screenWidth - 32 - 16 - 13 - 16 - 32,
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
                                      width:
                                          screenWidth - 32 - 16 - 13 - 16 - 32,
                                      focus: _desFocus,
                                      controller: _desLocation,
                                      hintText: "Enter destination ...",
                                      iconHint: "MarkerGrey",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            )),

                        !checkPickUp
                            ? locations.isNotEmpty
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
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.bookmark,
                                                size: 25,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              SizedBox(width: 16),
                                              TextSizeL(
                                                name: "Đã lưu",
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
                                  ))
                            : SizedBox()
                        // const Divider(
                        //   thickness: 1,
                        //   height: 8,
                        //   color: Color.fromARGB(140, 172, 170, 170),
                        // ),
                        // const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   left: 0,
              //   bottom: 0,
              //   child: GoogleMapBuider(
              //           currentLocation:
              //               context.read<DirectionsViewModel>().myLocation)
              //       .build(),
              // ),
            ],
          )),
    );
  }
}

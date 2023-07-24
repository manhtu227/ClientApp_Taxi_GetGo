import 'package:clientapp_taxi_getgo/services/googlemap/api_places.dart';
import 'package:clientapp_taxi_getgo/widgets/ListPlace.dart';
import 'package:clientapp_taxi_getgo/widgets/TextField.dart';
import 'package:clientapp_taxi_getgo/widgets/locationListTitle.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/location.dart';
import '../../widgets/TextSizeL.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _currentLocation = TextEditingController();
  TextEditingController _desLocation = TextEditingController();
  List<Location> locations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLocation.addListener(onChange);
  }

  void onChange() async {
    print('fffffffffff');
    if (_currentLocation.text.length > 2) {
      EasyDebounce.debounce('my-debouncer', Duration(milliseconds: 500),
          () async {
        locations = await APIPlace.getSuccession(_currentLocation.text);
        setState(() {});
      });
    } else
      locations = [];
    setState(() {});
  }

// Hàm xử lý khi click vào LocationListTitle
  void onLocationListTitleTap(Location location) {
    setState(() {
      _currentLocation.text = location.summary;
      locations = [];
    });
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
                      controller: _desLocation,
                      hintText: "Enter destination ...",
                      iconHint: "MarkerGrey",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 1,
                  height: 8,
                  color: Color(0xFFACAAAA),
                ),
                locations.isNotEmpty
                    ? LocationListTitle(
                        locations: locations,
                        onClick: onLocationListTitleTap,
                      )
                    : Container(
                        child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.bookmark,
                                    size: 34,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(width: 16),
                                  TextSizeL(
                                    name: "Save placed",
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
                          const SizedBox(height: 20),
                          const Divider(
                            thickness: 1,
                            height: 8,
                            color: Color(0xFFACAAAA),
                          ),
                          const SizedBox(height: 20),
                          ListPlace(color: const Color(0xfff1f3f5)),
                        ],
                      )),

                // const Divider(
                //   thickness: 1,
                //   height: 8,
                //   color: Color(0xFFACAAAA),
                // ),
                // const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}

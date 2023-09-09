import 'package:clientapp_taxi_getgo/models/location.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/method_payment_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/userViewModel.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/Buider/GoogleMapBuider.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:clientapp_taxi_getgo/widgets/List/ListTranport.dart';
import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widgets/TextField.dart';

class DetailDistance extends StatefulWidget {
  const DetailDistance({super.key});

  @override
  State<DetailDistance> createState() => _DetailDistanceState();
}

class _DetailDistanceState extends State<DetailDistance> {
  late LocationModel _currentLocation;
  late LocationModel _desLocation;
  late double _totalDistance;
  late List<PointLatLng> _listPoint;
  late List<LatLng> _listDrive;
  DateTime now = DateTime.now();
  DateTime dateSchedule = DateTime.now();
  bool checkSchedule = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLocation = context.read<TripsViewModel>().currentLocation;
    _desLocation = context.read<TripsViewModel>().desLocation;
    _totalDistance = context.read<TripsViewModel>().totalDistance;
    _listPoint = context.read<TripsViewModel>().polylinePoints;
    _listDrive = context.read<DriverProvider>().listDriver;
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextSizeL(name: 'Chọn thời gian đón'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
                height: 8,
                color: Color(0xFFACAAAA),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 216,
                // padding: const EdgeInsets.only(top: 6.0),
                // The Bottom margin is provided to align the popup above the system
                // navigation bar.
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                // Provide a background color for the popup.
                // Use a SafeArea widget to avoid system overlaps.
                child: child),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ButtonSizeL(
                onTap: () {
                  bool isWithinOneHour = dateSchedule.isAfter(
                          DateTime.now().subtract(Duration(hours: 1))) &&
                      dateSchedule
                          .isBefore(DateTime.now().add(Duration(hours: 1)));
                  if (!isWithinOneHour) {
                    print('cout<ssssheelllllllllo');
                    checkSchedule = false;
                    now = DateTime.now();

                    context
                        .read<TripsViewModel>()
                        .setShedule(false, DateTime.now());
                  } else {
                    print('cout<ssssheel2');
                    checkSchedule = true;

                    now = dateSchedule;
                    context
                        .read<TripsViewModel>()
                        .setShedule(true, dateSchedule);
                  }
                  setState(() {});
                  Navigator.of(context).pop();
                },
                name: "Xác nhận",
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            // height: MediaQuery.of(context).size.height -
            //     MediaQuery.of(context).size.height / 2.6,
            child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: MediaQuery.of(context).size.height / 2.7,
              child: GoogleMapBuider(currentLocation: _currentLocation)
                  .setDesLocation(_desLocation)
                  .setPolyline(_listPoint)
                  .setListDrive(_listDrive)
                  .build(),
            ),
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                onPressed: () {
                  print('hsgg');
                  print(context
                      .read<TripsViewModel>()
                      .currentLocation
                      .coordinates);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black, // Icon color is black
                ),
              ),
            ),
            Positioned(
              // top: MediaQuery.of(context).size.height / 2,
              left: 0,
              right: 0,
              bottom: 0,
              // top: MediaQuery.of(context).size.height -
              //     MediaQuery.of(context).size.height / 2.4,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),

                // height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 160),
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                5), // Điều chỉnh giá trị để thay đổi độ cong của Divider
                            color: const Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSizeL(
                            name: "Khoảng cách",
                            size: ScreenUtil().setSp(15),
                          ),
                          Text(
                            '$_totalDistance km',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xa53e4958),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        thickness: 1,
                        height: 8,
                        color: Color(0xFFACAAAA),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListTransport(),
                    Container(
                      // height: 50,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.paymentMethod);
                              },
                              child: IconText(
                                  icon: "iconPayment",
                                  text: context
                                      .watch<MethodPaymentViewModel>()
                                      .selectedMethodType)),
                          const SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              color: Colors.grey, // Màu sắc của đường kẻ dọc
                              thickness:
                                  3, // Độ dày của đường kẻ dọc (tùy chọn)
                            ),
                          ),
                          context.read<UserViewModel>().user.type == "User_vip"
                              ? InkWell(
                                  onTap: () {
                                    _showDialog(
                                      CupertinoDatePicker(
                                        initialDateTime: now,
                                        use24hFormat: true,
                                        // minuteInterval: 1,
                                        // This is called when the user changes the dateTime.
                                        onDateTimeChanged:
                                            (DateTime newDateTime) {
                                          setState(
                                              () => dateSchedule = newDateTime);
                                        },
                                      ),
                                    );
                                  },
                                  child: IconText(
                                      icon: "schedule", text: "Hẹn giờ"))
                              : const SizedBox(),
                          context.read<UserViewModel>().user.type == "User_vip"
                              ? const SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    color:
                                        Colors.grey, // Màu sắc của đường kẻ dọc
                                    thickness:
                                        3, // Độ dày của đường kẻ dọc (tùy chọn)
                                  ),
                                )
                              : const SizedBox(),
                          IconText(icon: "note", text: "Ghi chú"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ButtonSizeL(
                          onTap: () {
                            print('a');
                            print('ssssssssss');
                            print('lllllllllllllllllllllll');
                            Navigator.of(context).pushNamed(Routes.order);
                          },
                          name: checkSchedule
                              ? 'Đặt trước - ${DateFormat('dd/MM, HH:mm').format(dateSchedule)}'
                              : 'Tiếp tục thanh toán'),
                    )
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: TextButton(
                    //     onPressed: () {
                    //       print('a');
                    //       print('ssssssssss');
                    //       print('lllllllllllllllllllllll');
                    //       Navigator.of(context).pushNamed(Routes.order);
                    //     },
                    //     style: TextButton.styleFrom(
                    //       padding: EdgeInsets.zero,
                    //     ),
                    //     child: Container(
                    //       width: 378,
                    //       height: 50,
                    //       decoration: BoxDecoration(
                    //         color: Theme.of(context).primaryColor,
                    //         borderRadius: BorderRadius.circular(35),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           'Continue to order',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: ScreenUtil().setSp(13),
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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

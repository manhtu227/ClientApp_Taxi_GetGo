import 'package:clientapp_taxi_getgo/models/tripModel.dart';
import 'package:clientapp_taxi_getgo/models/userModel.dart';
import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/providers/list_trip_model.dart';
import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/detailedTrip/address.dart';
import 'package:clientapp_taxi_getgo/widgets/detailedTrip/customerInfo.dart';
import 'package:clientapp_taxi_getgo/widgets/detailedTrip/infoStats.dart';
import 'package:clientapp_taxi_getgo/widgets/detailedTrip/userLineInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DetailedTripScreen extends StatelessWidget {
  const DetailedTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Object> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final format = DateFormat("HH:mm dd/MM/yyyy");
    final TripModel trip =
        context.read<ListTripViewModel>().tripByID(data['idTrip'] as int);
    UserModel? driver = trip.driver;
    // final DriverProvider driver = context.read<DriverProvider>();

    final themedata = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: themedata.primaryColor,
        title: Text(
          "Chi tiết chuyến đi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Positioned(
                bottom: 5,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child: Text(format.format(trip.dateSchedule)),
                ),
              ),
              driver != null
                  ? Container(
                      margin:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: CustomerInfo(
                        avatar: driver.avatar,
                        name: driver.name,
                        phone: driver.phone,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          const Divider(height: 1, color: Colors.black54),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoStats(
                  title: "Khoảng cách", content: "${trip.info.totalDistance} km"),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: 1,
                decoration: BoxDecoration(color: Colors.black54),
              ),
              InfoStats(
                title: "Giá tiền",
                content: "Giá tiền",
                color: themedata.primaryColor,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: 1,
                decoration: BoxDecoration(color: Colors.black54),
              ),
              InfoStats(title: "Dịch vụ", content: "loai xe"),
            ],
          ),
          const Divider(height: 1, color: Colors.black54),
          const SizedBox(height: 15),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Address(
                address: "dideemr ddense",
                img: "assets/svgs/currentlocation.svg",
                color: themedata.primaryColor,
              )),
          const SizedBox(height: 15),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Address(
                address: "diem di",
                img: "assets/svgs/currentlocation.svg",
              )),
          const SizedBox(height: 15),
          UserLineInfo(
              title: "Phương thức thanh toán", info: "phuong thuc thanh toasn"),
          UserLineInfo(title: "Lưu ý", info: "note note"),
          const SizedBox(height: 30),
          // context.read<DriverViewModel>().status == "Done"
          //     ? InkWell(
          //         onTap: () {
          //           // SocketService.handleTripUpdate(context, 'waiting');

          //           //         print("hhaa");
          //           // // Navigator.of(context).pushReplacementNamed(Routes.home);
          //           Navigator.of(context)
          //               .pushNamedAndRemoveUntil(Routes.home, (route) => false);
          //         },
          //         child: Container(
          //           height: 50,
          //           width: 300,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(15),
          //             color: themedata.primaryColor,
          //           ),
          //           alignment: Alignment.center,
          //           child: const Text(
          //             "Hoàn thành chuyến đi",
          //             style: TextStyle(color: Colors.white, fontSize: 20),
          //           ),
          //         ),
          //       )
          //     : SizedBox(),
        ]),
      ),
    ));
  }
}

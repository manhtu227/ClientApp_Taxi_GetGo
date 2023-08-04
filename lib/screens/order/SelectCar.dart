import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/services/apis/api_driver.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:clientapp_taxi_getgo/widgets/TextField.dart';
import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:clientapp_taxi_getgo/widgets/TypeCar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SelectCar extends StatefulWidget {
  SelectCar({super.key});

  @override
  State<SelectCar> createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  TextEditingController _promo = TextEditingController();
  late List<CarTypeModel> CarType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CarType = context.read<CarTypeProvider>().listCar;
  }

  void onTap() {
    Navigator.of(context).pushNamed(Routes.SearchDriver);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xfff1f3f5),
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 30,
        title: const Text(
          'Select car',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Icon color is black
          ),
          onPressed: () {
            Navigator.of(context).pop();
            // Handle back button press here
          },
        ),
      ),
      body: Container(
          width: double.infinity,
          color: Color(0xfff1f3f5),
          child: Column(children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: const Text(
                "Select the vehicle category you want to ride.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xdb000000),
                ),
              ),
            ),
            Column(
              children: CarType.map((carType) {
                return TypeCar(type: carType);
              }).toList(),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(
                thickness: 1,
                height: 8,
                color: Color(0xFFACAAAA),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSizeL(name: "Promo Code"),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextInput(
                              controller: _promo,
                              iconHint: "none",
                              hintText: "Enter Promo Code",
                              width: 270,
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: FloatingActionButton(
                                onPressed: () {},
                                backgroundColor:
                                    Color(0xfffa8d1d), // Màu nền của button

                                child: Icon(
                                  Icons.add, // Biểu tượng dấu cộng
                                  size: 20,
                                  color: Colors.white, // Màu của biểu tượng
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 66,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconText(
                      icon: "km",
                      text: "4 km",
                    ),
                    IconText(
                      icon: "clock",
                      text: "4 mins",
                    ),
                    IconText(
                      icon: "money",
                      text: "31.000 đ",
                    ),
                  ]),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonSizeL(name: "Continue to order", onTap: onTap)
          ])),
    ));
  }
}

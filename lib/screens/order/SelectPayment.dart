import 'package:clientapp_taxi_getgo/models/method_payment.dart';
import 'package:clientapp_taxi_getgo/providers/method_payment_view_model.dart';
import 'package:clientapp_taxi_getgo/widgets/TypeCar.dart';
import 'package:clientapp_taxi_getgo/widgets/TypeMethodPayment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPayment extends StatefulWidget {
  SelectPayment({super.key});

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  TextEditingController _promo = TextEditingController();
  late List<MethodPaymentModel> methodType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    methodType = context.read<MethodPaymentViewModel>().listMethod;
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
          'Payment method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon:const Icon(
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
                "Select the payment method you want to ride.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xdb000000),
                ),
              ),
            ),
            Column(
              children: methodType.map((methodType) {
                return TypeMethodPayment(type: methodType);
              }).toList(),
            ),
          ])),
    ));
  }
}

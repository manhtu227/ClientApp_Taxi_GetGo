import 'package:clientapp_taxi_getgo/models/method_payment.dart';
import 'package:clientapp_taxi_getgo/providers/method_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum SingingCharacter { lafayette, jefferson }

class TypeMethodPayment extends StatelessWidget {
  MethodPaymentModel type;
  TypeMethodPayment({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth - 32,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            type.icon,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              type.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xff3e4958),
              ),
            ),
          ),

          Radio<String>(
              activeColor: Theme.of(context).primaryColor,
              fillColor:
                  MaterialStatePropertyAll(Theme.of(context).primaryColor),
              value: type.title,
              groupValue:
                  context.watch<MethodPaymentViewModel>().selectedMethodType,
              onChanged: (e) {
                context.read<MethodPaymentViewModel>().selectedMethodType = e!;
              }),
          //  Radio<SingingCharacter>(
          //   value: SingingCharacter.lafayette,
          //   groupValue: _character,
          //   onChanged: (SingingCharacter? value) {
          //     setState(() {
          //       _character = value;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}

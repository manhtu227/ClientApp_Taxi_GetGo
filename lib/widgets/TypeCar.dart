import 'package:clientapp_taxi_getgo/configs/config.dart';
import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum SingingCharacter { lafayette, jefferson }

class TypeCar extends StatelessWidget {
  CarTypeModel type;
  TypeCar({required this.type, super.key});

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
            type.iconAsset,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3e4958),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      '${type.duration} ',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                      height: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: const Color(0xffd9d9d9),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.person,
                      color: Color(0xffd9d9d9),
                      size: 16,
                    ),
                    Text(
                      ' ${type.capacity}',
                      style: const TextStyle( 
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            Config.formatCurrency(type.price),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff3e4958),
            ),
          ),
          Radio<String>(
              activeColor: Theme.of(context).primaryColor,
              fillColor:
                  MaterialStatePropertyAll(Theme.of(context).primaryColor),
              value: type.carType,
              groupValue: context.watch<CarTypeProvider>().selectedCarType,
              onChanged: (e) {
                context.read<CarTypeProvider>().selectedCarType = e!;
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

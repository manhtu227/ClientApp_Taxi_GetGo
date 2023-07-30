import 'package:clientapp_taxi_getgo/models/CarType.dart';
import 'package:clientapp_taxi_getgo/providers/CarTypeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Transport extends StatelessWidget {
  CarTypeModel type;
  Transport({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2.5;
    return Padding(
      padding: EdgeInsets.only(left: width / 9),
      child: InkWell(
        onTap: () {
          context.read<CarTypeProvider>().selectedCarType = type.carType;
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            Container(
              width: width,
              height: width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(
                    color: context.watch<CarTypeProvider>().selectedCarType !=
                            type.carType
                        ? const Color(0xffF2F3F5)
                        : Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10),
                color: context.watch<CarTypeProvider>().selectedCarType !=
                        type.carType
                    ? Color(0xffF2F3F5)
                    : Theme.of(context).primaryColor.withOpacity(0.08),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${type.title} \n',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                            context.watch<CarTypeProvider>().selectedCarType !=
                                    type.carType
                                ? const Color(0xff1A9791)
                                : Theme.of(context).primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: '${type.carType} chỗ',
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xc4000000)),
                    ),
                  ],
                ),
              ),
            ),
            type.carType == 'bike'
                ? Positioned(
                    left: -width / 7,
                    top: width * 0.7 / 2.8,
                    child: Image.asset(
                      type.iconDistanceAsset,
                    ))
                : Positioned(
                    left: -width / 7,
                    top: width * 0.7 / 2.3,
                    child: Image.asset(
                      type.iconDistanceAsset,
                      width: width / 1.5,
                      height: width / 1.5 - 10,
                    )),
            Positioned(
              right: 20,
              bottom: 20,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${type.price.toString()}k\n',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff000000)),
                    ),
                    TextSpan(
                      text: '${type.duration} phút',
                      style: TextStyle(fontSize: 15, color: Color(0xc4000000)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryDriver extends StatelessWidget {
  String nameCar;
  String license_plate;
  String avatar;
  String? rating;
  String name;
  String? status;
  SummaryDriver(
      {super.key,
      required this.nameCar,
      required this.license_plate,
      required this.avatar,
      required this.rating,
      this.status,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          SizedBox(
            width: 62,
            height: 62,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3e4958),
                  ),
                ),
                // SizedBox(height: 6),
                Text(
                  nameCar!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff97adb6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              rating != null
                  ? IconText(icon: 'Star', text: rating.toString())
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          color: status == "Completed"
                              ? Color(0xFF4AAF57)
                              : status == "Cancelled"
                                  ? Color(0xFFF75555)
                                  : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        status!,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                    ),
              Text(
                license_plate,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3e4958),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

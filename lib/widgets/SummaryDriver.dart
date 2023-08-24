import 'package:clientapp_taxi_getgo/providers/driver_view_model.dart';
import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryDriver extends StatefulWidget {
  SummaryDriver({super.key});

  @override
  State<SummaryDriver> createState() => _SummaryDriverState();
}

class _SummaryDriverState extends State<SummaryDriver> {
  late DriverProvider providerDriver;
  @override
  void initState() {
    // TODO: implement initState
    providerDriver = context.read<DriverProvider>();
    super.initState();
  }

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
                providerDriver.driver.avatar,
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
                  providerDriver.driver.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3e4958),
                  ),
                ),
                // SizedBox(height: 6),
                Text(
                  providerDriver.driver.nameCar!,
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
              IconText(
                  icon: 'Star', text: providerDriver.driver.rating.toString()),
              Text(
                providerDriver.driver.license_plate!,
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

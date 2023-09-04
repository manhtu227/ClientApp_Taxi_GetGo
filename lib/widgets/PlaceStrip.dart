import 'package:clientapp_taxi_getgo/providers/trips_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PlaceStrip extends StatelessWidget {
  String start;
  String end;
  PlaceStrip({super.key, required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/svgs/CurrentDetail.svg',
                // width: 13,
                // height: 17.64,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      start,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ],
                ),
              ),
              // SvgPicture.asset(
              //   'assets/svgs/edit.svg',
              //   // width: 13,
              //   // height: 17.64,
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(
              'assets/svgs/line.svg',
              // width: 13,
              // height: 17.64,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/svgs/DesDetail.svg',
                // width: 13,
                // height: 17.64,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      end,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff3e4958),
                      ),
                    ),
                  ],
                ),
              ),
              // SvgPicture.asset(
              //   'assets/svgs/edit.svg',
              //   // width: 13,
              //   // height: 17.64,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

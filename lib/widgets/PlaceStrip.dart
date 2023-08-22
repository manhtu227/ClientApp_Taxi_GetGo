import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class PlaceStrip extends StatelessWidget {
  PlaceStrip({super.key});

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
                  children: const [
                    Text(
                      'Chuk Chuk',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff3e4958),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '277 Nguyễn Văn Cừ, Quận 5 TPHCM',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff97adb6),
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
                  children: const [
                    Text(
                      'Chuk Chuk',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff3e4958),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '277 Nguyễn Văn Cừ, Quận 5 TPHCM',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff97adb6),
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

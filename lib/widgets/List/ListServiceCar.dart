import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ListServiceCar extends StatelessWidget {
  const ListServiceCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCarType(
            icon: 'assets/svgs/taxi.svg',
            label: 'Ô tô',
          ),
          _buildCarType(
            icon: 'assets/svgs/bike.svg',
            label: 'Xe máy',
          ),
          _buildCarType(
            icon: 'assets/svgs/airpotTaxi.svg',
            label: 'Ô tô sân bay',
          ),
          _buildCarType(
            icon: 'assets/svgs/shipper.svg',
            label: 'Giao hàng',
          ),
        ],
      ),
    );
  }

  Widget _buildCarType({required String icon, required String label}) {
    return Column(
      children: [
        Container(
          height: ScreenUtil().setHeight(63),
          width: ScreenUtil().setWidth(68),
          decoration: BoxDecoration(
            color: Color(0xfffffffff),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              icon,
              // width: 20,
              // height: 27.77,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(11),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(9),
            fontWeight: FontWeight.w700,
            color: Color(0xff000000),
          ),
        )
      ],
    );
  }
}

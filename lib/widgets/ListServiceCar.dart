import 'package:flutter/material.dart';
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
            label: 'Taxi',
          ),
          _buildCarType(
            icon: 'assets/svgs/bike.svg',
            label: 'Bike',
          ),
          _buildCarType(
            icon: 'assets/svgs/airpotTaxi.svg',
            label: 'Airport Taxi',
          ),
          _buildCarType(
            icon: 'assets/svgs/shipper.svg',
            label: 'Shipper',
          ),
        ],
      ),
    );
  }

  Widget _buildCarType({required String icon, required String label}) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: Color(0xfffffffff),
            borderRadius: BorderRadius.circular(13),
          ),
          child: SvgPicture.asset(
            icon,
            // width: 58.77,
            // height: 27.77,
          ),
        ),
        SizedBox(
          height: 11,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xff000000),
          ),
        )
      ],
    );
  }
}

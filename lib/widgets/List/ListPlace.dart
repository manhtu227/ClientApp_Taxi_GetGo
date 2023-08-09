import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ListPlace extends StatelessWidget {
  final Color color;
  ListPlace({this.color = const Color(0xffffffff), super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: ScreenUtil().setHeight(37),
      width: screenWidth - ScreenUtil().setWidth(32),
      // margin: EdgeInsets.only(left: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TextButton(
            // frame23Aiq (390:5221)
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              // padding: EdgeInsets.fromLTRB(18, 9, 28, 9),
              // margin: EdgeInsets.only(left: 16),
              height: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 116,
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        SvgPicture.asset(
                          'assets/svgs/home.svg',
                          // width: 24,
                          // height: 24,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Text(
                          'Nhà riêng',
                          style: TextStyle(
                            fontSize: ScreenUtil().setWidth(10),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            // frame23Aiq (390:5221)
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              // padding: EdgeInsets.fromLTRB(18, 9, 28, 9),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
              height: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 116,
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        SvgPicture.asset(
                          'assets/svgs/office.svg',
                          width: ScreenUtil().setWidth(16),
                          height: ScreenUtil().setHeight(16),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Text(
                          'Công ty',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            // frame23Aiq (390:5221)
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              // padding: EdgeInsets.fromLTRB(18, 9, 28, 9),
              margin: EdgeInsets.only(left: 16),
              height: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 116,
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        SvgPicture.asset(
                          'assets/svgs/home.svg',
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

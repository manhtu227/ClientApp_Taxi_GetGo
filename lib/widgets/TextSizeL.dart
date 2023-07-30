import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextSizeL extends StatelessWidget {
  String name;
  double size;
  TextSizeL({required this.name, super.key, this.size = 19});

  @override
  Widget build(BuildContext context) {
    return Text(name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(size),
          fontWeight: FontWeight.w700,
          color: Color(0xff000000),
        ));
  }
}

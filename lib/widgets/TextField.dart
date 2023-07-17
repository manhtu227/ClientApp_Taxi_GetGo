import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextInput extends StatefulWidget {
  String iconHint;
  String hintText;
  TextInput({required this.iconHint, required this.hintText, super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 58,
      width: screenWidth - 32 - 16 - 13 - 16,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Color(0xfff1f3f5),
        // color: Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(13),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0x14000000),
        //     offset: Offset(0, 4),
        //     blurRadius: 2,
        //   ),
        // ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 0.6666666667,
            color: Color(0x7f595555),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/svgs/${widget.iconHint}.svg',
              height: 10,
              width: 10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context)
                    .primaryColor), // Đặt màu xanh cho đường viền khi focus
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

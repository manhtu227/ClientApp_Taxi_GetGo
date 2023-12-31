import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextInput extends StatefulWidget {
  String iconHint;
  String hintText;
  double width;
  TextEditingController controller;
  FocusNode? focus = FocusNode();

  TextInput({
    required this.controller,
    required this.iconHint,
    this.focus, // Xóa từ khóa const ở đây
    this.width = 0,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (widget.width == 0) {
      widget.width = screenWidth - 32 - 16 - 13 - 16;
    }
    return Container(
      height: 58,
      width: widget.width,
      decoration: BoxDecoration(
        color: Color(0xfff1f3f5),
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextFormField(
        focusNode: widget.focus,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0x7f595555),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(13),
            child: widget.iconHint != "none"
                ? SvgPicture.asset(
                    'assets/svgs/${widget.iconHint}.svg',
                    height: 10,
                    width: 10,
                  )
                : Text(''),
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

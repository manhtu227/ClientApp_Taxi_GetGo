import 'package:flutter/material.dart';

class ButtonSizeL extends StatelessWidget {
  final String name;
  final Function onTap;
  double height;
  double? fontSize;
  double width;
  ButtonSizeL(
      {required this.onTap,
      required this.name,
      this.height = 50,
      this.width = 378,
      this.fontSize = 19,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

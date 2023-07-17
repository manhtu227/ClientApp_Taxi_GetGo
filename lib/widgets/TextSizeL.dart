import 'package:flutter/material.dart';

class TextSizeL extends StatelessWidget {
  String name;
  TextSizeL({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(name,
        style:const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: Color(0xff000000),
        ));
  }
}

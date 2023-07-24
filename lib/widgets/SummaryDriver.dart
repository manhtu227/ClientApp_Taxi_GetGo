import 'package:clientapp_taxi_getgo/widgets/IconText.dart';
import 'package:flutter/material.dart';

class SummaryDriver extends StatelessWidget {
  const SummaryDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          SizedBox(
            width: 62,
            height: 62,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                'https://cdn.sforum.vn/sforum/wp-content/uploads/2018/11/2-10.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Nguyễn Đăng Mạnh Tú',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3e4958),
                  ),
                ),
                // SizedBox(height: 6),
                Text(
                  'Mercedez-Benz E- class',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff97adb6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconText(icon: 'Star', text: "4.8"),
              const Text(
                'HSW 4736 XK',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3e4958),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

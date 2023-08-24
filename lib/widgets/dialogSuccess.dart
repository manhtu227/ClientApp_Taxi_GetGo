import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:flutter/material.dart';

class DialogMessage {
  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Custom Dialog'),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(37.0), // Điều chỉnh bán kính của góc
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/ArrivedSucces.png'),
                const SizedBox(
                  height: 26,
                ),
                const Text(
                  'Bạn đã đến đích',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1e1e1e),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Hẹn gặp lại các bạn ở chuyến tiếp theo :)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff151b27),
                  ),
                ),
                const SizedBox(height: 60),
                ButtonSizeL(
                    onTap: () {
                      // Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(Routes.rating);
                    },
                    name: 'OK')
              ],
            ),
          ),
        );
      },
    );
  }
}

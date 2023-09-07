import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/ButtonSizeL.dart';
import 'package:flutter/material.dart';

class DialogSchedule {
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
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/ArrivedSucces.png'),
                const SizedBox(
                  height: 26,
                ),
                const Text(
                  'Yêu cầu đặt trước thành công',
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
                  'Getgo sẽ gửi thông báo đến bạn khi có tài xế nhận chuyến',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff151b27),
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonSizeL(
                      onTap: () {},
                      fontSize: 14,
                      name: 'Xem Chuyến đi',
                      width: 150,
                    ),
                    ButtonSizeL(
                        onTap: () {}, name: 'OK', fontSize: 14, width: 100),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

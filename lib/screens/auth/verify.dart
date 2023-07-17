import 'dart:async';

import 'package:clientapp_taxi_getgo/widgets/TextSizeL.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  int remainingTime = 60;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Image(image: AssetImage('assets/images/banner.jpg')),
                Positioned(
                  top: 1,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back), // Icon quay lại
                    onPressed: () {
                      Navigator.pop(context); // Quay lại trang trước
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSizeL(
                    name: "OTP code verification",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'GetGo has sent you a 6-digit OTP to \nyour phone number ',
                          style: TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              color: Color(0xc4000000)),
                        ),
                        TextSpan(
                          text: '0974220702',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xc4000000)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Resend code",
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "(Remaining ",
                      style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: "${remainingTime}s)",
                      style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

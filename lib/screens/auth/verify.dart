import 'dart:async';

import 'package:clientapp_taxi_getgo/viewmodel/OTPViewModel.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  int remainingTime = 60;
  late Timer timer;
  late VerifyOTPViewModel viewModel; // Khởi tạo ViewModel
  late Map<String, Object> data;
  @override
  void initState() {
    super.initState();

    startCountdown();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lấy giá trị data ở đây sau khi đã hoàn thành initState()
    data = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    viewModel = VerifyOTPViewModel(data['check'] == true);
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] as String,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: data['summary'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xc4000000),
                          ),
                        ),
                        TextSpan(
                          text: data['phone'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xc4000000),
                          ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Pinput(
                  length: 6,
                  // defaultPinTheme: defaultPinTheme,
                  // focusedPinTheme: focusedPinTheme,
                  // submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  onCompleted: (value) {
                    viewModel.onCompleted('84${data['phone']}', value, context);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (data['check'] != true) ...[
              Center(
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
          ],
        ),
      ),
    );
  }
}

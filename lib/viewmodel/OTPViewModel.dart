import 'package:flutter/material.dart';
import 'otp_strategy.dart'; // Đường dẫn tùy chỉnh cho file otp_strategy.dart

class VerifyOTPViewModel extends ChangeNotifier {
  OTPStrategy? otpStrategy;

  VerifyOTPViewModel(bool check) {
    otpStrategy = check ? LoginStrategy() : VerifyStrategy();
  }

  void onCompleted(String phone, String password,BuildContext ctx) {
    otpStrategy?.onCompleted(phone,password,ctx);
  }

  // Các hàm và logic khác trong ViewModel nếu có
}

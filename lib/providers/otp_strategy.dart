import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/services/apis/api_auth.dart';
import 'package:flutter/material.dart';

abstract class OTPStrategy {
  void onCompleted(String phone, String password, BuildContext context);
}

class LoginStrategy implements OTPStrategy {
  @override
  void onCompleted(String phone, String password, BuildContext context) async {
    Map<String, dynamic> response = await ApiAuth.login(phone, password);
    print(response);
    if (response['statusCode'] == 200) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    }
  }
}

class VerifyStrategy implements OTPStrategy {
  @override
  void onCompleted(String phone, String password, BuildContext context) {
    // Xử lý khi nhập mã OTP và data['check'] là false
    print("Verify OTP: $password");
  }
}

class SignupStrategy implements OTPStrategy {
  @override
  void onCompleted(String phone, String password, BuildContext context) {}
}

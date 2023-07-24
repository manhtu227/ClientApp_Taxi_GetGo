import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Đăng ký thông tin địa chỉ context
  locator.registerLazySingleton(() => MyContextInfo());
}

class MyContextInfo {
  BuildContext? myContext;

  void setContext(BuildContext context) {
    myContext = context;
  }

  BuildContext? getContext() {
    return myContext;
  }
}

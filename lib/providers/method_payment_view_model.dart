import 'package:clientapp_taxi_getgo/models/method_payment.dart';
import 'package:flutter/material.dart';

class MethodPaymentViewModel with ChangeNotifier {
  final List<MethodPaymentModel> _listMethod = [
    MethodPaymentModel(icon: "assets/svgs/cash.svg", title: "Cash"),
    MethodPaymentModel(icon: "assets/svgs/momo.svg", title: "Momo"),
  ];
  String _selectedMethodType = "Cash";

  List<MethodPaymentModel> get listMethod => _listMethod;
  String get selectedMethodType => _selectedMethodType;
  set selectedMethodType(String type) {
    _selectedMethodType = type;
    notifyListeners();
  }
}

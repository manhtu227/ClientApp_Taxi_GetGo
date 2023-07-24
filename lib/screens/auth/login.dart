import 'package:clientapp_taxi_getgo/services/apis/api_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../routes/routes.dart';
part 'login.logic.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController =
      TextEditingController(text: "974220702");
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  bool _isKeyboardOpen = false;
  bool _checkValidate = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logic = LoginLogic(phoneNumber: phoneController, context: context);
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: _isKeyboardOpen ? 80 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage('assets/images/banner.jpg')),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Use your phone number\nto ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 1.5,
                                      color: Color(0xc4000000)),
                                ),
                                TextSpan(
                                  text: 'login/ sign up',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xc4000000)),
                                ),
                                TextSpan(
                                  text: ' account',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xc4000000)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xffeeeeee),
                                      blurRadius: 10,
                                      offset: Offset(0, 4))
                                ],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.13))),
                            child: Stack(children: [
                              InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  // phoneController.text =
                                  //     number.phoneNumber as String;
                                },
                                onInputValidated: (bool value) {
                                  if (value == true) {
                                    setState(() {
                                      _checkValidate = value;
                                    });
                                  }
                                },
                                cursorColor: Colors.black,
                                formatInput: false,
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                inputDecoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 15, left: 0),
                                  border: InputBorder.none,
                                  hintText: "Your phone number",
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16),
                                ),

                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                initialValue: PhoneNumber(isoCode: 'VN'),
                                textFieldController: phoneController,
                                // keyboardType: TextInputType.numberWithOptions(
                                //     signed: true, decimal: true),
                                inputBorder: const OutlineInputBorder(),
                              ),
                              Positioned(
                                  left: 90,
                                  top: 8,
                                  bottom: 8,
                                  child: Container(
                                    height: 40,
                                    width: 1,
                                    color: Colors.black.withOpacity(0.13),
                                  ))
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  opacity: _isKeyboardOpen ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: SlideTransition(
                    position: _animation,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextButton(
                        onPressed: logic.loginOrSignup,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 378,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeMetrics() {
    final keyboardOpen = WidgetsBinding.instance?.window.viewInsets.bottom != 0;
    setState(() {
      _isKeyboardOpen = keyboardOpen;
    });
    if (_isKeyboardOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

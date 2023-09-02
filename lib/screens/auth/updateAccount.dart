import 'package:clientapp_taxi_getgo/providers/OTPViewModel.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateAccount extends StatefulWidget {
  const UpdateAccount({super.key});

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount>
    with SingleTickerProviderStateMixin {
  final TextEditingController username = TextEditingController(text: "");
  final TextEditingController email = TextEditingController(text: "");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    Map<String, Object> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xfff1f3f5),
          backgroundColor: Colors.white,
          elevation: 0,
          // leadingWidth: 30,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black, // Icon color is black
            ),
            onPressed: () {
              Navigator.of(context).pop();
              // Handle back button press here
            },
          ),
        ),
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Tạo thông tin tài khoản \n',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0xc4000000)),
                          ),
                          TextSpan(
                            text:
                                'Hoàn thiện các thông tin cá nhân để tạo tài khoản và trải nghiệm dịch vụ của getgo',
                            style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Color(0xc4000000)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Họ và tên ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: username,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              // cursorColor: kPrimaryColor,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintText: "Nhập họ và tên",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(
                                          0.5)), // Màu của border khi không được focus
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .primaryColor), // Màu của border khi được focus
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              // cursorColor: kPrimaryColor,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },

                              onChanged: (value) {},
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5)),
                                ),
                                hintText: "Nhập địa chỉ email",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(
                                          0.5)), // Màu của border khi không được focus
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .primaryColor), // Màu của border khi được focus
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
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
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pushNamed(Routes.verify, arguments: {
                              'title': 'Hello,',
                              'summary':
                                  'Enter the password to sign up to account \nwith the phone number ',
                              'phone': data['phone'],
                              'email': email.text,
                              'name': username.text,
                              'check': false
                            });
                            // VerifyOTPViewModel(false).onCompleted(phone, password, name, email, ctx)
                          }
                        },
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
}

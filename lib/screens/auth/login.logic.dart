part of 'login.dart';

class LoginLogic {
  final TextEditingController phoneNumber;
  BuildContext context;
  LoginLogic({
    required this.phoneNumber,
    required this.context,
  });

  void sendOTP(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print('ssssssssssssssssssw2');
        print(e);
        // throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        String verificationId = "";
        // Lưu lại verificationId và sử dụng trong bước tiếp theo
        String smsCode = "123452"; // Đây là mã OTP do người dùng nhập
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          print('User signed in: ${userCredential.user?.uid}');
        } catch (e) {
          print('Sign in failed: $e');
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void loginOrSignup() async {
    print('heeeeeeeee');
    print(phoneNumber.text);
    final checkReponse = await ApiAuth.checkPhone('+84${phoneNumber.text}');
    print(checkReponse);
    if (checkReponse['statusCode'] == 500) {
      sendOTP('+84${phoneNumber.text}');
      Navigator.of(context).pushNamed(Routes.verify, arguments: {
        'title': 'OTP code verification',
        'summary': 'GetGo has sent you a 6-digit OTP to \nyour phone number ',
        'phone': phoneNumber.text,
        'email': null,
        'name': null,
        'check': false
      });
    } else {
      Navigator.of(context).pushNamed(Routes.verify, arguments: {
        'title': 'Hello,',
        'summary':
            'Enter the password to log in to account \nwith the phone number ',
        'email': null,
        'name': null,
        'phone': phoneNumber.text,
        'check': true
      });
    }
  }
}

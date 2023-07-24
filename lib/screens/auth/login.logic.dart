part of 'login.dart';

class LoginLogic {
  final TextEditingController phoneNumber;
  BuildContext context;
  LoginLogic({
    required this.phoneNumber,
    required this.context,
  });
  void sendOTP(String OTP) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: OTP,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print('ssssssssssssssssssw2');
        print(e.message);
        // throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        print('ssssssssssssssss');
        print(resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void loginOrSignup() async {
    print('heeeeeeeee');
    print(phoneNumber.text);
    final checkReponse = await ApiAuth.checkPhone('84${phoneNumber.text}');
    print(checkReponse['error']);
    if (checkReponse['statusCode'] != 500) {
      Navigator.of(context).pushNamed(Routes.verify, arguments: {
        'title': 'OTP code verification',
        'summary': 'GetGo has sent you a 6-digit OTP to \nyour phone number ',
        'phone': '0${phoneNumber.text}',
        'check': false
      });
    } else {
      Navigator.of(context).pushNamed(Routes.verify, arguments: {
        'title': 'Hello,',
        'summary':
            'Enter the password to log in to account \nwith the phone number ',
        'phone': '0${phoneNumber.text}',
        'check': true
      });
    }
  }
}

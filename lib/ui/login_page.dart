import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translateify/services/auth_service.dart';

import '../utils/reusewidgets.dart';

class MailLoginPage extends StatefulWidget {
  const MailLoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MailLoginPageState();
  }
}

class MailLoginPageState extends State<MailLoginPage> {
  final idcontroller = TextEditingController();
  final countrycontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void initState() {
    countrycontroller.text = '91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.15, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      logoWidget('assets/appIcon.png', 240, 240),
                      const SizedBox(
                        height: 20,
                      ),
                      ReuseTextBox("Email", Icons.account_circle_outlined,
                          false, idcontroller),
                      const SizedBox(
                        height: 30,
                      ),
                      ReuseTextBox(
                          "Password", Icons.lock, true, passwordcontroller),
                      const SizedBox(
                        height: 20,
                      ),
                      CuteButton(context, "Login", () {
                        authService.signInWithEmail(
                            idcontroller.text, passwordcontroller.text);
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                    ]))));

    // return Scaffold(
    //     body: SingleChildScrollView(
    //         child: Padding(
    //             padding: EdgeInsets.fromLTRB(
    //                 20, MediaQuery.of(context).size.height * 0.15, 20, 0),
    //             child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   logoWidget('assets/appIcon.png', 240, 240),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   ReuseTextBox(
    //                       "Phone Number", Icons.phone, false, idcontroller),
    //                   const SizedBox(
    //                     height: 30,
    //                   ),
    //                   Container(
    //                     height: 55,
    //                     decoration: BoxDecoration(
    //                         border: Border.all(width: 1, color: Colors.grey),
    //                         borderRadius: BorderRadius.circular(10)),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const SizedBox(
    //                           width: 10,
    //                         ),
    //                         SizedBox(
    //                           width: 40,
    //                           child: TextField(
    //                             controller: countrycontroller,
    //                             keyboardType: TextInputType.number,
    //                             decoration: const InputDecoration(
    //                               border: InputBorder.none,
    //                             ),
    //                           ),
    //                         ),
    //                         const Text(
    //                           "|",
    //                           style:
    //                               TextStyle(fontSize: 33, color: Colors.grey),
    //                         ),
    //                         const SizedBox(
    //                           width: 10,
    //                         ),
    //                         const Expanded(
    //                             child: TextField(
    //                           keyboardType: TextInputType.phone,
    //                           decoration: InputDecoration(
    //                             border: InputBorder.none,
    //                             hintText: "Phone",
    //                           ),
    //                         ))
    //                       ],
    //                     ),
    //                   ),
    //                 ]))));
  }
}

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PhoneLoginPageState();
  }
}

class PhoneLoginPageState extends State<PhoneLoginPage> {
  String phone = '';
  final countrycontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final otpcontroller = TextEditingController();

  late String verificationCode;

  String getOtp() => otpcontroller.text;

  @override
  void initState() {
    countrycontroller.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.15, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      logoWidget('assets/appIcon.png', 240, 240),
                      const SizedBox(
                        height: 20,
                      ),
                      // ReuseTextBox(
                      //     "Phone Number", Icons.phone, false, phonecontroller),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: countrycontroller,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Text(
                              "|",
                              style:
                                  TextStyle(fontSize: 33, color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextField(
                              controller: phonecontroller,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone",
                              ),
                            )),
                            const Text(
                              "|",
                              style:
                                  TextStyle(fontSize: 33, color: Colors.grey),
                            ),
                            SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                    child: Text('Send OTP'),
                                    onPressed: () {
                                      String phonenumber =
                                          countrycontroller.text +
                                              phonecontroller.text;
                                      authService.newUserPhone(phonenumber);
                                    }))
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      ReuseTextBox(
                          "OTP", Icons.password_rounded, true, otpcontroller),
                      CuteButton(context, "Verify Phone Number", () {
                        authService.signWithOtp(getOtp());
                      }),
                    ]))));
  }

  // final auth = FirebaseAuth.instance;
  // newUserPhone(String phone) async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential);
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }

  //       // Handle other errors
  //     },
  //     codeSent: (String verificationId, int? forceResendingToken) {
  //       verificationCode = verificationId;
  //     },
  //   );
  // }
}

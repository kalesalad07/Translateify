import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:translateify/routing/route_utils.dart';
import 'package:translateify/utils/reusewidgets.dart';

import '../services/auth_service.dart';

class UnsignedPage extends StatelessWidget {
  final idcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  UnsignedPage({Key? key}) : super(key: key);

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
                    CuteButton(context, 'Login with Phone Number', () {
                      GoRouter.of(context).goNamed(APP_PAGE.phonelogin.toName);
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    CuteButton(context, 'Login with Mail', () {
                      GoRouter.of(context).goNamed(APP_PAGE.maillogin.toName);
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an acount?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .goNamed(APP_PAGE.signup.toName);
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90)),
                      child: ElevatedButton(
                        onPressed: () {
                          authService.signInWithGoogle();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;
                              }
                              return Colors.blue;
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageIcon(AssetImage('assets/googleIcon.png')),
                              SizedBox(width: 10),
                              Text("Sign in With Google")
                            ]),
                      ),
                    )
                  ],
                ))));
  }
}

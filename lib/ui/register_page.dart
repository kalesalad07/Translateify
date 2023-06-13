import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translateify/services/auth_service.dart';
import 'package:translateify/utils/reusewidgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  final idcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Account")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReuseTextBox('Phone Number/Email', Icons.account_circle_rounded,
              false, idcontroller),
          const SizedBox(height: 30),
          ReuseTextBox('Password', Icons.lock, true, passwordcontroller),
          const SizedBox(height: 20),
          CuteButton(context, 'Sign Up', () {
            authService.newUserMail(idcontroller.text, passwordcontroller.text);
          })
        ],
      ),
    );
  }
}

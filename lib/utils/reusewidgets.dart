import 'package:flutter/material.dart';

Text TitleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextField ReuseTextBox(String text, IconData icon, bool password,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.lightBlue,
        ),
        labelText: text,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.solid,
            ))),
    obscureText: password,
  );
}

Container CuteButton(BuildContext context, String title, Function pressed) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        pressed();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return Colors.blue;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

Image logoWidget(String imageName, double width, double height) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: width,
    height: height,
  );
}

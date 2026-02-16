import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final VoidCallback onTap;
  const MyButtons(
      {super.key,
      required this.text,
      required this.buttonColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(50)),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color backroundColor;
  final Color borderColor;
  final String text;
  const Button({
    Key? key,
    required this.backroundColor,
    required this.borderColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width * 0.70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backroundColor,
          border: Border.all(color: borderColor, width: 1)),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}

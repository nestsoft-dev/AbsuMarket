// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  void Function()? onPressed;
  final IconData icon;
  MyTextInput({
    Key? key,
    required this.hint,
    required this.textEditingController,
    required this.textInputType,
    required this.isPassword,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: textEditingController,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[350]),
          suffix: IconButton(onPressed: onPressed, icon: Icon(icon))),
    );
  }
}

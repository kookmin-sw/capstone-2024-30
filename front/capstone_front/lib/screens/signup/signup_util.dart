import 'package:flutter/material.dart';

class SignupTextField extends StatefulWidget {
  BuildContext context;
  String label;
  String info;
  bool isObscure;
  Map<String, String> userInfo;
  SignupTextField({
    super.key,
    required this.context,
    required this.label,
    required this.info,
    required this.isObscure,
    required this.userInfo,
  });

  @override
  State<SignupTextField> createState() => _SignupTextFieldState();
}

class _SignupTextFieldState extends State<SignupTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isObscure,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: const TextStyle(
          color: Color(0xFFB4B9C3),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: (text) {
        setState(() {
          widget.userInfo[widget.info] = text;
        });
      },
    );
  }
}

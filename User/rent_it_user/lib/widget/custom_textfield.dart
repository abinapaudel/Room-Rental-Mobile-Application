import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.hint,
      this.leadingIcon,
      this.suffixIcon,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.maxLines = 1})
      : super(key: key);

  final String hint;
  final Widget? leadingIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0x00bcd4e5),
        border: Border.all(width: 1.0, color: const Color(0xff000000)),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Color(0xff565252),
            ),
            icon: leadingIcon,
            suffixIcon: suffixIcon),
      ),
    );
  }
}

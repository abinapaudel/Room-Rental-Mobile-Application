import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.fontSize = 24})
      : super(key: key);

  final Function onPressed;
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          color: const Color(0xff2b2b60),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xffffffff),
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RadioTab extends StatelessWidget {
  const RadioTab({
    Key? key,
    required this.title,
    required this.val,
    required this.groupVal,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String val;
  final String groupVal;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: val,
          groupValue: groupVal,
          onChanged: (val) {
            onChanged(val);
          },
          activeColor: const Color(0xff2B2B60),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}

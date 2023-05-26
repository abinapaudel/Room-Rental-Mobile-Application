import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar customAppbar() {
  return AppBar(
    leading: Builder(builder: (context) {
      return IconButton(
        icon: const Icon(
          Icons.subject,
          size: 30,
          color: Color(0xFF0D2E45),
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      );
    }),
    actions: [
      Builder(builder: (context) {
        return IconButton(
          icon: const Icon(
            Icons.person,
            size: 30,
            color: Color(0xFF0D2E45),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
    ],
  );
}

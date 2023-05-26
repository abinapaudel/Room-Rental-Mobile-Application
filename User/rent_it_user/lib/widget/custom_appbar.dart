import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/routes.dart';

customAppbar(title, isDrawer) {
  return AppBar(
    title: Text(title, style: const TextStyle(color: Colors.black)),
    centerTitle: true,
    leading: Builder(builder: (context) {
      return isDrawer
          ? IconButton(
              icon: const Icon(Icons.subject),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              color: Colors.black,
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
              color: Colors.black,
            );
    }),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        onPressed: () {
          Get.toNamed(GetRoutes.profile);
        },
      ),
    ],
  );
}

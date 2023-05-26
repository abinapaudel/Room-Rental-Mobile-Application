import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
        primarySwatch: Colors.blue,
      ),
      initialRoute: GetRoutes.login,
      getPages: GetRoutes.routes,
    );
  }
}

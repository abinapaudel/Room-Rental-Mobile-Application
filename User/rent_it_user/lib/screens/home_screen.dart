import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/feedback_controller.dart';
import 'package:rent_it_user/controller/land_controller.dart';
import 'package:rent_it_user/controller/land_room_controller.dart';
import 'package:rent_it_user/controller/request_controller.dart';
import 'package:rent_it_user/controller/room_controller.dart';
import 'package:rent_it_user/controller/user_controller.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final lrController = Get.put(LandRoomController());
  final userController = Get.put(UserController());
  final feedbackController = Get.put(FeedbackController());
  final roomController = Get.put(RoomController());
  final landController = Get.put(LandController());
  final requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar('Rent It', true),
        drawer: CustomDrawer(),
        body: GetBuilder<UserController>(builder: (controller) {
          return Container(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 40),
              Text(
                '${controller.user.firstName},',
                style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xff2c2c60),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              const Text(
                'Welcome to Rent It',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff2c2c60),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'What are you looking for?',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff2c2c60),
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CatCard(
                      onPressed: () {
                        Get.toNamed(GetRoutes.roomScreen);
                      },
                      title: "Room"),
                  const SizedBox(
                    width: 10,
                  ),
                  CatCard(
                      onPressed: () {
                        Get.toNamed(GetRoutes.landScreen);
                      },
                      title: "Land"),
                ],
              )
            ]),
          );
        }));
  }
}

class CatCard extends StatelessWidget {
  const CatCard({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 70,
              width: 70,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff2c2c60),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

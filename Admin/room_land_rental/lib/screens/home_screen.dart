import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:room_land_rental/controller/feedback_controller.dart';
import 'package:room_land_rental/controller/land_controller.dart';
import 'package:room_land_rental/controller/request_controller.dart';
import 'package:room_land_rental/controller/room_controller.dart';
import 'package:room_land_rental/controller/room_land_controller.dart';
import 'package:room_land_rental/controller/user_controller.dart';
import 'package:room_land_rental/routes.dart';
import 'package:room_land_rental/utils/shared_prefs.dart';
import 'package:room_land_rental/widget/custom_appbar.dart';
import 'package:room_land_rental/widget/custom_drawer.dart';
import 'package:room_land_rental/widget/custom_search_field.dart';
import 'package:room_land_rental/widget/room_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final roomLandController = Get.put(RoomLandController());
  final userController = Get.put(UserController());
  final roomController = Get.put(RoomController());
  final landController = Get.put(LandController());
  final feedbackController = Get.put(FeedbackController());
  final requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<RoomLandController>(builder: (controller) {
          return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(tabs: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text('Room',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text('Land',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ),
                  ]),
                  const Expanded(
                    child: TabBarView(children: [
                      Rooms(),
                      Land(),
                    ]),
                  ),
                ],
              ));
        }),
      ),
    );
  }
}

class Rooms extends StatelessWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchField(
            onChanged: (val) {
              controller.search(val);
            },
            hint: 'Search',
            icon: Icons.search,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.filteredRooms
                      .map((room) => RoomCard(
                            image: room.images![0].path!,
                            title: room.roomTitle!,
                            rent: room.rent!,
                            desc: room.roomDesc!,
                            onEditPressed: () {
                              controller.roomEditInitiate(room);
                              Get.toNamed(GetRoutes.addRoom, arguments: true);
                            },
                            onDeletePressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Land'),
                                      content: const Text(
                                          'Are you sure you want to delete this land?'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.deleteRoom(room.id);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Confirm'))
                                      ],
                                    );
                                  });
                            },
                            onPressed: () {
                              Get.toNamed(GetRoutes.roomDesc, arguments: room);
                            },
                          ))
                      .toList()),
            ),
          )
        ],
      );
    });
  }
}

class Land extends StatelessWidget {
  const Land({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchField(
            onChanged: (val) {
              controller.search(val);
            },
            hint: 'Search',
            icon: Icons.search,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.filteredLands
                      .map(
                        (land) => RoomCard(
                          image: land.images![0].path!,
                          title: land.landTitle!,
                          rent: land.rent!,
                          desc: land.landDesc!,
                          onEditPressed: () {
                            controller.landEditInitiate(land);
                            Get.toNamed(GetRoutes.addLand, arguments: true);
                          },
                          onDeletePressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete Land'),
                                    content: Text(
                                        'Are you sure you want to delete this land?'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      ElevatedButton(
                                          onPressed: () {
                                            controller.deleteLand(land.id);
                                          },
                                          child: const Text('Confirm'))
                                    ],
                                  );
                                });
                          },
                          onPressed: () {
                            Get.toNamed(GetRoutes.landDesc, arguments: land);
                          },
                        ),
                      )
                      .toList()),
            ),
          )
        ],
      );
    });
  }
}

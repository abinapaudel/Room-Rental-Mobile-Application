import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/controller/user_controller.dart';
import 'package:room_land_rental/routes.dart';
import 'package:room_land_rental/utils/shared_prefs.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(3, 152, 158, 100),
            ),
            accountName: Text(controller.user.firstName!),
            accountEmail: Text(controller.user.email!),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.toNamed(GetRoutes.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Add Room'),
            onTap: () {
              Get.toNamed(GetRoutes.addRoom, arguments: false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Add Land'),
            onTap: () {
              Get.toNamed(GetRoutes.addLand, arguments: false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text('Users'),
            onTap: () {
              Get.toNamed(GetRoutes.users);
            },
          ),
          ListTile(
            leading: const Icon(Icons.feed),
            title: const Text('Feedback'),
            onTap: () {
              Get.toNamed(GetRoutes.feedback);
            },
          ),
          ListTile(
            leading: const Icon(Icons.request_page),
            title: const Text('Visit Requests'),
            onTap: () {
              Get.toNamed(GetRoutes.visitRequest);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Room Bookings'),
            onTap: () {
              Get.toNamed(GetRoutes.roomBooking);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Land Bookings'),
            onTap: () {
              Get.toNamed(GetRoutes.landBooking);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Logout?'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        ElevatedButton(
                          child: const Text('Yes'),
                          onPressed: () async {
                            await SharedPrefs().removeUser();
                            Get.toNamed(GetRoutes.login);
                          },
                        ),
                        ElevatedButton(
                          child: const Text('No',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ]),
      );
    });
  }
}

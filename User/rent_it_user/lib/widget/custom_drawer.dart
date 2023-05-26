import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/user_controller.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/utils/shared_prefs.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xffA5D3F4),
          ),
          accountName: Text(
            '',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          accountEmail: Text(
            'abinapaudel20@gmail.com',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.home);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.bookmark,
            color: Colors.black,
          ),
          title: const Text(
            'Room Booking',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.myRoomBookings);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.bookmark,
            color: Colors.black,
          ),
          title: const Text(
            'Land Booking',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.myLandBookings);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.inbox,
            color: Colors.black,
          ),
          title: const Text(
            'Invitations Made',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.invitations);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.feedback,
            color: Colors.black,
          ),
          title: const Text(
            'Give app Feedback',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.sendFeedback);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.info,
            color: Colors.black,
          ),
          title: const Text(
            'About Us',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.about);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.contact_mail,
            color: Colors.black,
          ),
          title: const Text(
            'Contact Us',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.contact);
          },
        ),
        // ListTile(
        //   leading: const Icon(
        //     Icons.question_answer,
        //     color: Colors.black,
        //   ),
        //   title: const Text(
        //     'Help',
        //     style: TextStyle(color: Colors.black, fontSize: 16),
        //   ),
        //   onTap: () {
        //     Get.toNamed(GetRoutes.help);
        //   },
        // ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed(GetRoutes.profile);
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
  }
}

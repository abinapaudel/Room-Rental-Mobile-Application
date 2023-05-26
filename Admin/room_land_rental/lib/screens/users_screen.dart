import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/controller/user_controller.dart';
import 'package:room_land_rental/model/user.dart';
import 'package:room_land_rental/widget/custom_appbar.dart';
import 'package:room_land_rental/widget/custom_drawer.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppbar(),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: GetBuilder<UserController>(builder: (controller) {
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xff2b2b5f),
                  ),
                  child: Row(children: const [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'S.N',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 13,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 13,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 13,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ]),
                ),
                ...controller.users
                    .map((users) => Slidable(
                          child: UserRowTile(users: users),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (a) {
                                  showDialog(
                                      context: (context),
                                      builder: (context) {
                                        return Dialog(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  users.firstName!,
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  users.lastName!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  users.email!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  users.address!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  users.dob!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  users.username!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  users.phoneNumber!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  users.role!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                backgroundColor: const Color(0xff2b2b5f),
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.info,
                                label: '',
                              ),
                              SlidableAction(
                                onPressed: (a) {
                                  showDialog(
                                      context: (context),
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Delete User?'),
                                          content: const Text(
                                            'Are you sure you want to delete this user?',
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  controller.deleteUser(
                                                      users.id, context);
                                                },
                                                child: const Text('Confirm')),
                                          ],
                                        );
                                      });
                                },
                                backgroundColor: const Color(0xffff0000),
                                foregroundColor: Colors.white,
                                icon: FontAwesomeIcons.trashAlt,
                                label: '',
                              ),
                            ],
                          ),
                        ))
                    .toList()
              ],
            );
          }),
        ));
  }
}

class UserRowTile extends StatelessWidget {
  const UserRowTile({Key? key, required this.users}) : super(key: key);
  final User users;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Text(
            users.id!,
            style: const TextStyle(
              fontFamily: 'Roboto Condensed',
              fontSize: 13,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            users.firstName!,
            style: const TextStyle(
              fontFamily: 'Roboto Condensed',
              fontSize: 13,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            users.email!,
            style: const TextStyle(
              fontFamily: 'Roboto Condensed',
              fontSize: 13,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ]),
    );
  }
}

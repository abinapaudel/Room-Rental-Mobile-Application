import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/controller/land_controller.dart';
import 'package:room_land_rental/model/land_bookings.dart';
import 'package:room_land_rental/widget/custom_appbar.dart';
import 'package:room_land_rental/widget/custom_drawer.dart';

class LandBooking extends StatelessWidget {
  const LandBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<LandController>(builder: (controller) {
          return Column(
            children: controller.bookings
                .map((land) => Slidable(
                      child: PropTile(land: land),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (a) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Remove Booking'),
                                      content: const Text(
                                          'Are you sure you want to remove this bookings?'),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text('Yes'),
                                          onPressed: () {
                                            controller.cancelBooking(
                                                land.id, land.userId, context);
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text('No',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            backgroundColor: const Color(0xFFff0000),
                            foregroundColor: Colors.white,
                            icon: FontAwesomeIcons.trashAlt,
                            label: '',
                          )
                        ],
                      ),
                    ))
                .toList(),
          );
        }),
      )),
    );
  }
}

class PropTile extends StatelessWidget {
  const PropTile({Key? key, required this.land}) : super(key: key);

  final LandBookings land;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0xffffffff),
        border: Border.all(width: 1.0, color: const Color(0xffc9c9c9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 0),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          land.landTitle!,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff000000),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          land.date!,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(height: 10),
        Text(
          land.status!,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff000000),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          land.firstName!,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          land.token!,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
            children: [
              TextSpan(
                text: 'Book with ',
              ),
              TextSpan(
                text: 'Rs. 10',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        )
      ]),
    );
  }
}

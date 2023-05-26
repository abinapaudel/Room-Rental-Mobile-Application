import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/room_controller.dart';
import 'package:rent_it_user/model/room_bookings.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_drawer.dart';

class RoomBooking extends StatelessWidget {
  RoomBooking({Key? key}) : super(key: key);

  final roomController = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar('Room Bookings', true),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GetBuilder<RoomController>(builder: (controller) {
              return Column(
                  children: controller.bookings
                      .map((book) => Slidable(
                            child: InkWell(
                                onTap: () {
                                  Get.toNamed(GetRoutes.roomDesc,
                                      arguments: controller.rooms
                                          .where((element) =>
                                              element.id == book.roomId)
                                          .toList()[0]);
                                },
                                child: BookingCard(book: book)),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (a) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Cancel Booking'),
                                            content: const Text(
                                                'You won\'t be refunded if you cancel the booking. Are you sure you want to delete this booking?'),
                                            actions: [
                                              ElevatedButton(
                                                child: const Text('Yes'),
                                                onPressed: () {
                                                  controller.cancelBooking(
                                                      book.id, context);
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
                                  icon: Icons.delete,
                                  label: 'Cancel',
                                ),
                              ],
                            ),
                          ))
                      .toList());
            }),
          ),
        ));
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({Key? key, required this.book}) : super(key: key);

  final RoomBookings book;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          book.roomTitle!,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff000000),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          book.date!,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        Text(
          book.status!,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff000000),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          book.token!,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        const Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff000000),
            ),
            children: [
              TextSpan(
                text: 'Booked with ',
              ),
              TextSpan(
                text: 'Rs. 10',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.left,
        )
      ]),
    );
  }
}

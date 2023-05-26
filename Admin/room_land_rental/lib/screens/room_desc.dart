import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/model/room.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/widget/custom_button.dart';

class RoomDesc extends StatelessWidget {
  RoomDesc({Key? key}) : super(key: key);

  final Room room = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Room Description',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              }),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 220.0,
                ),
                items: room.images!.map((i) {
                  return Image(
                    image: NetworkImage(baseurl + i.path!),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
              Positioned(
                top: 220,
                child: Container(
                  height: MediaQuery.of(context).size.height - 295,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            room.roomTitle!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '\Rs. ${room.rent}\nper/month',
                            style: const TextStyle(
                              fontSize: 20,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        room.location!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff7b7676),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color(0xff7b7676),
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: const BoxDecoration(
                          color: Color(0xffa5d3f4),
                        ),
                        child: const Text(
                          'Available now',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        room.roomDesc!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: const Color(0xff000000),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        spacing: 2,
                        runSpacing: 5,
                        alignment: WrapAlignment.center,
                        children: [
                          DescCard(
                            icon: FontAwesomeIcons.hospitalAlt,
                            label: 'Rooms: ${room.bedroomNo}',
                          ),
                          DescCard(
                            icon: FontAwesomeIcons.utensils,
                            label: 'Kitchen: ${room.kitchenNo}',
                          ),
                          DescCard(
                            icon: FontAwesomeIcons.hSquare,
                            label: 'Hall: ${room.hallNo}',
                          ),
                          DescCard(
                            icon: FontAwesomeIcons.hackerNewsSquare,
                            label:
                                'Balcony: ${room.isBalcony == "0" ? 'No' : 'Yes'}',
                          ),
                          DescCard(
                            icon: FontAwesomeIcons.parking,
                            label:
                                'Parking: ${room.isParking == "0" ? 'No' : 'Yes'}',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'About Owner',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        room.ownerFirstname! + room.ownerLastname!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        room.phoneNo!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        room.email!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        color: Color(0xff7b7676),
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {},
                              title: 'Request Visit',
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {},
                              title: 'Book Now',
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              )
            ],
          ),
        ));
  }
}

class DescCard extends StatelessWidget {
  const DescCard({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.29,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xff901f92),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FaIcon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xffffffff),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        )
      ]),
    );
  }
}

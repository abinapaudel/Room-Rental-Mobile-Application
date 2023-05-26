import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/land_controller.dart';
import 'package:rent_it_user/model/land.dart';
import 'package:rent_it_user/screens/payment.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/request_modal.dart';

class LandDesc extends StatelessWidget {
  LandDesc({Key? key}) : super(key: key);

  final Land land = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Land Description',
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
                  height: 250.0,
                ),
                items: land.images!.map((i) {
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
                            land.landTitle!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '\Rs. ${land.rent}\nper/month',
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
                        land.location!,
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
                        child: Text(
                          land.booked == 1 ? 'Booked' : 'Available now',
                          style: const TextStyle(
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
                        land.landDesc!,
                        style: const TextStyle(
                          fontSize: 15,
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
                            icon: FontAwesomeIcons.landmark,
                            label: 'Area: ${land.area} sqft',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'About Owner',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        land.ownerFirstname! + land.ownerLastname!,
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
                        land.phoneNo!,
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
                        land.email!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
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
                      Visibility(
                        visible: land.booked != 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  showDialog(
                                      context: (context),
                                      builder: (context) {
                                        return Dialog(
                                          child: RequestModal(
                                            type: 'land',
                                            title: land.landTitle!,
                                          ),
                                        );
                                      });
                                },
                                title: 'Request Visit',
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GetBuilder<LandController>(builder: (controller) {
                              return Expanded(
                                child: CustomButton(
                                  onPressed: () async {
                                    final token = await showDialog(
                                        context: (context),
                                        builder: (context) {
                                          return const KhaltiPayment();
                                        });
                                    if (token == null) {
                                      return;
                                    }
                                    controller.bookLand(
                                        'wksTRCAeLUNKadxGbjN72h',
                                        land.id,
                                        context);
                                  },
                                  title: 'Book Now',
                                  fontSize: 15,
                                ),
                              );
                            }),
                          ],
                        ),
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
      width: MediaQuery.of(context).size.width * 0.4,
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
            fontSize: 15,
            color: Color(0xffffffff),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        )
      ]),
    );
  }
}

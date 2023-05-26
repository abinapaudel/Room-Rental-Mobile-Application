import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/land_controller.dart';
import 'package:rent_it_user/controller/room_controller.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_search_field.dart';
import 'package:rent_it_user/widget/custom_textfield.dart';
import 'package:rent_it_user/widget/desc_card.dart';

class LandScreen extends StatelessWidget {
  const LandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar('Lands', false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<LandController>(builder: (controller) {
            return Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        onChanged: (val) {
                          controller.search(val);
                        },
                        hint: 'Search',
                        icon: Icons.search,
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: (context),
                            builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: SingleChildScrollView(
                                      child: Column(children: [
                                        Text(
                                          'Filter',
                                          style: const TextStyle(
                                            fontSize: 25,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomTextFormField(
                                            hint: 'Address',
                                            controller: controller.address),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomTextFormField(
                                                  hint: 'Min Price',
                                                  controller:
                                                      controller.minPrice),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: CustomTextFormField(
                                                  hint: 'Max Price',
                                                  controller:
                                                      controller.maxPrice),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomButton(
                                            onPressed: () {
                                              controller.filterLand();
                                              Navigator.pop(context);
                                            },
                                            title: 'Search'),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomButton(
                                            onPressed: () {
                                              controller.address.clear();
                                              controller.minPrice.clear();
                                              controller.maxPrice.clear();
                                              controller.filterLand();
                                              Navigator.pop(context);
                                            },
                                            title: 'Reset')
                                      ]),
                                    ),
                                  ),
                                ));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xffffffff),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.filter_alt)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: controller.filteredLands
                        .where((element) => element.booked != 1)
                        .map((land) => InkWell(
                              onTap: () {
                                Get.toNamed(GetRoutes.landDesc,
                                    arguments: land);
                              },
                              child: DescriptionCard(
                                image: land.images![0].path!,
                                title: land.landTitle!,
                                price: land.rent!,
                                description: land.landDesc!,
                                location: land.location!,
                              ),
                            ))
                        .toList(),
                  ),
                ))
              ],
            );
          }),
        ));
  }
}

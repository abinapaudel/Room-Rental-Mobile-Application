import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/controller/room_controller.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/widget/custom_button.dart';
import 'package:room_land_rental/widget/custom_text_form.dart';

class AddRoom extends StatelessWidget {
  AddRoom({Key? key}) : super(key: key);

  final bool isEdit = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          controller.resetRoomDetails();
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                '${isEdit ? 'Edit' : 'Add'} Room',
                style: const TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.resetRoomDetails();
                    Get.back();
                  }),
            ),
            body: GetBuilder<RoomController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: GetBuilder<RoomController>(builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${isEdit ? 'Edit' : 'Add'} your room details',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xff0d2e45),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hint: 'Room Title',
                          controller: controller.roomTitleController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextForm(
                                hint: 'Bedroom No',
                                controller: controller.bedroomNoController,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextForm(
                                hint: 'Kitchen No',
                                controller: controller.kitchenNoController,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextForm(
                                hint: 'Hall No',
                                controller: controller.hallNoController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hint: 'Location',
                          controller: controller.locationController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hint: 'Description',
                          controller: controller.roomDescController,
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hint: 'Rent Price',
                          controller: controller.roomRentController,
                        ),
                        RadioBlock(
                          title: 'Balcony',
                          value1: 0,
                          value2: 1,
                          groupValue: controller.balcony,
                          onChanged: (val) {
                            controller.balcony = val;
                            controller.update();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioBlock(
                          title: 'Parking',
                          value1: 0,
                          value2: 1,
                          groupValue: controller.parking,
                          onChanged: (val) {
                            controller.parking = val;
                            controller.update();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Owner Details',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            color: Color(0xff0d2e45),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextForm(
                                hint: 'First Name',
                                controller: controller.ownerFirstNameController,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextForm(
                                hint: 'Last Name',
                                controller: controller.ownerLastNameController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hint: 'Phone',
                          controller: controller.phoneController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hint: 'Email *',
                          controller: controller.emailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Room Image*',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            color: Color(0xff0d2e45),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            controller.pickImages();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xffdad7d7),
                              border: Border.all(
                                  width: 1.0, color: const Color(0xff000000)),
                            ),
                            child: const Text(
                              'Choose Image',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff0d2e45),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        controller.imagefiles != null
                            ? Wrap(
                                children:
                                    controller.imagefiles!.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.file(File(imageone.path),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              }).toList())
                            : Container(),
                        controller.images.isNotEmpty
                            ? Wrap(
                                children: controller.images.map((imageone) {
                                return Card(
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image(
                                      image: NetworkImage(
                                          baseurl + imageone.path!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList())
                            : Container(),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                            onPressed: () {
                              controller.checkRoomDetails(isEdit);
                            },
                            title: '${isEdit ? 'Edit' : 'Add'} Room'),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
                ),
              );
            })),
      );
    });
  }
}

class RadioBlock extends StatelessWidget {
  const RadioBlock(
      {Key? key,
      required this.title,
      required this.value1,
      required this.value2,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  final String title;
  final int value1;
  final int value2;
  final int groupValue;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: Color(0xff0d2e45),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Row(
              children: [
                Radio(
                  value: value1,
                  groupValue: groupValue,
                  onChanged: (int? value) {
                    onChanged(value!);
                  },
                ),
                const Text(
                  'No',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
            Row(
              children: [
                Radio(
                  value: value2,
                  groupValue: groupValue,
                  onChanged: (int? value) {
                    onChanged(value!);
                  },
                ),
                const Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}

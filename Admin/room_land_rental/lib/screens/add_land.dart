import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/controller/land_controller.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/widget/custom_button.dart';
import 'package:room_land_rental/widget/custom_text_form.dart';

class AddLand extends StatelessWidget {
  AddLand({Key? key}) : super(key: key);
  final bool isEdit = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          controller.resetLandDetails();
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                '${isEdit ? 'Edit' : 'Add'} Land',
                style: const TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.resetLandDetails();
                    Get.back();
                  }),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: GetBuilder<LandController>(builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${isEdit ? 'Edit' : 'Add'} your land details',
                        style: const TextStyle(
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
                      CustomTextForm(
                          hint: 'Land Title',
                          controller: controller.landTitleController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextForm(
                          hint: 'Location',
                          controller: controller.locationController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextForm(
                        hint: 'Description',
                        controller: controller.landDescController,
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextForm(
                          hint: 'Rent Price',
                          controller: controller.landRentController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextForm(
                          hint: 'Land Area',
                          controller: controller.landAreaController),
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
                                controller:
                                    controller.ownerFirstNameController),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomTextForm(
                                hint: 'Last Name',
                                controller: controller.ownerLastNameController),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextForm(
                          hint: 'Phone',
                          controller: controller.phoneController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextForm(
                          hint: 'Email *',
                          controller: controller.emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Land Image*',
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
                              children: controller.imagefiles!.map((imageone) {
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
                                    image:
                                        NetworkImage(baseurl + imageone.path!),
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
                            controller.checkLandDetails(isEdit);
                          },
                          title: '${isEdit ? 'Edit' : 'Add'} Land'),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }),
              ),
            )),
      );
    });
  }
}

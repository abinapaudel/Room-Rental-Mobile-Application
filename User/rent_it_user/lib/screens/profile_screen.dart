import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/user_controller.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/widget/custom_appbar.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_drawer.dart';
import 'package:rent_it_user/widget/custom_textfield.dart';
import 'package:rent_it_user/widget/radio_tab.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar('Profile', true),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: GetBuilder<UserController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    color: Color(0xffa5d3f4),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: controller.user.image == ''
                              ? NetworkImage(
                                  'https://ui-avatars.com/api/?background=random&name=' +
                                      controller.user.firstName!,
                                )
                              : NetworkImage(
                                  baseurl + controller.user.image!,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(
                          label:
                              'Name: ${controller.user.firstName} ${controller.user.lastName}'),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(label: 'Gender: ${controller.user.gender}'),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(label: 'Email: ${controller.user.email}'),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(
                          label: 'Username: ${controller.user.username}'),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(
                          label: 'Phone No: ${controller.user.phoneNumber}'),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(label: 'D.O.B: ${controller.user.dob}'),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonText(label: 'Address: ${controller.user.address}'),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          onPressed: () {
                            showDialog(
                                context: (context),
                                builder: (context) {
                                  return const Dialog(child: EditUser());
                                });
                          },
                          title: 'Edit')
                    ],
                  ),
                )
              ],
            );
          }),
        ));
  }
}

class CommonText extends StatelessWidget {
  const CommonText({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 20,
        color: Color(0xff000000),
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class EditUser extends StatelessWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 1.0),
          colors: [Color(0xff5aa3d6), Color(0x00dcdcdc)],
          stops: [0.0, 1.0],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: GetBuilder<UserController>(builder: (controller) {
        return SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff0d2e45),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const FaIcon(FontAwesomeIcons.xmark))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: controller.firstNameController,
                    hint: 'First Name *',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextFormField(
                    controller: controller.lastNameController,
                    hint: 'Last Name *',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.selectedDate,
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 365 * 21)),
                  lastDate: DateTime.now().subtract(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  controller.selectedDate = pickedDate;
                  controller.update();
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0x00f6f7fb),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff000000)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.selectedDate.toString().split(" ")[0],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff565252),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const FaIcon(FontAwesomeIcons.calendar)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                RadioTab(
                  title: 'Male',
                  groupVal: controller.gender,
                  val: 'male',
                  onChanged: (val) {
                    controller.gender = val;
                    controller.update();
                  },
                ),
                RadioTab(
                  title: 'Female',
                  groupVal: controller.gender,
                  val: 'female',
                  onChanged: (val) {
                    controller.gender = val;
                    controller.update();
                  },
                ),
                RadioTab(
                  title: 'Others',
                  groupVal: controller.gender,
                  val: 'others',
                  onChanged: (val) {
                    controller.gender = val;
                    controller.update();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: controller.phoneNumberController,
              hint: 'Phone Number *',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: controller.addressController,
              hint: 'Address *',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              controller: controller.usernameController,
              hint: 'Username *',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onPressed: () {
                controller.editUser(context);
              },
              title: 'Edit',
            )
          ]),
        );
      }),
    );
  }
}

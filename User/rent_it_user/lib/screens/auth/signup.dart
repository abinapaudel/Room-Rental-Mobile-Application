import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/signup_controller.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_textfield.dart';
import 'package:rent_it_user/widget/radio_tab.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff5aa3d6),
        title: const Text('Signup'),
      ),
      body: GetBuilder<SignupController>(builder: (controller) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, 1.0),
              colors: [Color(0xff5aa3d6), Color(0x00dcdcdc)],
              stops: [0.0, 1.0],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create your account',
                    style: TextStyle(
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
                        firstDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 21)),
                        lastDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        controller.selectedDate = pickedDate;
                        controller.update();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0x00f6f7fb),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff000000)),
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
                  Row(
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
                    controller: controller.emailController,
                    hint: 'Email *',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: controller.usernameController,
                    hint: 'Username *',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      controller: controller.passwordController,
                      hint: 'Password *',
                      obscureText: true),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      controller: controller.confirmPasswordController,
                      hint: 'Confirm Password *',
                      obscureText: true),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      onPressed: () {
                        controller.checkSignup();
                      },
                      title: 'Sign Up'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontFamily: 'Ropa Sans',
                          fontSize: 24,
                          color: Color(0xff2c2c60),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(GetRoutes.login);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff970dd8),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

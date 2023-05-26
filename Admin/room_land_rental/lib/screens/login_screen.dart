import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_land_rental/controller/login_controller.dart';
import 'package:room_land_rental/routes.dart';
import 'package:room_land_rental/widget/custom_button.dart';
import 'package:room_land_rental/widget/custom_text_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<LoginController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 36,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextForm(
                  title: 'Email *',
                  hint: 'Email',
                  controller: controller.emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextForm(
                  title: 'Password  *',
                  hint: 'Password',
                  controller: controller.passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: () {
                    controller.checkLogin();
                  },
                  title: 'Login',
                )
              ],
            );
          }),
        ),
      ),
    ));
  }
}

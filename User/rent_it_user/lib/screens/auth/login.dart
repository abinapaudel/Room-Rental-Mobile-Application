import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/controller/login_controller.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/widget/custom_button.dart';
import 'package:rent_it_user/widget/custom_textfield.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
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
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<LoginController>(builder: (controller) {
            return Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 130,
                  width: 130,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color(0xff2c2c60),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hint: 'Email Address',
                  leadingIcon: const Icon(Icons.person),
                  controller: controller.emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hint: 'Password',
                  leadingIcon: const Icon(Icons.lock),
                  controller: controller.passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff2C2C60),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: true, onChanged: (bool? val) {}),
                //     const Text(
                //       'Show Password',
                //       style: TextStyle(
                //         fontSize: 18,
                //         color: Color(0xff2b2b60),
                //       ),
                //       textAlign: TextAlign.left,
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    onPressed: () {
                      controller.checkLogin();
                    },
                    title: 'Login'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff2c2c60),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(GetRoutes.signup);
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff970dd8),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
        )),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:rent_it_user/widget/loader.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  String gender = 'male';
  DateTime selectedDate =
      DateTime.now().subtract(const Duration(days: 365 * 20));

  late TextEditingController firstNameController,
      lastNameController,
      phoneNumberController,
      addressController,
      emailController,
      usernameController,
      passwordController,
      confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  checkSignup() {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      customSnackbar('Name *', 'First and Last names are required', 'error');
    } else if (phoneNumberController.text.isEmpty) {
      customSnackbar('Phone Number *', 'Phone Number is required', 'error');
    } else if (addressController.text.isEmpty) {
      customSnackbar('Address *', 'Address is required', 'error');
    } else if (emailController.text.isEmpty) {
      customSnackbar(
          'Email *', 'Please fill the email in empty field', 'error');
    } else if (!GetUtils.isEmail(emailController.text)) {
      customSnackbar('Email *', 'Invalid Email address', 'error');
    } else if (usernameController.text.isEmpty) {
      customSnackbar('Username *', 'Username is required', 'error');
    } else if (passwordController.text.isEmpty) {
      customSnackbar('Password *', 'Password is required', 'error');
    } else if (passwordController.text != confirmPasswordController.text) {
      customSnackbar('Password *', 'Password doesnot match!', 'error');
    } else {
      Get.showOverlay(
          asyncFunction: () => signUp(), loadingWidget: const Loader());
    }
  }

  signUp() async {
    var response = await http.post(Uri.parse(baseurl + 'signup.php'), body: {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'phone_number': phoneNumberController.text,
      'address': addressController.text,
      'email': emailController.text,
      'username': usernameController.text,
      'password': passwordController.text,
      'dob': selectedDate.toString().split(" ")[0],
      'gender': gender
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar('Success', 'User successfully signed up!', 'success');
      Get.toNamed(GetRoutes.login);
    } else {
      customSnackbar('Error', res['message'][0], 'success');
    }
  }
}

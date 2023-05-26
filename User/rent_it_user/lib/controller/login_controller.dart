import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rent_it_user/model/user.dart';
import 'package:rent_it_user/routes.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:rent_it_user/utils/shared_prefs.dart';
import 'package:rent_it_user/widget/loader.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    checkUserLogin();
  }

  checkUserLogin() async {
    var usr = await SharedPrefs().getUser();
    if (usr != null) {
      Get.offAllNamed(GetRoutes.home);
    }
  }

  @override
  void onClose() {
    super.onClose();

    emailController.dispose();
    passwordController.dispose();
  }

  checkLogin() {
    if (emailController.text.isEmpty) {
      customSnackbar('*Email', 'Please enter your email.', 'error');
    } else if (GetUtils.isEmail(emailController.text) == false) {
      customSnackbar('*Email', 'Please enter valid email.', 'error');
    } else if (passwordController.text.isEmpty) {
      customSnackbar('*Password', 'Please enter your password.', 'error');
    } else {
      Get.showOverlay(
          asyncFunction: () => login(), loadingWidget: const Loader());
    }
  }

  login() async {
    var response = await http.post(Uri.parse(baseurl + 'login.php'), body: {
      'email': emailController.text,
      'password': passwordController.text,
    });
    var res = await json.decode(response.body);
    if (res['success']) {
      User user = User.fromJson(res['data']);
      await SharedPrefs().storeUser(json.encode(user));
      customSnackbar('Login Success', res['message'][0], 'success');
      Get.offAllNamed(GetRoutes.home);
    } else {
      customSnackbar('Login up failed!', res['message'][0], 'error');
    }
  }
}

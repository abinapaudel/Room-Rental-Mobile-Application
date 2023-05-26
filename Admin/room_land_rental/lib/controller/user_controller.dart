import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:room_land_rental/model/user.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/utils/custom_snackbar.dart';
import 'package:room_land_rental/utils/shared_prefs.dart';

class UserController extends GetxController {
  List<User> users = [];

  User user = User.fromJson({
    'user_id': '',
    'name': '',
    'email': '',
    'contact': '',
    'address': '',
  });

  @override
  void onInit() {
    super.onInit();

    getUser();
    getAllUser();
  }

  getUser() async {
    var usr = await SharedPrefs().getUser();

    user = User.fromJson(json.decode(usr));

    update();
  }

  getAllUser() async {
    var response = await http.get(Uri.parse(baseurl + 'getAllUsers.php'));
    var res = await json.decode(response.body);
    if (res['success']) {
      users = AllUsers.fromJson(res).user!;
      update();
    } else {
      customSnackbar('User fetch failed!', res['message'][0], 'error');
    }
  }

  deleteUser(userId, context) async {
    var response =
        await http.post(Uri.parse(baseurl + 'deleteUser.php'), body: {
      'user_id': userId,
    });
    var res = await json.decode(response.body);
    if (res['success']) {
      getAllUser();
      Navigator.pop(context);
      customSnackbar('User deleted!', res['message'][0], 'success');
    } else {
      customSnackbar('User delete failed!', res['message'][0], 'error');
    }
  }
}

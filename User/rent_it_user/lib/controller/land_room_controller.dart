import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rent_it_user/controller/request_controller.dart';
import 'package:rent_it_user/model/user.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:rent_it_user/utils/shared_prefs.dart';

class LandRoomController extends GetxController {
  late TextEditingController messageController;
  DateTime selectedDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();

    messageController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();

    messageController.dispose();
  }

  makeVisitRequest(type, title, context) async {
    if (messageController.text.isEmpty) {
      customSnackbar('Error', 'Message is required!', 'error');
      return;
    }
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response =
        await http.post(Uri.parse(baseurl + 'makeVisitRequest.php'), body: {
      'user_id': user.id,
      'type': type,
      'title': title,
      'message': messageController.text,
      'date': selectedDate.toString().split(" ")[0]
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      messageController.clear();
      selectedDate = DateTime.now();
      customSnackbar('Success', res['message'][0], 'success');
      final RequestController requestController = Get.find();
      requestController.fetchRequests();
      Navigator.pop(context);
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }
}

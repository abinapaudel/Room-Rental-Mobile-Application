import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/model/user.dart';
import 'package:rent_it_user/screens/send_feedback.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:rent_it_user/utils/shared_prefs.dart';

class FeedbackController extends GetxController {
  late TextEditingController messageController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    messageController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    messageController.dispose();
  }

  sendFeedback() async {
    if (messageController.text.isEmpty) {
      customSnackbar('Error', 'Message is required!', 'error');
      return;
    }

    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response =
        await http.post(Uri.parse(baseurl + 'sendFeedback.php'), body: {
      'message': messageController.text,
      'user_id': user.id,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      messageController.clear();
      customSnackbar('Success', res['message'][0], 'success');
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }
}

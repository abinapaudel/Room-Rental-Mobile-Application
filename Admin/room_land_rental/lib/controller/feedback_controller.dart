import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:room_land_rental/model/feedback.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/utils/custom_snackbar.dart';

class FeedbackController extends GetxController {
  List<Feedback> feedbacks = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchFeedbacks();
  }

  fetchFeedbacks() async {
    var response = await http.get(Uri.parse(baseurl + 'feedbacks.php'));
    var res = await json.decode(response.body);
    if (res['success']) {
      feedbacks = AllFeedback.fromJson(res).feedback!;
      update();
    } else {
      customSnackbar('Feedback fetch failed!', res['message'][0], 'error');
    }
  }

  deleteFeedback(id, context) async {
    var response = await http
        .post(Uri.parse(baseurl + 'deleteFeedback.php'), body: {'id': id});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchFeedbacks();
      Navigator.pop(context);
    } else {
      customSnackbar('Feedback delete failed!', res['message'][0], 'error');
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/model/request.dart';
import 'package:rent_it_user/model/user.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:rent_it_user/utils/shared_prefs.dart';

class RequestController extends GetxController {
  List<Request> requests = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchRequests();
  }

  fetchRequests() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'visitRequest.php'),
        body: {'user_id': user.id});
    var res = await json.decode(response.body);
    if (res['success']) {
      requests = AllRequests.fromJson(res).request!;
      update();
    } else {
      customSnackbar('Request fetch failed!', res['message'][0], 'error');
    }
  }

  deleteRequest(id, context) async {
    var response = await http
        .post(Uri.parse(baseurl + 'deleteRequest.php'), body: {'id': id});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchRequests();
    } else {
      customSnackbar('Request delete failed!', res['message'][0], 'error');
    }
  }
}

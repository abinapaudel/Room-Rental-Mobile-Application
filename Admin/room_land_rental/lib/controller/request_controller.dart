import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:room_land_rental/model/request.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/utils/custom_snackbar.dart';

class RequestController extends GetxController {
  List<Request> requests = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchRequests();
  }

  fetchRequests() async {
    var response = await http.get(Uri.parse(baseurl + 'visitRequest.php'));
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
      Navigator.pop(context);
    } else {
      customSnackbar('Request delete failed!', res['message'][0], 'error');
    }
  }
}

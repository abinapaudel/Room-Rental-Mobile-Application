import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/model/land.dart';
import 'package:rent_it_user/model/land_bookings.dart';
import 'package:http/http.dart' as http;
import 'package:rent_it_user/model/user.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:rent_it_user/utils/shared_prefs.dart';

class LandController extends GetxController {
  List<Land> lands = [];
  List<Land> filteredLands = [];
  List<LandBookings> bookings = [];

  TextEditingController minPrice = TextEditingController();
  TextEditingController maxPrice = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchAllLands();
    fetchedBookedLands();
  }

  fetchAllLands() async {
    var response = await http.get(Uri.parse(baseurl + 'getAllLands.php'));
    var res = await json.decode(response.body);
    if (res['success']) {
      lands = AllLands.fromJson(res).land!;
      filteredLands = AllLands.fromJson(res).land!;
      print('Land' + filteredLands.toString());
      update();
    } else {
      customSnackbar('Lands fetch failed!', res['message'][0], 'error');
    }
  }

  search(String val) {
    if (val.isNotEmpty) {
      filteredLands = lands
          .where((land) =>
              land.landTitle!.toLowerCase().contains(val.toLowerCase()) ||
              land.rent!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filteredLands = lands;
    }
    update();
  }

  fetchedBookedLands() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'getBookedLand.php'),
        body: {'user_id': user.id});
    var res = await json.decode(response.body);
    if (res['success']) {
      bookings = AllLandBookings.fromJson(res).landBookings!;
      update();
    } else {
      customSnackbar('Bookings fetch failed!', res['message'][0], 'error');
    }
  }

  bookLand(token, landId, context) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'bookLand.php'),
        body: {'land_id': landId, 'token': token, 'user_id': user.id});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchedBookedLands();
      fetchAllLands();
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  cancelBooking(id, context) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'cancelLandBook.php'),
        body: {'id': id, 'user_id': user.id});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchedBookedLands();
      fetchAllLands();
      Navigator.pop(context);
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  filterLand() {
    if (minPrice.text.isEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isEmpty) {
      filteredLands = lands;
      update();
    } else if (minPrice.text.isNotEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isEmpty) {
      filteredLands = lands
          .where(
              (element) => int.parse(element.rent!) >= int.parse(minPrice.text))
          .toList();
    } else if (minPrice.text.isEmpty &&
        maxPrice.text.isNotEmpty &&
        address.text.isEmpty) {
      filteredLands = lands
          .where(
              (element) => int.parse(element.rent!) <= int.parse(maxPrice.text))
          .toList();
    } else if (minPrice.text.isEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isNotEmpty) {
      filteredLands = lands
          .where((element) =>
              element.location!.toLowerCase().contains(address.text))
          .toList();
    } else if (minPrice.text.isNotEmpty &&
        maxPrice.text.isNotEmpty &&
        address.text.isEmpty) {
      filteredLands = lands
          .where((element) =>
              (int.parse(element.rent!) >= int.parse(minPrice.text) &&
                  int.parse(element.rent!) <= int.parse(maxPrice.text)))
          .toList();
    } else if (minPrice.text.isNotEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isNotEmpty) {
      filteredLands = lands
          .where((element) =>
              (int.parse(element.rent!) >= int.parse(minPrice.text)) &&
              element.location!.toLowerCase().contains(address.text))
          .toList();
    } else if (minPrice.text.isEmpty &&
        maxPrice.text.isNotEmpty &&
        address.text.isNotEmpty) {
      filteredLands = lands
          .where((element) =>
              (int.parse(element.rent!) <= int.parse(maxPrice.text)) &&
              element.location!.toLowerCase().contains(address.text))
          .toList();
    } else {
      filteredLands = lands
          .where((element) =>
              (int.parse(element.rent!) >= int.parse(minPrice.text) &&
                  int.parse(element.rent!) <= int.parse(maxPrice.text)) &&
              element.location!.toLowerCase().contains(address.text))
          .toList();
    }

    update();
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rent_it_user/model/room.dart';
import 'package:http/http.dart' as http;
import 'package:rent_it_user/model/room_bookings.dart';
import 'package:rent_it_user/model/user.dart';
import 'package:rent_it_user/screens/room/room_booking.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:rent_it_user/utils/shared_prefs.dart';

class RoomController extends GetxController {
  List<Room> rooms = [];
  List<Room> filteredRooms = [];

  List<RoomBookings> bookings = [];

  TextEditingController minPrice = TextEditingController();
  TextEditingController maxPrice = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchAllRooms();
    fetchedBookedRooms();
  }

  fetchAllRooms() async {
    var response = await http.get(Uri.parse(baseurl + 'getAllRooms.php'));
    var res = await json.decode(response.body);
    if (res['success']) {
      rooms = AllRooms.fromJson(res).room!;
      filteredRooms = AllRooms.fromJson(res).room!;
      update();
    } else {
      customSnackbar('Rooms fetch failed!', res['message'][0], 'error');
    }
  }

  search(String val) {
    if (val.isNotEmpty) {
      filteredRooms = rooms
          .where((room) =>
              room.roomTitle!.toLowerCase().contains(val.toLowerCase()) ||
              room.rent!.toLowerCase().contains(val.toLowerCase()) ||
              room.location!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filteredRooms = rooms;
    }
    update();
  }

  fetchedBookedRooms() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'getBookedRoom.php'),
        body: {'user_id': user.id});
    var res = await json.decode(response.body);
    if (res['success']) {
      bookings = AllRoomBookings.fromJson(res).roomBookings!;
      update();
    } else {
      customSnackbar('Bookings fetch failed!', res['message'][0], 'error');
    }
  }

  bookRoom(token, roomId, context) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'bookRoom.php'),
        body: {'room_id': roomId, 'token': token, 'user_id': user.id});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchedBookedRooms();
      fetchAllRooms();
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  cancelBooking(id, context) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var response = await http.post(Uri.parse(baseurl + 'cancelRoomBook.php'),
        body: {'id': id, 'user_id': user.id});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchedBookedRooms();
      fetchAllRooms();
      Navigator.pop(context);
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  filterRoom() {
    if (minPrice.text.isEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isEmpty) {
      filteredRooms = rooms;
      update();
    } else if (minPrice.text.isNotEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isEmpty) {
      filteredRooms = rooms
          .where(
              (element) => int.parse(element.rent!) >= int.parse(minPrice.text))
          .toList();
    } else if (minPrice.text.isEmpty &&
        maxPrice.text.isNotEmpty &&
        address.text.isEmpty) {
      filteredRooms = rooms
          .where(
              (element) => int.parse(element.rent!) <= int.parse(maxPrice.text))
          .toList();
    } else if (minPrice.text.isEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isNotEmpty) {
      filteredRooms = rooms
          .where((element) =>
              element.location!.toLowerCase().contains(address.text))
          .toList();
    } else if (minPrice.text.isNotEmpty &&
        maxPrice.text.isNotEmpty &&
        address.text.isEmpty) {
      filteredRooms = rooms
          .where((element) =>
              (int.parse(element.rent!) >= int.parse(minPrice.text) &&
                  int.parse(element.rent!) <= int.parse(maxPrice.text)))
          .toList();
    } else if (minPrice.text.isNotEmpty &&
        maxPrice.text.isEmpty &&
        address.text.isNotEmpty) {
      filteredRooms = rooms
          .where((element) =>
              (int.parse(element.rent!) >= int.parse(minPrice.text)) &&
              element.location!.toLowerCase().contains(address.text))
          .toList();
    } else if (minPrice.text.isEmpty &&
        maxPrice.text.isNotEmpty &&
        address.text.isNotEmpty) {
      filteredRooms = rooms
          .where((element) =>
              (int.parse(element.rent!) <= int.parse(maxPrice.text)) &&
              element.location!.toLowerCase().contains(address.text))
          .toList();
    } else {
      filteredRooms = rooms
          .where((element) =>
              (int.parse(element.rent!) >= int.parse(minPrice.text) &&
                  int.parse(element.rent!) <= int.parse(maxPrice.text)) &&
              element.location!.toLowerCase().contains(address.text))
          .toList();
    }

    update();
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:room_land_rental/model/room.dart';
import 'package:room_land_rental/model/room_bookings.dart';
import 'package:room_land_rental/routes.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/utils/custom_snackbar.dart';
import 'package:room_land_rental/widget/loader.dart';

class RoomController extends GetxController {
  List<Room> rooms = [];
  List<Room> filteredRooms = [];
  int balcony = 0;
  int parking = 0;

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  List<Images> images = [];

  String id = "";

  List<RoomBookings> bookings = [];

  late TextEditingController roomTitleController,
      bedroomNoController,
      kitchenNoController,
      hallNoController,
      locationController,
      roomDescController,
      roomRentController,
      ownerFirstNameController,
      ownerLastNameController,
      phoneController,
      emailController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    roomTitleController = TextEditingController();
    bedroomNoController = TextEditingController();
    kitchenNoController = TextEditingController();
    locationController = TextEditingController();
    hallNoController = TextEditingController();
    roomDescController = TextEditingController();
    roomRentController = TextEditingController();
    ownerFirstNameController = TextEditingController();
    ownerLastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();

    fetchAllRooms();
    fetchedBookedRooms();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    roomTitleController.dispose();
    bedroomNoController.dispose();
    kitchenNoController.dispose();
    locationController.dispose();
    hallNoController.dispose();
    roomDescController.dispose();
    roomRentController.dispose();

    ownerFirstNameController.dispose();
    ownerLastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
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

  Future<void> pickImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        update();
      } else {
        customSnackbar('Error', 'No Images selected', 'error');
      }
    } catch (e) {
      customSnackbar('Error', 'Something went wrong!', 'error');
    }
  }

  checkRoomDetails(isEdit) async {
    if (roomTitleController.text.isEmpty) {
      customSnackbar('Room Title *', 'Please enter room title', 'error');
    } else if (bedroomNoController.text.isEmpty) {
      customSnackbar('Bed Room *', 'Please enter no of bedrooms', 'error');
    } else if (kitchenNoController.text.isEmpty) {
      customSnackbar('Kitchen *', 'Please enter no of kitchen', 'error');
    } else if (hallNoController.text.isEmpty) {
      customSnackbar('Hall *', 'Please enter no of hall', 'error');
    } else if (locationController.text.isEmpty) {
      customSnackbar('Location *', 'Please enter room location', 'error');
    } else if (roomDescController.text.isEmpty) {
      customSnackbar('Description', 'Please enter room description', 'error');
    } else if (roomRentController.text.isEmpty) {
      customSnackbar('Rent *', 'Please enter room rent', 'error');
    } else if (ownerFirstNameController.text.isEmpty) {
      customSnackbar(
          'Owner First Name *', 'Please enter owner first name', 'error');
    } else if (ownerFirstNameController.text.isEmpty) {
      customSnackbar(
          'Owner Last Name *', 'Please enter owner last name', 'error');
    } else if (ownerFirstNameController.text.isEmpty) {
      customSnackbar('Phone *', 'Please enter phone number', 'error');
    } else if (ownerFirstNameController.text.isEmpty) {
      customSnackbar('Email *', 'Please enter email address', 'error');
    } else {
      if (isEdit) {
        Get.showOverlay(
            asyncFunction: () => editRoom(), loadingWidget: const Loader());
      } else {
        Get.showOverlay(
            asyncFunction: () => uploadRoom(), loadingWidget: const Loader());
      }
    }
  }

  uploadRoom() async {
    var url = Uri.parse(baseurl + 'addRoom.php');
    var request = http.MultipartRequest("POST", url);
    if (imagefiles != null) {
      for (var element in imagefiles!) {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', element.path));
      }
    }
    request.fields['room_title'] = roomTitleController.text;
    request.fields['bedroom_no'] = bedroomNoController.text;
    request.fields['kitchen_no'] = kitchenNoController.text;
    request.fields['hall_no'] = hallNoController.text;
    request.fields['location'] = locationController.text;
    request.fields['room_desc'] = roomDescController.text;
    request.fields['rent'] = roomRentController.text;
    request.fields['isBalcony'] = balcony.toString();
    request.fields['isParking'] = parking.toString();
    request.fields['owner_firstname'] = ownerFirstNameController.text;
    request.fields['owner_lastname'] = ownerLastNameController.text;
    request.fields['phone_no'] = phoneController.text;
    request.fields['email'] = emailController.text;

    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);

    if (res['success']) {
      Get.toNamed(GetRoutes.home);
      fetchAllRooms();
      customSnackbar('Success', res['message'][0], 'success');
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  editRoom() async {
    var url = Uri.parse(baseurl + 'editRoom.php');
    var request = http.MultipartRequest("POST", url);
    if (imagefiles != null) {
      for (var element in imagefiles!) {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', element.path));
      }
    }
    request.fields['room_id'] = id;
    request.fields['room_title'] = roomTitleController.text;
    request.fields['bedroom_no'] = bedroomNoController.text;
    request.fields['kitchen_no'] = kitchenNoController.text;
    request.fields['hall_no'] = hallNoController.text;
    request.fields['location'] = locationController.text;
    request.fields['room_desc'] = roomDescController.text;
    request.fields['rent'] = roomRentController.text;
    request.fields['isBalcony'] = balcony.toString();
    request.fields['isParking'] = parking.toString();
    request.fields['owner_firstname'] = ownerFirstNameController.text;
    request.fields['owner_lastname'] = ownerLastNameController.text;
    request.fields['phone_no'] = phoneController.text;
    request.fields['email'] = emailController.text;

    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);

    if (res['success']) {
      Get.toNamed(GetRoutes.home);
      fetchAllRooms();
      resetRoomDetails();
      customSnackbar('Success', res['message'][0], 'success');
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  search(String val) {
    if (val.isNotEmpty) {
      filteredRooms = rooms
          .where((room) =>
              room.roomTitle!.toLowerCase().contains(val.toLowerCase()) ||
              room.rent!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filteredRooms = rooms;
    }
    update();
  }

  roomEditInitiate(Room room) {
    id = room.id!;
    roomTitleController.text = room.roomTitle!;
    bedroomNoController.text = room.bedroomNo!.toString();
    kitchenNoController.text = room.kitchenNo!.toString();
    locationController.text = room.location!;
    hallNoController.text = room.hallNo!.toString();
    roomDescController.text = room.roomDesc!;
    roomRentController.text = room.rent!;
    ownerFirstNameController.text = room.ownerFirstname!;
    ownerLastNameController.text = room.ownerLastname!;
    phoneController.text = room.phoneNo!;
    emailController.text = room.email!;
    balcony = int.parse(room.isBalcony!);
    parking = int.parse(room.isParking!);
    images = room.images!;
  }

  resetRoomDetails() {
    id = "";
    roomTitleController.text = "";
    bedroomNoController.text = "";
    kitchenNoController.text = "";
    locationController.text = "";
    hallNoController.text = "";
    roomDescController.text = "";
    roomRentController.text = "";
    ownerFirstNameController.text = "";
    ownerLastNameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    balcony = 0;
    parking = 0;
    images = [];
  }

  fetchedBookedRooms() async {
    var response = await http.post(Uri.parse(baseurl + 'getBookedRoom.php'));
    var res = await json.decode(response.body);
    if (res['success']) {
      bookings = AllRoomBookings.fromJson(res).roomBookings!;
      update();
    } else {
      customSnackbar('Bookings fetch failed!', res['message'][0], 'error');
    }
  }

  cancelBooking(id, userId, context) async {
    var response = await http.post(Uri.parse(baseurl + 'cancelRoomBook.php'),
        body: {'id': id, 'user_id': userId});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchedBookedRooms();
      Navigator.pop(context);
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  deleteRoom(id) async {
    var response = await http
        .post(Uri.parse(baseurl + 'deleteRoom.php'), body: {"room_id": id});
    var res = await json.decode(response.body);
    if (res['success']) {
      fetchAllRooms();
      customSnackbar('Success!', res['message'][0], 'success');
      update();
    } else {
      customSnackbar('Failed!', res['message'][0], 'error');
    }
  }
}

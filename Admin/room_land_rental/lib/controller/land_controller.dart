import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:room_land_rental/model/land.dart';
import 'package:room_land_rental/model/land_bookings.dart';
import 'package:room_land_rental/routes.dart';
import 'package:room_land_rental/utils/baseurl.dart';
import 'package:room_land_rental/utils/custom_snackbar.dart';
import 'package:room_land_rental/widget/loader.dart';

class LandController extends GetxController {
  List<Land> lands = [];
  List<Land> filteredLands = [];

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<Images> images = [];
  String id = "";
  List<LandBookings> bookings = [];

  late TextEditingController landTitleController,
      locationController,
      landDescController,
      landRentController,
      landAreaController,
      ownerFirstNameController,
      ownerLastNameController,
      phoneController,
      emailController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    landTitleController = TextEditingController();
    locationController = TextEditingController();
    landDescController = TextEditingController();
    landRentController = TextEditingController();
    landAreaController = TextEditingController();
    ownerFirstNameController = TextEditingController();
    ownerLastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();

    fetchAllLands();
    fetchedBookedLands();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    landTitleController.dispose();
    locationController.dispose();
    landDescController.dispose();
    landRentController.dispose();
    landAreaController.dispose();

    ownerFirstNameController.dispose();
    ownerLastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  fetchAllLands() async {
    var response = await http.get(Uri.parse(baseurl + 'getAllLands.php'));
    var res = await json.decode(response.body);
    if (res['success']) {
      lands = AllLands.fromJson(res).land!;
      filteredLands = AllLands.fromJson(res).land!;
      update();
    } else {
      customSnackbar('Lands fetch failed!', res['message'][0], 'error');
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

  checkLandDetails(isEdit) async {
    if (landTitleController.text.isEmpty) {
      customSnackbar('Room Title *', 'Please enter land title', 'error');
    } else if (locationController.text.isEmpty) {
      customSnackbar('Location *', 'Please enter land location', 'error');
    } else if (landDescController.text.isEmpty) {
      customSnackbar('Description', 'Please enter land description', 'error');
    } else if (landRentController.text.isEmpty) {
      customSnackbar('Rent *', 'Please enter land rent', 'error');
    } else if (landAreaController.text.isEmpty) {
      customSnackbar('Area *', 'Please enter land rent', 'error');
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
            asyncFunction: () => editLand(), loadingWidget: const Loader());
      } else {
        Get.showOverlay(
            asyncFunction: () => uploadLand(), loadingWidget: const Loader());
      }
    }
  }

  uploadLand() async {
    var url = Uri.parse(baseurl + 'addLand.php');
    var request = http.MultipartRequest("POST", url);
    if (imagefiles != null) {
      for (var element in imagefiles!) {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', element.path));
      }
    }
    request.fields['land_title'] = landTitleController.text;
    request.fields['location'] = locationController.text;
    request.fields['land_desc'] = landDescController.text;
    request.fields['rent'] = landRentController.text;
    request.fields['area'] = landAreaController.text;
    request.fields['owner_firstname'] = ownerFirstNameController.text;
    request.fields['owner_lastname'] = ownerLastNameController.text;
    request.fields['phone_no'] = phoneController.text;
    request.fields['email'] = emailController.text;

    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);

    if (res['success']) {
      Get.toNamed(GetRoutes.home);
      fetchAllLands();
      customSnackbar('Success', res['message'][0], 'success');
    } else {
      customSnackbar('Error', res['message'][0], 'error');
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

  editLand() async {
    var url = Uri.parse(baseurl + 'editLand.php');
    var request = http.MultipartRequest("POST", url);
    if (imagefiles != null) {
      for (var element in imagefiles!) {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', element.path));
      }
    }
    request.fields['land_id'] = id;
    request.fields['land_title'] = landTitleController.text;
    request.fields['location'] = locationController.text;
    request.fields['land_desc'] = landDescController.text;
    request.fields['rent'] = landRentController.text;
    request.fields['area'] = landAreaController.text;
    request.fields['owner_firstname'] = ownerFirstNameController.text;
    request.fields['owner_lastname'] = ownerLastNameController.text;
    request.fields['phone_no'] = phoneController.text;
    request.fields['email'] = emailController.text;

    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);

    if (res['success']) {
      resetLandDetails();
      Get.toNamed(GetRoutes.home);
      fetchAllLands();
      customSnackbar('Success', res['message'][0], 'success');
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  landEditInitiate(Land land) {
    id = land.id!;
    landTitleController.text = land.landTitle!;
    locationController.text = land.location!;
    landDescController.text = land.landDesc!;
    landRentController.text = land.rent!;
    landAreaController.text = land.area!;
    ownerFirstNameController.text = land.ownerFirstname!;
    ownerLastNameController.text = land.ownerLastname!;
    phoneController.text = land.phoneNo!;
    emailController.text = land.email!;
    images = land.images!;
  }

  resetLandDetails() {
    id = "";
    landTitleController.text = "";
    locationController.text = "";
    landDescController.text = "";
    landRentController.text = "";
    landAreaController.text = "";
    ownerFirstNameController.text = "";
    ownerLastNameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    images = [];
  }

  fetchedBookedLands() async {
    var response = await http.post(Uri.parse(baseurl + 'getBookedLand.php'));
    var res = await json.decode(response.body);
    if (res['success']) {
      bookings = AllLandBookings.fromJson(res).landBookings!;
      update();
    } else {
      customSnackbar('Bookings fetch failed!', res['message'][0], 'error');
    }
  }

  cancelBooking(id, userId, context) async {
    var response = await http.post(Uri.parse(baseurl + 'cancelLandBook.php'),
        body: {'id': id, 'user_id': userId});
    var res = await json.decode(response.body);
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      fetchedBookedLands();
      Navigator.pop(context);
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
  }

  deleteLand(id) async {
    var response = await http
        .post(Uri.parse(baseurl + 'deleteLand.php'), body: {"land_id": id});
    var res = await json.decode(response.body);
    if (res['success']) {
      fetchAllLands();
      customSnackbar('Success!', res['message'][0], 'success');
      update();
    } else {
      customSnackbar('Failed!', res['message'][0], 'error');
    }
  }
}

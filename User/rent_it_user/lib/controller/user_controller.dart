import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rent_it_user/model/user.dart';
import 'package:rent_it_user/utils/baseurl.dart';
import 'package:rent_it_user/utils/custom_snackbar.dart';
import 'package:rent_it_user/utils/shared_prefs.dart';

class UserController extends GetxController {
  String gender = 'male';
  DateTime selectedDate =
      DateTime.now().subtract(const Duration(days: 365 * 20));
  late TextEditingController firstNameController,
      lastNameController,
      phoneNumberController,
      addressController,
      emailController,
      usernameController;

  File? imageFile;
  User user = User.fromJson({
    'id': "",
    'first_name': "",
    'last_name': "",
    'username': "",
    'dob': "",
    'gender': "",
    'email': "",
    'phone_number': "",
    'address': "",
    'role': "",
    'image': "",
  });

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    getUser();
  }

  @override
  onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    emailController.dispose();
    usernameController.dispose();
  }

  getUser() async {
    var usr = await SharedPrefs().getUser();
    user = User.fromJson(json.decode(usr));

    firstNameController.text = user.firstName!;
    lastNameController.text = user.lastName!;
    phoneNumberController.text = user.phoneNumber!;
    addressController.text = user.address!;
    emailController.text = user.email!;
    usernameController.text = user.username!;

    selectedDate = DateTime.parse(user.dob!);
    gender = user.gender!;

    update();
  }

  pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      uploadProfilePic();
    }
  }

  uploadProfilePic() async {
    var url = Uri.parse(baseurl + 'edit_user_profile_pic.php');
    var request = http.MultipartRequest("POST", url);
    request.fields["userId"] = user.id!;
    if (imageFile != null) {
      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      //add multipart to request
      request.files.add(pic);
    }
    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);
    if (res["success"]) {
      user.image = res["data"];
      await SharedPrefs().storeUser(json.encode(user));
      customSnackbar('Success', res["message"][0], 'success');
    } else {
      customSnackbar('Failed', res["message"][0], 'error');
    }

    update();
  }

  editUser(context) async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      customSnackbar('Error', 'Please fill all the fields', 'error');

      firstNameController.text = user.firstName!;
      lastNameController.text = user.lastName!;
      phoneNumberController.text = user.phoneNumber!;
      addressController.text = user.address!;
      emailController.text = user.email!;
      usernameController.text = user.username!;

      update();
      return;
    }

    var response =
        await http.post(Uri.parse(baseurl + 'editprofile.php'), body: {
      'user_id': user.id,
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'dob': selectedDate.toString().split(" ")[0],
      'gender': gender,
      'username': usernameController.text,
      'phone_number': phoneNumberController.text,
      'address': addressController.text,
    });

    var res = await json.decode(response.body);
    if (res['success']) {
      Navigator.pop(context);
      customSnackbar('Success', 'Profile updated successfully', 'success');

      user.firstName = firstNameController.text;
      user.lastName = lastNameController.text;
      user.dob = selectedDate.toString().split(" ")[0];
      user.gender = gender;
      user.username = usernameController.text;
      user.phoneNumber = phoneNumberController.text;
      user.address = addressController.text;

      await SharedPrefs().storeUser(json.encode(user));
      getUser();
    } else {
      customSnackbar('Error', 'Something went wrong', 'error');
    }
  }
}

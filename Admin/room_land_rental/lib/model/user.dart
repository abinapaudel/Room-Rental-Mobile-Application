class AllUsers {
  bool? success;
  List<String>? message;
  List<User>? user;

  AllUsers({this.success, this.message, this.user});

  AllUsers.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      user = <User>[];
      json['data'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (user != null) {
      data['data'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? dob;
  String? gender;
  String? email;
  String? phoneNumber;
  String? address;
  String? role;
  String? image;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.dob,
      this.gender,
      this.email,
      this.phoneNumber,
      this.address,
      this.image,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    role = json['role'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['dob'] = dob;
    data['gender'] = gender;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['role'] = role;
    data['image'] = image;
    return data;
  }
}

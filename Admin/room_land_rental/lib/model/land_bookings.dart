class AllLandBookings {
  bool? success;
  List<String>? message;
  List<LandBookings>? landBookings;

  AllLandBookings({this.success, this.message, this.landBookings});

  AllLandBookings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      landBookings = <LandBookings>[];
      json['data'].forEach((v) {
        landBookings!.add(LandBookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (landBookings != null) {
      data['data'] = landBookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LandBookings {
  String? id;
  String? landId;
  String? userId;
  String? token;
  String? status;
  String? date;
  String? landTitle;
  String? firstName;

  LandBookings(
      {this.id,
      this.landId,
      this.userId,
      this.token,
      this.status,
      this.date,
      this.landTitle,
      this.firstName});

  LandBookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landId = json['land_id'];
    userId = json['user_id'];
    token = json['token'];
    status = json['status'];
    date = json['date'];
    landTitle = json['land_title'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['land_id'] = landId;
    data['user_id'] = userId;
    data['token'] = token;
    data['status'] = status;
    data['date'] = date;
    data['land_title'] = landTitle;
    data['first_name'] = firstName;
    return data;
  }
}

class AllRoomBookings {
  bool? success;
  List<String>? message;
  List<RoomBookings>? roomBookings;

  AllRoomBookings({this.success, this.message, this.roomBookings});

  AllRoomBookings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      roomBookings = <RoomBookings>[];
      json['data'].forEach((v) {
        roomBookings!.add(RoomBookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (roomBookings != null) {
      data['data'] = roomBookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomBookings {
  String? id;
  String? roomId;
  String? userId;
  String? token;
  String? status;
  String? date;
  String? roomTitle;
  String? firstName;

  RoomBookings(
      {this.id,
      this.roomId,
      this.userId,
      this.token,
      this.status,
      this.date,
      this.roomTitle,
      this.firstName});

  RoomBookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    userId = json['user_id'];
    token = json['token'];
    status = json['status'];
    date = json['date'];
    roomTitle = json['room_title'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_id'] = roomId;
    data['user_id'] = userId;
    data['token'] = token;
    data['status'] = status;
    data['date'] = date;
    data['room_title'] = roomTitle;
    data['first_name'] = firstName;
    return data;
  }
}

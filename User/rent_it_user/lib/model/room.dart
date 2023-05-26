class AllRooms {
  bool? success;
  List<Room>? room;

  AllRooms({this.success, this.room});

  AllRooms.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      room = <Room>[];
      json['data'].forEach((v) {
        room!.add(Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (room != null) {
      data['data'] = room!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Room {
  String? id;
  String? roomTitle;
  String? bedroomNo;
  String? kitchenNo;
  String? hallNo;
  String? location;
  String? roomDesc;
  String? rent;
  String? isBalcony;
  String? isParking;
  String? ownerFirstname;
  String? ownerLastname;
  String? phoneNo;
  String? email;
  int? booked;
  List<Images>? images;

  Room(
      {this.roomTitle,
      this.id,
      this.bedroomNo,
      this.kitchenNo,
      this.hallNo,
      this.location,
      this.roomDesc,
      this.rent,
      this.isBalcony,
      this.isParking,
      this.ownerFirstname,
      this.ownerLastname,
      this.phoneNo,
      this.email,
      this.booked,
      this.images});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomTitle = json['room_title'];
    bedroomNo = json['bedroom_no'];
    kitchenNo = json['kitchen_no'];
    hallNo = json['hall_no'];
    location = json['location'];
    roomDesc = json['room_desc'];
    rent = json['rent'];
    isBalcony = json['isBalcony'];
    isParking = json['isParking'];
    ownerFirstname = json['owner_firstname'];
    ownerLastname = json['owner_lastname'];
    phoneNo = json['phone_no'];
    email = json['email'];
    booked = json['booked'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_title'] = roomTitle;
    data['bedroom_no'] = bedroomNo;
    data['kitchen_no'] = kitchenNo;
    data['hall_no'] = hallNo;
    data['location'] = location;
    data['room_desc'] = roomDesc;
    data['rent'] = rent;
    data['isBalcony'] = isBalcony;
    data['isParking'] = isParking;
    data['owner_firstname'] = ownerFirstname;
    data['owner_lastname'] = ownerLastname;
    data['phone_no'] = phoneNo;
    data['email'] = email;
    data['booked'] = booked;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? id;
  String? roomId;
  String? path;

  Images({this.id, this.roomId, this.path});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_id'] = roomId;
    data['path'] = path;
    return data;
  }
}

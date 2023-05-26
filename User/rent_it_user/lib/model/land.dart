class AllLands {
  bool? success;
  List<Land>? land;

  AllLands({this.success, this.land});

  AllLands.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      land = <Land>[];
      json['data'].forEach((v) {
        land!.add(Land.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (land != null) {
      data['data'] = land!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Land {
  String? id;
  String? landTitle;
  String? location;
  String? landDesc;
  String? rent;
  String? area;
  String? ownerFirstname;
  String? ownerLastname;
  String? phoneNo;
  String? email;
  List<Images>? images;
  int? booked;

  Land(
      {this.landTitle,
      this.id,
      this.location,
      this.landDesc,
      this.rent,
      this.area,
      this.ownerFirstname,
      this.ownerLastname,
      this.phoneNo,
      this.email,
      this.booked,
      this.images});

  Land.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landTitle = json['land_title'];
    location = json['location'];
    landDesc = json['land_desc'];
    rent = json['rent'];
    area = json['area'];
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
    data['land_title'] = landTitle;
    data['location'] = location;
    data['land_desc'] = landDesc;
    data['rent'] = rent;
    data['area'] = area;
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
  String? landId;
  String? path;

  Images({this.id, this.landId, this.path});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landId = json['land_id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['land_id'] = landId;
    data['path'] = path;
    return data;
  }
}

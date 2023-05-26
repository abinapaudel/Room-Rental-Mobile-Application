class AllRequests {
  bool? success;
  List<String>? message;
  List<Request>? request;

  AllRequests({this.success, this.message, this.request});

  AllRequests.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      request = <Request>[];
      json['data'].forEach((v) {
        request!.add(Request.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (request != null) {
      data['data'] = request!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Request {
  String? id;
  String? type;
  String? message;
  String? date;
  String? title;
  String? name;

  Request({this.id, this.type, this.message, this.date, this.title, this.name});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    message = json['message'];
    date = json['date'];
    title = json['title'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['message'] = message;
    data['date'] = date;
    data['title'] = title;
    data['name'] = name;
    return data;
  }
}

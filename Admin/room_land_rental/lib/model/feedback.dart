class AllFeedback {
  bool? success;
  List<String>? message;
  List<Feedback>? feedback;

  AllFeedback({this.success, this.message, this.feedback});

  AllFeedback.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      feedback = <Feedback>[];
      json['data'].forEach((v) {
        feedback!.add(new Feedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (feedback != null) {
      data['data'] = feedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedback {
  String? id;
  String? name;
  String? feedback;

  Feedback({this.id, this.name, this.feedback});

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['feedback'] = feedback;
    return data;
  }
}

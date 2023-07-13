class NotificationModel {
  int? statusCode;
  Null? message;
  List<NotificationData>? data;

  NotificationModel({this.statusCode, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? title;
  String? content;
  String? date;
  String? time;
  String? type;
  int? isShow;

  NotificationData(
      {this.id,
        this.title,
        this.content,
        this.date,
        this.time,
        this.type,
        this.isShow});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    time = json['time'];
    type = json['type'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['time'] = this.time;
    data['type'] = this.type;
    data['is_show'] = this.isShow;
    return data;
  }
}

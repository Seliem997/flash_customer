class BasicServicesModel {
  int? statusCode;
  String? message;
  List<BasicServicesData>? data;

  BasicServicesModel({this.statusCode, this.message, this.data});

  BasicServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BasicServicesData>[];
      json['data'].forEach((v) {
        data!.add(new BasicServicesData.fromJson(v));
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

class BasicServicesData {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  int? duration;

  BasicServicesData({this.id, this.title, this.image, this.info, this.type, this.duration});

  BasicServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['info'] = this.info;
    data['type'] = this.type;
    data['duration'] = this.duration;
    return data;
  }
}

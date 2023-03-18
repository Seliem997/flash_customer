class OtherServicesModel {
  int? statusCode;
  List<OtherServicesData>? data;
  Null? message;

  OtherServicesModel({this.statusCode, this.data, this.message});

  OtherServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <OtherServicesData>[];
      json['data'].forEach((v) {
        data!.add(new OtherServicesData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class OtherServicesData {
  int? id;
  String? parentId;
  String? name;
  String? deal;
  String? info;
  String? image;
  String? type;

  OtherServicesData(
      {this.id,
        this.parentId,
        this.name,
        this.deal,
        this.info,
        this.image,
        this.type});

  OtherServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    deal = json['deal'];
    info = json['info'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['deal'] = this.deal;
    data['info'] = this.info;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}

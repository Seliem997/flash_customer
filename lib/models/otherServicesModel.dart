class OtherServicesModel {
  int? statusCode;
  List<OtherServicesData>? data;
  String? message;

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
  List<Cities>? cities;
  String? deal;
  String? info;
  String? image;
  String? type;

  OtherServicesData(
      {this.id,
        this.parentId,
        this.name,
        this.cities,
        this.deal,
        this.info,
        this.image,
        this.type});

  OtherServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
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
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    data['deal'] = this.deal;
    data['info'] = this.info;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}

class Cities {
  int? id;
  String? name;
  Price? price;

  Cities({this.id, this.name, this.price});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class Price {
  String? value;
  String? unit;

  Price({this.value, this.unit});

  Price.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}

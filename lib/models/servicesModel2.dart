class ServicesModel {
  int? statusCode;
  Null? message;
  List<ServiceData>? data;

  ServicesModel({this.statusCode, this.message, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(new ServiceData.fromJson(v));
      });
    }
  }
}

class ServiceData {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  int? duration;
  bool? countable;
  bool isSelected = false;
  int quantity = 0;
  List<Cities>? cities;
  List<ChildServices>? childServices;

  ServiceData(
      {this.id,
      this.title,
      this.image,
      this.info,
      this.type,
      this.duration,
      this.countable,
      this.cities,
      this.childServices});

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
    countable = json['countable'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['child_services'] != null) {
      childServices = <ChildServices>[];
      json['child_services'].forEach((v) {
        childServices!.add(new ChildServices.fromJson(v));
      });
    }
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
  int? vehicleType;
  int? vehicleSubType;

  Price({this.value, this.unit, this.vehicleType, this.vehicleSubType});

  Price.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
    vehicleType = json['vehicle_type'];
    vehicleSubType = json['vehicle_sub_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_sub_type'] = this.vehicleSubType;
    return data;
  }
}

class ChildServices {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  int? duration;
  bool? countable;
  List<Cities>? cities;
  List<ChildServices>? childServices;

  ChildServices(
      {this.id,
      this.title,
      this.image,
      this.info,
      this.type,
      this.duration,
      this.countable,
      this.cities,
      this.childServices});

  ChildServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
    countable = json['countable'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['child_services'] != null) {
      childServices = <ChildServices>[];
      json['child_services'].forEach((v) {
        childServices!.add(ChildServices.fromJson(v));
      });
    }
  }
}

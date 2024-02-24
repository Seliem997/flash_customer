class VehiclesActiveTypesModel {
  dynamic  statusCode;
  Null? message;
  List<VehiclesActiveTypesData>? data;

  VehiclesActiveTypesModel({this.statusCode, this.message, this.data});

  VehiclesActiveTypesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VehiclesActiveTypesData>[];
      json['data'].forEach((v) {
        data!.add(new VehiclesActiveTypesData.fromJson(v));
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

class VehiclesActiveTypesData {
  dynamic  id;
  String? name;
  String? image;
  dynamic isActive;
  List<SubTypes>? subTypes;

  VehiclesActiveTypesData({this.id, this.name, this.image, this.isActive, this.subTypes});

  VehiclesActiveTypesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    if (json['sub_types'] != null) {
      subTypes = <SubTypes>[];
      json['sub_types'].forEach((v) {
        subTypes!.add(new SubTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    if (this.subTypes != null) {
      data['sub_types'] = this.subTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubTypes {
  dynamic  id;
  String? name;
  String? image;
  dynamic isActive;
  dynamic vehicleTypeId;

  SubTypes({this.id, this.name, this.image, this.isActive, this.vehicleTypeId});

  SubTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isActive = json['is_active'];
    vehicleTypeId = json['vehicle_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['vehicle_type_id'] = this.vehicleTypeId;
    return data;
  }
}

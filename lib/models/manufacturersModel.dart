class ManufacturersModel {
  int? statusCode;
  List<ManufacturerData>? data;
  String? message;

  ManufacturersModel({this.statusCode, this.data, this.message});

  ManufacturersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <ManufacturerData>[];
      json['data'].forEach((v) {
        data!.add(ManufacturerData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ManufacturerData {
  int? id;
  String? name;
  String? image;
  int? vehicleTypeId;
  int? subVehicleTypeId;
  int? isActive;

  ManufacturerData(
      {this.id,
        this.name,
        this.image,
        this.vehicleTypeId,
        this.subVehicleTypeId,
        this.isActive});

  ManufacturerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    vehicleTypeId = json['vehicle_type_id'];
    subVehicleTypeId = json['sub_vehicle_type_id'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['vehicle_type_id'] = vehicleTypeId;
    data['sub_vehicle_type_id'] = subVehicleTypeId;
    data['is_active'] = isActive;
    return data;
  }
}

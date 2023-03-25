
class VehicleModelsModel {
  int? statusCode;
  List<VehiclesModelsData>? data;
  String? message;

  VehicleModelsModel({this.statusCode, this.data, this.message});

  VehicleModelsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <VehiclesModelsData>[];
      json['data'].forEach((v) {
        data!.add(VehiclesModelsData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;

    data['message'] = message;
    return data;
  }
}

class VehiclesModelsData {
  int? id;
  String? name;
  int? manufacturerId;
  String? image;
  // ManufacturerData? manufacturer;

  VehiclesModelsData(
      {this.id, this.name, this.manufacturerId, this.image,/* this.manufacturer*/});

  VehiclesModelsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manufacturerId = json['manufacturer_id'];
    image = json['image'];
    /*manufacturer = json['manufacturer'] != null
        ? ManufacturerData.fromJson(json['manufacturer'])
        : null;*/
  }


}

// class Manufacturer {
//   int? id;
//   String? name;
//   String? image;
//   int? vehicleTypeId;
//   int? subVehicleTypeId;
//   int? isActive;
//
//   Manufacturer(
//       {this.id,
//         this.name,
//         this.image,
//         this.vehicleTypeId,
//         this.subVehicleTypeId,
//         this.isActive});
//
//   Manufacturer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     vehicleTypeId = json['vehicle_type_id'];
//     subVehicleTypeId = json['sub_vehicle_type_id'];
//     isActive = json['is_active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['image'] = image;
//     data['vehicle_type_id'] = vehicleTypeId;
//     data['sub_vehicle_type_id'] = subVehicleTypeId;
//     data['is_active'] = isActive;
//     return data;
//   }
// }

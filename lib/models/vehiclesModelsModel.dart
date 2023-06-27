
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

  VehiclesModelsData(
      {this.id, this.name, this.manufacturerId, this.image,/* this.manufacturer*/});

  VehiclesModelsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manufacturerId = json['manufacturer_id'];
    image = json['image'];

  }


}


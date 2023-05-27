class AddressDetailsModel {
  int? statusCode;
  AddressesData? data;
  String? message;

  AddressDetailsModel({this.statusCode, this.data, this.message});

  AddressDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new AddressesData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}


class AddressesModel {
  int? statusCode;
  List<AddressesData>? data;
  String? message;

  AddressesModel({this.statusCode, this.data, this.message});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <AddressesData>[];
      json['data'].forEach((v) {
        data!.add(AddressesData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class AddressesData {
  int? id;
  String? image;
  String? type;
  dynamic latitude;
  dynamic langitude;
  String? locationName;
  int? customerId;

  AddressesData(
      {this.id,
        this.image,
        this.type,
        this.latitude,
        this.langitude,
        this.locationName,
        this.customerId});

  AddressesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    type = json['type'];
    latitude = json['latitude'];
    langitude = json['langitude'];
    locationName = json['location_name'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    data['type'] = type;
    data['latitude'] = latitude;
    data['langitude'] = langitude;
    data['location_name'] = locationName;
    data['customer_id'] = customerId;
    return data;
  }
}

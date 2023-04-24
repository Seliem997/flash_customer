class StoreAddressModel {
  int? statusCode;
  String? message;
  StoreAddressData? data;

  StoreAddressModel({this.statusCode, this.message, this.data});

  StoreAddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new StoreAddressData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StoreAddressData {
  int? id;
  String? image;
  String? type;
  String? latitude;
  String? langitude;
  String? locationName;
  int? customerId;

  StoreAddressData(
      {this.id,
        this.image,
        this.type,
        this.latitude,
        this.langitude,
        this.locationName,
        this.customerId});

  StoreAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    type = json['type'];
    latitude = json['latitude'];
    langitude = json['langitude'];
    locationName = json['location_name'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['langitude'] = this.langitude;
    data['location_name'] = this.locationName;
    data['customer_id'] = this.customerId;
    return data;
  }
}

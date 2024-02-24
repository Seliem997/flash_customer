class AddressDetailsModel {
  dynamic  statusCode;
  AddressesData? data;
  String? message;

  AddressDetailsModel({this.statusCode, this.data, this.message});

  AddressDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? AddressesData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;

    data['message'] = message;
    return data;
  }
}

class AddressesModel {
  dynamic  statusCode;
  Null? message;
  AddressesModelData? data;

  AddressesModel({this.statusCode, this.message, this.data});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new AddressesModelData.fromJson(json['data']) : null;
  }

}

class AddressesModelData {
  dynamic  total;
  dynamic  perPage;
  dynamic  currentPage;
  dynamic  lastPage;
  List<AddressesData>? addressesData;

  AddressesModelData({this.total, this.perPage, this.currentPage, this.lastPage, this.addressesData});

  AddressesModelData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      addressesData = <AddressesData>[];
      json['data'].forEach((v) {
        addressesData!.add(new AddressesData.fromJson(v));
      });
    }
  }

}

class AddressesData {
  dynamic  id;
  String? image;
  String? typeEn;
  String? type;
  dynamic latitude;
  dynamic langitude;
  String? locationName;
  dynamic customerId;

  AddressesData(
      {this.id,
        this.image,
        this.typeEn,
        this.type,
        this.latitude,
        this.langitude,
        this.locationName,
        this.customerId});

  AddressesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image_path'];
    typeEn = json['type_en'];
    type = json['type'];
    latitude = json['latitude'];
    langitude = json['langitude'];
    locationName = json['location_name'];
    customerId = json['customer_id'];
  }

}


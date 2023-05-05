class VehicleDetailsModel {
  int? statusCode;
  String? message;
  VehicleDetailsData? data;

  VehicleDetailsModel({this.statusCode, this.message, this.data});

  VehicleDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new VehicleDetailsData.fromJson(json['data']) : null;
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

class VehicleDetailsData {
  int? id;
  String? name;
  String? numbers;
  String? letters;
  String? color;
  String? year;
  String? mainImage;
  int? customerId;
  int? manufacturerId;
  String? manufacturerName;
  String? manufacturerLogo;
  int? vehicleModelId;
  String? vehicleModelName;
  String? vehicleTypeId;
  String? vehicleTypeName;
  String? subVehicleTypeId;
  String? subVehicleTypeName;
  Customer? customer;

  VehicleDetailsData(
      {this.id,
        this.name,
        this.numbers,
        this.letters,
        this.color,
        this.year,
        this.mainImage,
        this.customerId,
        this.manufacturerId,
        this.manufacturerName,
        this.manufacturerLogo,
        this.vehicleModelId,
        this.vehicleModelName,
        this.vehicleTypeId,
        this.vehicleTypeName,
        this.subVehicleTypeId,
        this.subVehicleTypeName,
        this.customer});

  VehicleDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numbers = json['numbers'];
    letters = json['letters'];
    color = json['color'];
    year = json['year'];
    mainImage = json['main_image'];
    customerId = json['customer_id'];
    manufacturerId = json['manufacturer_id'];
    manufacturerName = json['manufacturer_name'];
    manufacturerLogo = json['manufacturer_logo'];
    vehicleModelId = json['vehicle_model_id'];
    vehicleModelName = json['vehicle_model_name'];
    vehicleTypeId = json['vehicle_type_id'];
    vehicleTypeName = json['vehicle_type_name'];
    subVehicleTypeId = json['sub_vehicle_type_id'];
    subVehicleTypeName = json['sub_vehicle_type_name'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['numbers'] = this.numbers;
    data['letters'] = this.letters;
    data['color'] = this.color;
    data['year'] = this.year;
    data['main_image'] = this.mainImage;
    data['customer_id'] = this.customerId;
    data['manufacturer_id'] = this.manufacturerId;
    data['manufacturer_name'] = this.manufacturerName;
    data['manufacturer_logo'] = this.manufacturerLogo;
    data['vehicle_model_id'] = this.vehicleModelId;
    data['vehicle_model_name'] = this.vehicleModelName;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['vehicle_type_name'] = this.vehicleTypeName;
    data['sub_vehicle_type_id'] = this.subVehicleTypeId;
    data['sub_vehicle_type_name'] = this.subVehicleTypeName;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? fwId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? image;
  String? balance;

  Customer(
      {this.id,
        this.fwId,
        this.name,
        this.email,
        this.phone,
        this.countryCode,
        this.image,
        this.balance});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    image = json['image'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fw_id'] = this.fwId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['image'] = this.image;
    data['balance'] = this.balance;
    return data;
  }
}

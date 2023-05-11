class RequestDetailsModel {
  int? statusCode;
  String? message;
  RequestDetailsData? data;

  RequestDetailsModel({this.statusCode, this.message, this.data});

  RequestDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null
        ? new RequestDetailsData.fromJson(json['data'])
        : null;
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

class RequestDetailsData {
  int? id;
  String? requestId;
  String? status;
  String? rate;
  String? payBy;
  String? feedback;
  String? amount;
  String? tax;
  num? discountAmount;
  num? totalAmount;
  String? time;
  String? date;
  Employee? employee;
  List<Services>? services;
  Customer? customer;

  RequestDetailsData(
      {this.id,
      this.requestId,
      this.status,
      this.rate,
      this.payBy,
      this.feedback,
      this.amount,
      this.tax,
      this.discountAmount,
      this.totalAmount,
      this.time,
      this.date,
      this.employee,
      this.services,
      this.customer});

  RequestDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    amount = json['amount'];
    tax = json['tax'];
    discountAmount = json['discount_amount'];
    totalAmount = json['total_amount'];
    time = json['time'];
    date = json['date'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['status'] = this.status;
    data['rate'] = this.rate;
    data['pay_by'] = this.payBy;
    data['feedback'] = this.feedback;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['discount_amount'] = this.discountAmount;
    data['total_amount'] = this.totalAmount;
    data['time'] = this.time;
    data['date'] = this.date;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  String? name;

  Employee({this.id, this.name});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Services {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  num? duration;
  bool? countable;

  Services(
      {this.id,
      this.title,
      this.image,
      this.info,
      this.type,
      this.duration,
      this.countable});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
    countable = json['countable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['info'] = this.info;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['countable'] = this.countable;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  List<Vehicle>? vehicle;

  Customer({this.id, this.name, this.vehicle});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicle {
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
  int? vehicleTypeId;
  String? vehicleTypeName;
  int? subVehicleTypeId;
  String? subVehicleTypeName;
  CustomerDetails? customerDetails;

  Vehicle(
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
      this.customerDetails});

  Vehicle.fromJson(Map<String, dynamic> json) {
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
    customerDetails = json['customer_details'] != null
        ? new CustomerDetails.fromJson(json['customer_details'])
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
    if (this.customerDetails != null) {
      data['customer_details'] = this.customerDetails!.toJson();
    }
    return data;
  }
}

class CustomerDetails {
  int? id;
  String? fwId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? image;
  String? balance;

  CustomerDetails(
      {this.id,
      this.fwId,
      this.name,
      this.email,
      this.phone,
      this.countryCode,
      this.image,
      this.balance});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
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

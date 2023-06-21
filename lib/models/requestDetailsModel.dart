class RequestDetailsModel {
  int? statusCode;
  String? message;
  RequestDetailsData? data;

  RequestDetailsModel({this.statusCode, this.message, this.data});

  RequestDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null
        ? RequestDetailsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
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
  dynamic tax;
  dynamic discountAmount;
  dynamic totalAmount;
  String? time;
  String? date;
  Employee? employee;
  List<Services>? services;
  CustomerData? customer;

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
        ? Employee.fromJson(json['employee'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? CustomerData.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['request_id'] = requestId;
    data['status'] = status;
    data['rate'] = rate;
    data['pay_by'] = payBy;
    data['feedback'] = feedback;
    data['amount'] = amount;
    data['tax'] = tax;
    data['discount_amount'] = discountAmount;
    data['total_amount'] = totalAmount;
    data['time'] = time;
    data['date'] = date;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['info'] = info;
    data['type'] = type;
    data['duration'] = duration;
    data['countable'] = countable;
    return data;
  }
}

class CustomerData {
  int? id;
  String? name;
  List<Vehicle>? vehicle;

  CustomerData({this.id, this.name, this.vehicle});

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (vehicle != null) {
      data['vehicle'] = vehicle!.map((v) => v.toJson()).toList();
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
        ? CustomerDetails.fromJson(json['customer_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['numbers'] = numbers;
    data['letters'] = letters;
    data['color'] = color;
    data['year'] = year;
    data['main_image'] = mainImage;
    data['customer_id'] = customerId;
    data['manufacturer_id'] = manufacturerId;
    data['manufacturer_name'] = manufacturerName;
    data['manufacturer_logo'] = manufacturerLogo;
    data['vehicle_model_id'] = vehicleModelId;
    data['vehicle_model_name'] = vehicleModelName;
    data['vehicle_type_id'] = vehicleTypeId;
    data['vehicle_type_name'] = vehicleTypeName;
    data['sub_vehicle_type_id'] = subVehicleTypeId;
    data['sub_vehicle_type_name'] = subVehicleTypeName;
    if (customerDetails != null) {
      data['customer_details'] = customerDetails!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fw_id'] = fwId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['image'] = image;
    data['balance'] = balance;
    return data;
  }
}



class PaymentUrlModel {
  int? statusCode;
  dynamic message;
  PaymentUrlData? data;

  PaymentUrlModel({this.statusCode, this.message, this.data});

  PaymentUrlModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? PaymentUrlData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaymentUrlData {
  String? paymentUrl;

  PaymentUrlData({this.paymentUrl});

  PaymentUrlData.fromJson(Map<String, dynamic> json) {
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_url'] = paymentUrl;
    return data;
  }
}


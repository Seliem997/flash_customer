import 'package:flash_customer/models/rateDetailsModel.dart';

class DetailsRequestModel {
  dynamic  statusCode;
  dynamic message;
  DetailsRequestData? data;

  DetailsRequestModel({this.statusCode, this.message, this.data});

  DetailsRequestModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? DetailsRequestData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DetailsRequestData {
  dynamic  id;
  dynamic requestId;
  String? status;
  dynamic rate;
  String? payBy;
  dynamic feedback;
  dynamic  packageId;
  PackageDetails? packageDetails;
  String? amount;
  dynamic lateTime;
  dynamic actualTime;
  dynamic tax;
  dynamic discountAmount;
  dynamic totalAmount;
  String? totalDuration;
  String? time;
  String? date;
  String? slotsDate;
  CustomerDetails? customer;
  City? city;
  Location? requestAddress;
  Employee? employee;
  List<Services>? services;
  VehicleRequest? vehicleRequest;
  List<Slots>? slots;

  DetailsRequestData(
      {this.id,
        this.requestId,
        this.status,
        this.rate,
        this.payBy,
        this.feedback,
        this.packageId,
        this.packageDetails,
        this.amount,
        this.lateTime,
        this.actualTime,
        this.tax,
        this.discountAmount,
        this.totalAmount,
        this.totalDuration,
        this.time,
        this.date,
        this.slotsDate,
        this.customer,
        this.city,
        this.requestAddress,
        this.employee,
        this.services,
        this.vehicleRequest,
        this.slots});

  DetailsRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    packageId = json['package_id'];
    packageDetails =  json['package_details'] != null
        ? PackageDetails.fromJson(json['package_details'])
        : null;
    amount = json['amount'];
    lateTime = json['late_time'];
    actualTime = json['actual_time'];
    tax = json['tax'];
    discountAmount = json['discount_amount'];
    totalAmount = json['total_amount'];
    totalDuration = json['total_duration'];
    time = json['time'];
    date = json['date'];
    slotsDate = json['slots_date'];
    customer = json['customer'] != null
        ? CustomerDetails.fromJson(json['customer'])
        : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    requestAddress = json['request_address'] != null
        ? Location.fromJson(json['request_address'])
        : null;
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    vehicleRequest = json['vehicleRequest'] != null
        ? VehicleRequest.fromJson(json['vehicleRequest'])
        : null;
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['status'] = this.status;
    data['rate'] = this.rate;
    data['pay_by'] = this.payBy;
    data['feedback'] = this.feedback;
    data['package_id'] = this.packageId;
    data['amount'] = this.amount;
    data['late_time'] = this.lateTime;
    data['actual_time'] = this.actualTime;
    data['tax'] = this.tax;
    data['discount_amount'] = this.discountAmount;
    data['total_amount'] = this.totalAmount;
    data['total_duration'] = this.totalDuration;
    data['time'] = this.time;
    data['date'] = this.date;
    data['slots_date'] = this.slotsDate;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.requestAddress != null) {
      data['request_address'] = this.requestAddress!.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.vehicleRequest != null) {
      data['vehicleRequest'] = this.vehicleRequest!.toJson();
    }

    return data;
  }
}

class PackageDetails {
  dynamic  id;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  dynamic  washingQuantity;
  String? per;
  dynamic  maxRequests;
  dynamic  currentRequest;
  dynamic duration;
  dynamic  vehicleTypeId;
  dynamic  vehicleSubTypeId;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  PackageDetails(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.descriptionEn,
        this.descriptionAr,
        this.washingQuantity,
        this.per,
        this.maxRequests,
        this.currentRequest,
        this.duration,
        this.vehicleTypeId,
        this.vehicleSubTypeId,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  PackageDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    washingQuantity = json['washing_quantity'];
    per = json['per'];
    maxRequests = json['max_requests'];
    currentRequest = json['current_request'];
    duration = json['duration'];
    vehicleTypeId = json['vehicle_type_id'];
    vehicleSubTypeId = json['vehicle_sub_type_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['washing_quantity'] = this.washingQuantity;
    data['per'] = this.per;
    data['max_requests'] = this.maxRequests;
    data['current_request'] = this.currentRequest;
    data['duration'] = this.duration;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['vehicle_sub_type_id'] = this.vehicleSubTypeId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CustomerDetails {
  dynamic  id;
  String? fwid;
  String? phone;
  String? name;
  List<Location>? location;
  List<Vehicle>? vehicle;

  CustomerDetails(
      {this.id, this.fwid, this.phone, this.name, this.location, this.vehicle});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwid = json['fwid'];
    phone = json['phone'];
    name = json['name'];
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(Location.fromJson(v));
      });
    }
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['fwid'] = this.fwid;
    data['phone'] = this.phone;
    data['name'] = this.name;
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  dynamic  id;
  String? image;
  String? type;
  String? latitude;
  String? langitude;
  String? locationName;
  dynamic customerId;

  Location(
      {this.id,
        this.image,
        this.type,
        this.latitude,
        this.langitude,
        this.locationName,
        this.customerId});

  Location.fromJson(Map<String, dynamic> json) {
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

class Vehicle {
  dynamic  id;
  String? name;
  String? numbers;
  String? letters;
  String? color;
  String? year;
  String? mainImage;
  dynamic customerId;
  dynamic  manufacturerId;
  String? manufacturerName;
  String? manufacturerLogo;
  dynamic  vehicleModelId;
  String? vehicleModelName;
  dynamic  vehicleTypeId;
  String? vehicleTypeName;
  dynamic  subVehicleTypeId;
  String? subVehicleTypeName;
  CustomerDetails? customer;

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
        this.customer});

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
    customer = json['customer'] != null
        ? CustomerDetails.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class CustomerDetailsData {
  int? id;
  String? fwId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? image;
  String? balance;

  CustomerDetailsData(
      {this.id,
        this.fwId,
        this.name,
        this.email,
        this.phone,
        this.countryCode,
        this.image,
        this.balance});

  CustomerDetailsData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class City {
  int? id;
  String? name;
  dynamic minAmount;
  dynamic status;

  City({this.id, this.name, this.minAmount, this.status});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minAmount = json['min_amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_amount'] = this.minAmount;
    data['status'] = this.status;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  dynamic duration;
  bool? countable;
  String? requestServicePrice;
  dynamic requestServiceCount;
  String? requestServiceTotalPrice;

  Services(
      {this.id,
        this.title,
        this.image,
        this.info,
        this.type,
        this.duration,
        this.countable,
        this.requestServicePrice,
        this.requestServiceCount,
        this.requestServiceTotalPrice});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
    countable = json['countable'];
    requestServicePrice = json['request_service_price'];
    requestServiceCount = json['request_service_count'];
    requestServiceTotalPrice = json['request_service_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['info'] = this.info;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['countable'] = this.countable;
    data['request_service_price'] = this.requestServicePrice;
    data['request_service_count'] = this.requestServiceCount;
    data['request_service_total_price'] = this.requestServiceTotalPrice;
    return data;
  }
}

class VehicleRequest {
  int? id;
  String? name;
  String? numbers;
  String? letters;
  String? color;
  String? year;
  String? mainImage;
  dynamic customerId;
  dynamic manufacturerId;
  String? manufacturerName;
  String? manufacturerLogo;
  dynamic vehicleModelId;
  String? vehicleModelName;
  dynamic vehicleTypeId;
  String? vehicleTypeName;
  dynamic subVehicleTypeId;
  String? subVehicleTypeName;
  CustomerDetails? customer;

  VehicleRequest(
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

  VehicleRequest.fromJson(Map<String, dynamic> json) {
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
        ? CustomerDetails.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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



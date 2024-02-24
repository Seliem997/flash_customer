class RateDetailsModel {
  dynamic  statusCode;
  String? message;
  RatingData? data;

  RateDetailsModel({this.statusCode, this.message, this.data});

  RateDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new RatingData.fromJson(json['data']) : null;
  }

}

class RatingData {
  dynamic  id;
  String? requestId;
  String? status;
  dynamic rate;
  String? payBy;
  String? feedback;
  dynamic packageId;
  dynamic packageDetails;
  String? amount;
  String? lateTime;
  dynamic actualTime;
  dynamic  tax;
  String? discountAmount;
  String? totalAmount;
  String? totalDuration;
  String? time;
  String? date;
  String? slotsDate;
  Customer? customer;
  City? city;
  Location? requestAddress;
  Employee? employee;
  List<Services>? services;
  List<Null>? servicesOther;
  Vehicle? vehicleRequest;
  List<Slots>? slots;

  RatingData(
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
        this.servicesOther,
        this.vehicleRequest,
        this.slots});

  RatingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    packageId = json['package_id'];
    packageDetails = json['package_details'];
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
        ? new Customer.fromJson(json['customer'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    requestAddress = json['request_address'] != null
        ? new Location.fromJson(json['request_address'])
        : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }

    vehicleRequest = json['vehicleRequest'] != null
        ? new Vehicle.fromJson(json['vehicleRequest'])
        : null;
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
  }

}

class Customer {
  dynamic  id;
  String? fwid;
  String? phone;
  String? image;
  String? name;
  List<Location>? location;
  List<Vehicle>? vehicle;

  Customer(
      {this.id,
        this.fwid,
        this.phone,
        this.image,
        this.name,
        this.location,
        this.vehicle});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwid = json['fwid'];
    phone = json['phone'];
    image = json['image'];
    name = json['name'];
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(new Location.fromJson(v));
      });
    }
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new Vehicle.fromJson(v));
      });
    }
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

}

class Vehicle {
  dynamic  id;
  String? name;
  String? numbers;
  String? letters;
  String? lettersOthers;
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
  Customer? customer;

  Vehicle(
      {this.id,
        this.name,
        this.numbers,
        this.letters,
        this.lettersOthers,
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
    lettersOthers = json['letters_others'];
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

}

class CustomerInfo {
  dynamic  id;
  String? fwId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? image;
  String? balance;

  CustomerInfo(
      {this.id,
        this.fwId,
        this.name,
        this.email,
        this.phone,
        this.countryCode,
        this.image,
        this.balance});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    image = json['image'];
    balance = json['balance'];
  }

}

class City {
  dynamic  id;
  String? name;
  dynamic  minAmount;
  dynamic  status;

  City({this.id, this.name, this.minAmount, this.status});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minAmount = json['min_amount'];
    status = json['status'];
  }

}

class Employee {
  dynamic  id;
  String? name;
  String? image;

  Employee({this.id, this.name, this.image});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}

class Services {
  dynamic  id;
  String? title;
  String? image;
  Null? info;
  String? type;
  dynamic duration;
  bool? countable;
  String? requestServicePrice;
  dynamic  requestServiceCount;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class Slots {
  dynamic  id;
  String? startAt;
  String? endAt;
  dynamic employeeId;
  String? employeeName;
  dynamic shiftId;
  String? status;
  dynamic  gapTime;
  String? date;
  String? createdAt;

  Slots(
      {this.id,
        this.startAt,
        this.endAt,
        this.employeeId,
        this.employeeName,
        this.shiftId,
        this.status,
        this.gapTime,
        this.date,
        this.createdAt});

  Slots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    shiftId = json['shift_id'];
    status = json['status'];
    gapTime = json['gap_time'];
    date = json['date'];
    createdAt = json['created_at'];
  }

}

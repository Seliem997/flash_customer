class MyRequestsModel {
  List<MyRequestsData>? data;
  Links? links;
  Meta? meta;
  int? statusCode;
  Null? message;

  MyRequestsModel(
      {this.data, this.links, this.meta, this.statusCode, this.message});

  MyRequestsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyRequestsData>[];
      json['data'].forEach((v) {
        data!.add(new MyRequestsData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class MyRequestsData {
  int? id;
  String? requestId;
  String? status;
  dynamic rate;
  String? payBy;
  dynamic feedback;
  dynamic packageId;
  String? amount;
  dynamic lateTime;
  dynamic actualTime;
  dynamic tax;
  dynamic discountAmount;
  dynamic totalAmount;
  dynamic totalDuration;
  String? time;
  String? date;
  String? slotsDate;
  Customer? customer;
  City? city;
  Location? requestAddress;
  Employee? employee;
  List<Services>? services;
  VehicleRequest? vehicleRequest;

  MyRequestsData(
      {this.id,
        this.requestId,
        this.status,
        this.rate,
        this.payBy,
        this.feedback,
        this.packageId,
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
        });

  MyRequestsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    packageId = json['package_id'];
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
        ? new VehicleRequest.fromJson(json['vehicleRequest'])
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
class Customer {
  int? id;
  String? fwid;
  String? phone;
  String? name;
  List<Location>? location;
  List<Vehicle>? vehicle;

  Customer(
      {this.id, this.fwid, this.phone, this.name, this.location, this.vehicle});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwid = json['fwid'];
    phone = json['phone'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  int? id;
  String? image;
  String? type;
  String? latitude;
  String? langitude;
  String? locationName;
  int? customerId;

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
  Customer? customer;

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

class City {
  int? id;
  String? name;
  int? minAmount;
  int? status;

  City({this.id, this.name, this.minAmount, this.status});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minAmount = json['min_amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  int? duration;
  bool? countable;
  String? requestServicePrice;
  int? requestServiceCount;
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

class VehicleRequest {
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
  Customer? customer;

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

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class LinksUrl {
  String? url;
  String? label;
  bool? active;

  LinksUrl({this.url, this.label, this.active});

  LinksUrl.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

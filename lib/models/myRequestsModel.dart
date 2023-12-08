import 'package:flash_customer/models/rateDetailsModel.dart';
import 'package:flash_customer/models/request_details_model.dart';

import 'addressesModel.dart';
import 'myVehiclesModel.dart';

class MyRequestsModel {
  List<MyRequestsData>? data;
  Links? links;
  Meta? meta;
  int? statusCode;
  dynamic message;

  MyRequestsModel(
      {this.data, this.links, this.meta, this.statusCode, this.message});

  MyRequestsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyRequestsData>[];
      json['data'].forEach((v) {
        data!.add(MyRequestsData.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    statusCode = json['status_code'];
    message = json['message'];
  }

}

class MyRequestsData {
  int? id;
  String? requestId;
  String? status;
  String? statusArabic;
  int? washNumber;
  dynamic rate;
  String? payBy;
  dynamic feedback;
  dynamic packageId;
  PackageDetails? packageDetails;
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
  AddressesData? requestAddress;
  Employee? employee;
  List<Services>? services;
  VehicleRequest? vehicleRequest;
  List<Slots>? slots;
  MyRequestsData(
      {this.id,
        this.requestId,
        this.status,
        this.statusArabic,
        this.rate,
        this.washNumber,
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
        this.slots
        });

  MyRequestsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    statusArabic = json['status_lang'];
    washNumber = json['wash_number'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    packageId = json['package_id'];
    packageDetails = json['package_details'] != null
        ? new PackageDetails.fromJson(json['package_details'])
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
        ? Customer.fromJson(json['customer'])
        : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    requestAddress = json['request_address'] != null
        ? AddressesData.fromJson(json['request_address'])
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
        slots!.add(new Slots.fromJson(v));
      });
    }
  }

}
class Customer {
  int? id;
  String? fwid;
  String? phone;
  String? name;
  List<AddressesData>? location;
  List<MyVehiclesCollection>? vehicle;

  Customer(
      {this.id, this.fwid, this.phone, this.name, this.location, this.vehicle});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwid = json['fwid'];
    phone = json['phone'];
    name = json['name'];
    if (json['location'] != null) {
      location = <AddressesData>[];
      json['location'].forEach((v) {
        location!.add(AddressesData.fromJson(v));
      });
    }
    if (json['vehicle'] != null) {
      vehicle = <MyVehiclesCollection>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(MyVehiclesCollection.fromJson(v));
      });
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['min_amount'] = minAmount;
    data['status'] = status;
    return data;
  }
}

class Employee {
  int? id;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['info'] = info;
    data['type'] = type;
    data['duration'] = duration;
    data['countable'] = countable;
    data['request_service_price'] = requestServicePrice;
    data['request_service_count'] = requestServiceCount;
    data['request_service_total_price'] = requestServiceTotalPrice;
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
        ? Customer.fromJson(json['customer'])
        : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
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
        links!.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

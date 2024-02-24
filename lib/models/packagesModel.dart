class PackagesModel {
  dynamic  statusCode;
  dynamic message;
  List<PackagesData>? data;

  PackagesModel({this.statusCode, this.message, this.data});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PackagesData>[];
      json['data'].forEach((v) {
        data!.add(PackagesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackagesData {
  dynamic  id;
  String? name;
  String? description;
  dynamic  washingQuantity;
  String? per;
  dynamic  maxRequests;
  dynamic duration;
  String? vehicleType;
  String? vehicleSubType;
  bool? isActive;
  String? selectedPrice;
  List<Cities>? cities;

  PackagesData(
      {this.id,
        this.name,
        this.description,
        this.washingQuantity,
        this.per,
        this.maxRequests,
        this.duration,
        this.vehicleType,
        this.vehicleSubType,
        this.isActive,
        this.selectedPrice,
        this.cities});

  PackagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    washingQuantity = json['washing_quantity'];
    per = json['per'];
    maxRequests = json['max_requests'];
    duration = json['duration'];
    vehicleType = json['vehicle_type'];
    vehicleSubType = json['vehicle_sub_type'];
    isActive = json['is_active'];
    selectedPrice = json['selected_price'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['washing_quantity'] = washingQuantity;
    data['per'] = per;
    data['max_requests'] = maxRequests;
    data['duration'] = duration;
    data['vehicle_type'] = vehicleType;
    data['vehicle_sub_type'] = vehicleSubType;
    data['is_active'] = isActive;
    data['selected_price'] = selectedPrice;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  dynamic  id;
  String? name;
  dynamic  minAmount;
  dynamic  status;
  String? price;

  Cities({this.id, this.name, this.minAmount, this.status, this.price});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minAmount = json['min_amount'];
    status = json['status'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['min_amount'] = minAmount;
    data['status'] = status;
    data['price'] = price;
    return data;
  }
}

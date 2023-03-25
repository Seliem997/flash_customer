class MyVehiclesModel {
  int? statusCode;
  MyVehiclesData? data;
  String? message;

  MyVehiclesModel({this.statusCode, this.data, this.message});

  MyVehiclesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? MyVehiclesData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class MyVehiclesData {
  List<MyVehiclesCollection>? collection;
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  MyVehiclesData(
      {this.collection,
        this.currentPage,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  MyVehiclesData.fromJson(Map<String, dynamic> json) {
    if (json['collection'] != null) {
      collection = <MyVehiclesCollection>[];
      json['collection'].forEach((v) {
        collection!.add(MyVehiclesCollection.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = currentPage;
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class MyVehiclesCollection {
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
  Customer? customer;

  MyVehiclesCollection(
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
        this.customer});

  MyVehiclesCollection.fromJson(Map<String, dynamic> json) {
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
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
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
    if (customer != null) {
      data['customer'] = customer!.toJson();
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

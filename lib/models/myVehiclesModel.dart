class MyVehiclesModel {
  dynamic  statusCode;
  MyVehiclesData? data;
  String? message;

  MyVehiclesModel({this.statusCode, this.data, this.message});

  MyVehiclesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? MyVehiclesData.fromJson(json['data']) : null;
    message = json['message'];
  }

}

class MyVehiclesData {
  List<MyVehiclesCollection>? collection;
  dynamic  currentPage;
  String? firstPageUrl;
  dynamic  from;
  dynamic  lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  dynamic  perPage;
  String? prevPageUrl;
  dynamic  to;
  dynamic  total;

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

}

class MyVehiclesCollection {
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
  CustomerDetailsData? customer;

  MyVehiclesCollection(
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

  MyVehiclesCollection.fromJson(Map<String, dynamic> json) {
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
        ? CustomerDetailsData.fromJson(json['customer'])
        : null;
  }

}

class CustomerDetailsData {
  dynamic  id;
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

}

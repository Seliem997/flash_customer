class ServicesModel {
  int? statusCode;
  String? message;
  List<ServiceData>? data;

  ServicesModel({this.statusCode, this.message, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(ServiceData.fromJson(v));
      });
    }
  }
}

class ServiceData {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  String? testAttribute;
  int? duration;
  bool? countable;
  bool isSelected = false;
  int quantity = 0;
  String? selectedPrice;
  List<ServicePrices>? servicePrices;


  ServiceData(
      {this.id,
        this.title,
        this.image,
        this.info,
        this.type,
        this.testAttribute,
        this.duration,
        this.countable,
        this.selectedPrice,
        this.servicePrices,
       });

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    testAttribute = json['test_attribute'];
    duration = json['duration'];
    countable = json['countable'];
    selectedPrice = json['selected_price'];
    if (json['service_prices'] != null) {
      servicePrices = <ServicePrices>[];
      json['service_prices'].forEach((v) {
        servicePrices!.add(new ServicePrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['info'] = this.info;
    data['type'] = this.type;
    data['test_attribute'] = this.testAttribute;
    data['duration'] = this.duration;
    data['countable'] = this.countable;
    data['selected_price'] = this.selectedPrice;
    if (this.servicePrices != null) {
      data['service_prices'] =
          this.servicePrices!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ServicePrices {
  int? id;
  String? name;
  Price? price;

  ServicePrices({this.id, this.name, this.price});

  ServicePrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class Price {
  String? value;
  String? unit;
  int? vehicleType;
  int? vehicleSubType;

  Price({this.value, this.unit, this.vehicleType, this.vehicleSubType});

  Price.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
    vehicleType = json['vehicle_type'];
    vehicleSubType = json['vehicle_sub_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_sub_type'] = this.vehicleSubType;
    return data;
  }
}



class ExtraServicesItem {
  int extraServiceId;
  int extraServiceCount;
  ExtraServicesItem(this.extraServiceId, this.extraServiceCount);

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['extra_service_id'] = extraServiceId;
    data['extra_service_count'] = extraServiceCount;
    return data;
}
}
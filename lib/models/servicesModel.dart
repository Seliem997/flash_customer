
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
  dynamic duration;
  bool? countable;
  bool isSelected = false;
  int quantity = 0;
  dynamic selectedPrice;
  dynamic selectedPriceNoTax;
  num? tax;
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
        this.selectedPriceNoTax,
        this.tax,
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
    selectedPriceNoTax = json['selected_price_no_tax'];
    tax = json['tax'];
    if (json['service_prices'] != null) {
      servicePrices = <ServicePrices>[];
      json['service_prices'].forEach((v) {
        servicePrices!.add(ServicePrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['info'] = info;
    data['type'] = type;
    data['test_attribute'] = testAttribute;
    data['duration'] = duration;
    data['countable'] = countable;
    data['selected_price'] = selectedPrice;
    data['selected_price_no_tax'] = selectedPriceNoTax;
    data['tax'] = tax;
    if (servicePrices != null) {
      data['service_prices'] =
          servicePrices!.map((v) => v.toJson()).toList();
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
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class Price {
  dynamic value;
  String? unit;
  dynamic vehicleType;
  dynamic vehicleSubType;

  Price({this.value, this.unit, this.vehicleType, this.vehicleSubType});

  Price.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
    vehicleType = json['vehicle_type'];
    vehicleSubType = json['vehicle_sub_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    data['vehicle_type'] = vehicleType;
    data['vehicle_sub_type'] = vehicleSubType;
    return data;
  }
}



class ExtraServicesItem {
  dynamic extraServiceId;
  dynamic extraServiceCount;
  ExtraServicesItem(this.extraServiceId, this.extraServiceCount);

  Map<String, dynamic> toJson (){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['extra_service_id'] = extraServiceId;
    data['extra_service_count'] = extraServiceCount;
    return data;
}

}
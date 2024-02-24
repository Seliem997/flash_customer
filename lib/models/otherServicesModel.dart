class OtherServicesModel {
  dynamic  statusCode;
  Null? message;
  List<OtherServicesData>? data;

  OtherServicesModel({this.statusCode, this.message, this.data});

  OtherServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OtherServicesData>[];
      json['data'].forEach((v) {
        data!.add(new OtherServicesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OtherServicesData {
  dynamic  id;
  String? title;
  String? image;
  String? info;
  String? type;
  String? costType;
  String? testAttribute;
  dynamic duration;
  bool? countable;
  String? selectedPrice;
  int quantity = 0;
  List<ServicePrices>? servicePrices;
  List<ChildServices>? childServices;

  OtherServicesData(
      {this.id,
        this.title,
        this.image,
        this.info,
        this.type,
        this.costType,
        this.testAttribute,
        this.duration,
        this.countable,
        this.selectedPrice,
        this.servicePrices,
        this.childServices});

  OtherServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    costType = json['cost_type'];
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
    if (json['child_services'] != null) {
      childServices = <ChildServices>[];
      json['child_services'].forEach((v) {
        childServices!.add(new ChildServices.fromJson(v));
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
    data['cost_type'] = this.costType;
    data['test_attribute'] = this.testAttribute;
    data['duration'] = this.duration;
    data['countable'] = this.countable;
    data['selected_price'] = this.selectedPrice;
    if (this.servicePrices != null) {
      data['service_prices'] =
          this.servicePrices!.map((v) => v.toJson()).toList();
    }
    if (this.childServices != null) {
      data['child_services'] =
          this.childServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicePrices {
  dynamic  id;
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
  dynamic  vehicleType;
  dynamic  vehicleSubType;

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

class ChildServices {
  dynamic  id;
  String? title;
  String? image;
  Null? info;
  String? type;
  String? costType;
  Null? testAttribute;
  dynamic duration;
  bool? countable;
  String? selectedPrice;
  List<ServicePrices>? servicePrices;

  ChildServices(
      {this.id,
        this.title,
        this.image,
        this.info,
        this.type,
        this.costType,
        this.testAttribute,
        this.duration,
        this.countable,
        this.selectedPrice,
        this.servicePrices,
        });

  ChildServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    costType = json['cost_type'];
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
    data['cost_type'] = this.costType;
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

// class Price {
//   String? value;
//   String? unit;
//   Null? vehicleType;
//   Null? vehicleSubType;
//
//   Price({this.value, this.unit, this.vehicleType, this.vehicleSubType});
//
//   Price.fromJson(Map<String, dynamic> json) {
//     value = json['value'];
//     unit = json['unit'];
//     vehicleType = json['vehicle_type'];
//     vehicleSubType = json['vehicle_sub_type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['value'] = this.value;
//     data['unit'] = this.unit;
//     data['vehicle_type'] = this.vehicleType;
//     data['vehicle_sub_type'] = this.vehicleSubType;
//     return data;
//   }
// }

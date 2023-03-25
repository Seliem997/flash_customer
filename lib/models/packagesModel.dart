class PackagesModel {
  List<PackagesData>? data;
  Links? links;
  Meta? meta;

  PackagesModel({this.data, this.links, this.meta});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PackagesData>[];
      json['data'].forEach((v) {
        data!.add(new PackagesData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
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
    return data;
  }
}

class PackagesData {
  int? id;
  String? name;
  Null? description;
  int? washingQuantity;
  String? per;
  int? maxRequests;
  String? vehicleType;
  String? vehicleSubType;
  bool? isActive;
  List<Cities>? cities;

  PackagesData(
      {this.id,
        this.name,
        this.description,
        this.washingQuantity,
        this.per,
        this.maxRequests,
        this.vehicleType,
        this.vehicleSubType,
        this.isActive,
        this.cities});

  PackagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    washingQuantity = json['washing_quantity'];
    per = json['per'];
    maxRequests = json['max_requests'];
    vehicleType = json['vehicle_type'];
    vehicleSubType = json['vehicle_sub_type'];
    isActive = json['is_active'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['washing_quantity'] = this.washingQuantity;
    data['per'] = this.per;
    data['max_requests'] = this.maxRequests;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_sub_type'] = this.vehicleSubType;
    data['is_active'] = this.isActive;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? name;
  int? minAmount;
  int? status;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['min_amount'] = this.minAmount;
    data['status'] = this.status;
    data['price'] = this.price;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  Null? prev;
  Null? next;

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

class PackageLinks {
  String? url;
  String? label;
  bool? active;

  PackageLinks({this.url, this.label, this.active});

  PackageLinks.fromJson(Map<String, dynamic> json) {
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

class PackagesModel {
  List<PackagesData>? data;
  Links? links;
  Meta? meta;

  PackagesModel({this.data, this.links, this.meta});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PackagesData>[];
      json['data'].forEach((v) {
        data!.add(PackagesData.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class PackagesData {
  int? id;
  String? name;
  String? description;
  int? washingQuantity;
  String? per;
  int? maxRequests;
  int? duration;
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
        this.duration,
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
    duration = json['duration'];
    vehicleType = json['vehicle_type'];
    vehicleSubType = json['vehicle_sub_type'];
    isActive = json['is_active'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['min_amount'] = minAmount;
    data['status'] = status;
    data['price'] = price;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

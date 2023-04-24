class CityIdModel {
  int? statusCode;
  String? message;
  CityIdData? data;

  CityIdModel({this.statusCode, this.message, this.data});

  CityIdModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? CityIdData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CityIdData {
  int? id;
  String? name;
  int? minAmount;
  int? status;

  CityIdData({this.id, this.name, this.minAmount, this.status});

  CityIdData.fromJson(Map<String, dynamic> json) {
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

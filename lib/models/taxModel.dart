class TaxModel {
  int? statusCode;
  String? message;
  TaxData? data;

  TaxModel({this.statusCode, this.message, this.data});

  TaxModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new TaxData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TaxData {
  int? id;
  String? name;
  String? percent;
  int? isActive;

  TaxData({this.id, this.name, this.percent, this.isActive});

  TaxData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percent = json['percent'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['percent'] = this.percent;
    data['is_active'] = this.isActive;
    return data;
  }
}

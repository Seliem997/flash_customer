class OfferCouponModel {
  int? statusCode;
  String? message;
  CouponData? data;

  OfferCouponModel({this.statusCode, this.message, this.data});

  OfferCouponModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? CouponData.fromJson(json['data']) : null;
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

class CouponData {
  int? id;
  String? name;
  String? code;
  String? type;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  num? discountAmount;
  int? isActive;

  CouponData(
      {this.id,
      this.name,
      this.code,
      this.type,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.discountAmount,
      this.isActive});

  CouponData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    discountAmount = json['discount_amount'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['type'] = type;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_date'] = endDate;
    data['end_time'] = endTime;
    data['discount_amount'] = discountAmount;
    data['is_active'] = isActive;
    return data;
  }
}

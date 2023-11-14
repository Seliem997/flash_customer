class BookServicesModel {
  int? statusCode;
  String? message;
  BookServicesData? data;

  BookServicesModel({this.statusCode, this.message, this.data});

  BookServicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new BookServicesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;

    return data;
  }
}

class BookServicesData {
  int? id;
  String? requestId;
  String? status;
  String? rate;
  String? payBy;
  String? feedback;
  String? amount;
  dynamic tax;
  String? discountAmount;
  String? totalAmount;
  String? time;
  String? date;
  String? employee;
  List<Services>? services;

  BookServicesData(
      {this.id,
        this.requestId,
        this.status,
        this.rate,
        this.payBy,
        this.feedback,
        this.amount,
        this.tax,
        this.discountAmount,
        this.totalAmount,
        this.time,
        this.date,
        this.employee,
        this.services});

  BookServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    status = json['status'];
    rate = json['rate'];
    payBy = json['pay_by'];
    feedback = json['feedback'];
    amount = json['amount'];
    tax = json['tax'];
    discountAmount = json['discount_amount'];
    totalAmount = json['total_amount'];
    time = json['time'];
    date = json['date'];
    employee = json['employee'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

}

class Services {
  int? id;
  String? title;
  String? image;
  String? info;
  String? type;
  int? duration;
  bool? countable;

  Services(
      {this.id,
        this.title,
        this.image,
        this.info,
        this.type,
        this.duration,
        this.countable});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    info = json['info'];
    type = json['type'];
    duration = json['duration'];
    countable = json['countable'];
  }

}

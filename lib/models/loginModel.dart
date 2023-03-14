class LoginModel {
  int? statusCode;
  Data? data;
  Null? message;

  LoginModel({this.statusCode, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? token;
  UserData? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? fwId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? image;
  List<Duties>? duties;

  UserData(
      {this.id,
        this.fwId,
        this.name,
        this.email,
        this.phone,
        this.countryCode,
        this.image,
        this.duties});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    image = json['image'];
    if (json['duties'] != null) {
      duties = <Duties>[];
      json['duties'].forEach((v) {
        duties!.add(new Duties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fw_id'] = this.fwId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['image'] = this.image;
    if (this.duties != null) {
      data['duties'] = this.duties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Duties {
  int? id;
  String? day;
  String? shift;
  String? startAt;
  String? endAt;
  int? employeeId;
  Null? createdAt;
  Null? updatedAt;

  Duties(
      {this.id,
        this.day,
        this.shift,
        this.startAt,
        this.endAt,
        this.employeeId,
        this.createdAt,
        this.updatedAt});

  Duties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    shift = json['shift'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['shift'] = this.shift;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['employee_id'] = this.employeeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

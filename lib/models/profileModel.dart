import 'package:flash_customer/models/loginModel.dart';

class ProfileModel {
  int? statusCode;
  UserData? data;
  Null? message;

  ProfileModel({this.statusCode, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

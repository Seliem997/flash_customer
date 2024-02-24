import 'package:flash_customer/models/addressesModel.dart';

class StoreAddressModel {
  dynamic  statusCode;
  String? message;
  AddressesData? data;

  StoreAddressModel({this.statusCode, this.message, this.data});

  StoreAddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? AddressesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;

    return data;
  }
}


class BankAccountsModel {
  int? statusCode;
  dynamic message;
  List<BankAccountsData>? data;

  BankAccountsModel({this.statusCode, this.message, this.data});

  BankAccountsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BankAccountsData>[];
      json['data'].forEach((v) {
        data!.add(BankAccountsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankAccountsData {
  int? id;
  String? bankName;
  String? accountHolder;
  String? accountNumber;
  String? ibanNumber;
  String? image;
  int? isActive;

  BankAccountsData(
      {this.id,
        this.bankName,
        this.accountHolder,
        this.accountNumber,
        this.ibanNumber,
        this.image,
        this.isActive});

  BankAccountsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    accountHolder = json['account_holder'];
    accountNumber = json['account_number'];
    ibanNumber = json['iban_number'];
    image = json['image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank_name'] = bankName;
    data['account_holder'] = accountHolder;
    data['account_number'] = accountNumber;
    data['iban_number'] = ibanNumber;
    data['image'] = image;
    data['is_active'] = isActive;
    return data;
  }
}

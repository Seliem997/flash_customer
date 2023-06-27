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


class BankTransferModel {
  int? statusCode;
  String? message;
  BankTransferData? data;

  BankTransferModel({this.statusCode, this.message, this.data});

  BankTransferModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new BankTransferData.fromJson(json['data']) : null;
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

class BankTransferData {
  String? image;
  String? bankAccountId;
  int? requestId;
  int? customerId;
  String? amount;
  String? by;
  String? status;
  String? date;
  String? time;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? imagePath;

  BankTransferData(
      {this.image,
        this.bankAccountId,
        this.requestId,
        this.customerId,
        this.amount,
        this.by,
        this.status,
        this.date,
        this.time,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.imagePath});

  BankTransferData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    bankAccountId = json['bank_account_id'];
    requestId = json['request_id'];
    customerId = json['customer_id'];
    amount = json['amount'];
    by = json['by'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['bank_account_id'] = this.bankAccountId;
    data['request_id'] = this.requestId;
    data['customer_id'] = this.customerId;
    data['amount'] = this.amount;
    data['by'] = this.by;
    data['status'] = this.status;
    data['date'] = this.date;
    data['time'] = this.time;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    return data;
  }
}

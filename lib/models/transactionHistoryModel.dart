class TransactionHistoryModel {
  int? statusCode;
  TransactionData? data;
  String? message;

  TransactionHistoryModel({this.statusCode, this.data, this.message});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? TransactionData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class TransactionData {
  List<TransactionCollection>? collection;
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  TransactionData(
      {this.collection,
        this.currentPage,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  TransactionData.fromJson(Map<String, dynamic> json) {
    if (json['collection'] != null) {
      collection = <TransactionCollection>[];
      json['collection'].forEach((v) {
        collection!.add(TransactionCollection.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = currentPage;
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class TransactionCollection {
  int? id;
  String? type;
  String? amount;
  String? createdAt;

  TransactionCollection({this.id, this.type, this.amount, this.createdAt});

  TransactionCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ChargeWalletModel {
  int? statusCode;
  dynamic message;
  ChargeWalletUrl? data;

  ChargeWalletModel({this.statusCode, this.message, this.data});

  ChargeWalletModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new ChargeWalletUrl.fromJson(json['data']) : null;
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

class ChargeWalletUrl {
  String? chargeUrl;

  ChargeWalletUrl({this.chargeUrl});

  ChargeWalletUrl.fromJson(Map<String, dynamic> json) {
    chargeUrl = json['charge_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charge_url'] = this.chargeUrl;
    return data;
  }
}

class RechargeWalletModel {
  int? statusCode;
  String? message;
  RechargeWalletData? data;

  RechargeWalletModel({this.statusCode, this.message, this.data});

  RechargeWalletModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new RechargeWalletData.fromJson(json['data']) : null;
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

class RechargeWalletData {
  String? chargeType;
  String? customerId;
  int? newBalance;

  RechargeWalletData({this.chargeType, this.customerId, this.newBalance});

  RechargeWalletData.fromJson(Map<String, dynamic> json) {
    chargeType = json['charge_type'];
    customerId = json['customer_id'];
    newBalance = json['new_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charge_type'] = this.chargeType;
    data['customer_id'] = this.customerId;
    data['new_balance'] = this.newBalance;
    return data;
  }
}

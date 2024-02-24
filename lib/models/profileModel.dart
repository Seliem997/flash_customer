class UpdateProfileModel {
  dynamic  statusCode;
  ProfileData? data;
  String? message;

  UpdateProfileModel({this.statusCode, this.data, this.message});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  dynamic  id;
  String? fwId;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? image;
  String? balance;

  ProfileData(
      {this.id,
        this.fwId,
        this.name,
        this.email,
        this.phone,
        this.countryCode,
        this.image,
        this.balance});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fwId = json['fw_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    image = json['image'];
    balance = json['balance'];
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
    data['balance'] = this.balance;
    return data;
  }
}

class LoginProfileModel {
  dynamic  statusCode;
  String? message;
  ProfileLoginData? data;

  LoginProfileModel({this.statusCode, this.message, this.data});

  LoginProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new ProfileLoginData.fromJson(json['data']) : null;
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

class ProfileLoginData {
  String? token;
  ProfileData? users;

  ProfileLoginData({this.token, this.users});

  ProfileLoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    users = json['users'] != null ? new ProfileData.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

// class ProfileData {
//   dynamic  id;
//   String? fwId;
//   String? name;
//   String? email;
//   String? phone;
//   String? countryCode;
//   String? image;
//   String? balance;
//
//
//   ProfileData(
//       {this.id,
//         this.fwId,
//         this.name,
//         this.email,
//         this.phone,
//         this.countryCode,
//         this.image,
//         this.balance});
//
//   ProfileData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fwId = json['fw_id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     countryCode = json['country_code'];
//     image = json['image'];
//     balance = json['balance'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['fw_id'] = this.fwId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['country_code'] = this.countryCode;
//     data['image'] = this.image;
//     data['balance'] = this.balance;
//     return data;
//   }
// }


class SocialLinksModel {
  dynamic  statusCode;
  Null? message;
  SocialLinksData? data;

  SocialLinksModel({this.statusCode, this.message, this.data});

  SocialLinksModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new SocialLinksData.fromJson(json['data']) : null;
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

class SocialLinksData {
  dynamic  id;
  String? facebook;
  String? instagram;
  String? twitter;
  String? tiktok;
  String? snapchat;
  String? telegram;
  String? gmail;
  String? whatsapp;
  String? website;
  String? appAndroid;
  String? appIos;
  String? appOther;
  dynamic phone0;
  dynamic phone1;
  dynamic phone2;
  String? createdAt;
  String? updatedAt;

  SocialLinksData(
      {this.id,
        this.facebook,
        this.instagram,
        this.twitter,
        this.tiktok,
        this.snapchat,
        this.telegram,
        this.gmail,
        this.whatsapp,
        this.website,
        this.appAndroid,
        this.appIos,
        this.appOther,
        this.phone0,
        this.phone1,
        this.phone2,
        this.createdAt,
        this.updatedAt});

  SocialLinksData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    tiktok = json['tiktok'];
    snapchat = json['snapchat'];
    telegram = json['telegram'];
    gmail = json['gmail'];
    whatsapp = json['whatsapp'];
    website = json['website'];
    appAndroid = json['app_android'];
    appIos = json['app_ios'];
    appOther = json['app_other'];
    phone0 = json['phone0'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['tiktok'] = this.tiktok;
    data['snapchat'] = this.snapchat;
    data['telegram'] = this.telegram;
    data['gmail'] = this.gmail;
    data['whatsapp'] = this.whatsapp;
    data['website'] = this.website;
    data['app_android'] = this.appAndroid;
    data['app_ios'] = this.appIos;
    data['app_other'] = this.appOther;
    data['phone0'] = this.phone0;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

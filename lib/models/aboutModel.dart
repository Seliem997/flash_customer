class AboutModel {
  dynamic  statusCode;
  List<AboutData>? data;
  Null? message;

  AboutModel({this.statusCode, this.data, this.message});

  AboutModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <AboutData>[];
      json['data'].forEach((v) {
        data!.add(AboutData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class AboutData {
  dynamic  id;
  String? title;
  String? description;

  AboutData({this.id, this.title, this.description});

  AboutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class AboutImagesModel {
  dynamic  statusCode;
  List<AboutImagesData>? data;
  String? message;

  AboutImagesModel({this.statusCode, this.data, this.message});

  AboutImagesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <AboutImagesData>[];
      json['data'].forEach((v) {
        data!.add(AboutImagesData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class AboutImagesData {
  dynamic  id;
  String? title;
  String? description;
  String? image;
  String? relatedTo;

  AboutImagesData({this.id, this.title, this.description, this.image, this.relatedTo});

  AboutImagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    relatedTo = json['related_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['related_to'] = relatedTo;
    return data;
  }
}

class SlotsModel {
  dynamic  statusCode;
  Null? message;
  List<List<SlotData>>? data;

  SlotsModel({this.statusCode, this.message, this.data});

  SlotsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        final List<SlotData> innerList = [];
        v.forEach((b) {
          innerList.add(SlotData.fromJson(b));
        });
        data!.add(innerList);
      });
    }
  }
}

class SlotData {
  dynamic  id;
  String? startAt;
  String? endAt;
  dynamic employeeId;
  dynamic shiftId;
  String? status;
  dynamic  gapTime;

  SlotData(
      {this.id,
      this.startAt,
      this.endAt,
      this.employeeId,
      this.shiftId,
      this.status,
      this.gapTime});

  SlotData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    employeeId = json['employee_id'];
    shiftId = json['shift_id'];
    status = json['status'];
    gapTime = json['gap_time'];
  }
}

class EmployeeDetailsModel {
  dynamic  statusCode;
  String? message;
  EmployeeDetailsData? data;

  EmployeeDetailsModel({this.statusCode, this.message, this.data});

  EmployeeDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? EmployeeDetailsData.fromJson(json['data']) : null;
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

class EmployeeDetailsData {
  dynamic  id;
  String? name;

  EmployeeDetailsData({this.id, this.name});

  EmployeeDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

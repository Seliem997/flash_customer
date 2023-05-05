class SlotsModel {
  int? statusCode;
  Null? message;
  List<List<SlotData>>? data;

  SlotsModel({this.statusCode, this.message, this.data});

  SlotsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [<SlotData>[]];
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
  int? id;
  String? startAt;
  String? endAt;
  int? employeeId;
  int? shiftId;
  String? status;
  int? gapTime;

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

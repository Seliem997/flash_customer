import '../utils/enum/statuses.dart';

class ResponseResult {
  Status status;
  dynamic data;
  dynamic message;
  ResponseResult(this.status, this.data,{this.message});
}

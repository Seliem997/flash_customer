import '../utils/enum/statuses.dart';

class ResponseResult {
  Status status;
  dynamic data;
  ResponseResult(this.status, this.data);
}

import 'package:flutter/cupertino.dart';

import '../models/loginModel.dart';

class UserProvider extends ChangeNotifier {
  String? userName;
  String? userImage;
  String? phone;
  String? email;

  List<String> otp = ['', '', '', '', '', ''];

  String otpToString() {
    String otpString = '';
    for (var element in otp) {
      otpString += element;
    }
    return otpString;
  }
}

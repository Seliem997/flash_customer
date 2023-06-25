import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/aboutModel.dart';
import '../models/profileModel.dart';
import '../models/requestResult.dart';
import '../services/about_service.dart';
import '../services/authentication_service.dart';
import '../utils/enum/statuses.dart';

class AboutProvider with ChangeNotifier{
  AboutService otherServicesService = AboutService();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController messageController = TextEditingController(text: '');

  double currentDotsIndex = 0;

  List<AboutData> aboutDataList = [];
  Future getAbout() async {
    await otherServicesService.getAbout().then((value) {
      if (value.status == Status.success) {
        aboutDataList = value.data;
      }
    });
    notifyListeners();
  }

  SocialLinksModel? socialLinksData;
  Future getSocialLinks() async {
    AuthenticationService authenticationService = AuthenticationService();
    await authenticationService.getSocialLinks().then((value) {
      if (value.status == Status.success) {
        socialLinksData = value.data;
      }
    });
    notifyListeners();
  }

  List<AboutImagesData> aboutImagesDataList = [];
  Future getAboutImages() async {
    await otherServicesService.getAboutImages().then((value) {
      if (value.status == Status.success) {
        aboutImagesDataList = value.data;
      }
    });
    notifyListeners();
  }

  Future<ResponseResult> contactUs() async {
    Status state = Status.error;
    dynamic responseMessage;
    await otherServicesService.contactUs(phoneNumber: phoneController.text, message: messageController.text, name: nameController.text, email: emailController.text,)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        responseMessage = value.message;
      } else {
        responseMessage = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, '', message: responseMessage);
  }

  void setCurrentDotsIndex(double index) {
    currentDotsIndex = index;
    notifyListeners();
  }

  //----------------------- making phone Call--------------------
  makingPhoneCall({required String phoneNum}) async {
    var url = Uri.parse("tel:$phoneNum");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void resetFields(){

    nameController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    phoneController = TextEditingController(text: '');
    messageController = TextEditingController(text: '');
    notifyListeners();
  }

}
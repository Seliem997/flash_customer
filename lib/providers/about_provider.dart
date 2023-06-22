import 'package:flutter/material.dart';

import '../models/aboutModel.dart';
import '../models/profileModel.dart';
import '../services/about_service.dart';
import '../services/authentication_service.dart';
import '../utils/enum/statuses.dart';

class AboutProvider with ChangeNotifier{

  List<AboutData> aboutDataList = [];
  Future getAbout() async {
    AboutService otherServicesService = AboutService();
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
    AboutService otherServicesService = AboutService();
    await otherServicesService.getAboutImages().then((value) {
      if (value.status == Status.success) {
        aboutImagesDataList = value.data;
      }
    });
    notifyListeners();
  }
}
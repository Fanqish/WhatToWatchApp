import 'dart:io';
import 'package:code/controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/material.dart';
// import '../consts/global.dart';
// import 'package:usage/usage_io.dart';

//Lanuch URL
//Check Internet

void openURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

// ignore: missing_return
void checkInternet() async {
  if (!GetPlatform.isWeb) {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!Get.find<AppController>().internet.value)
          Get.find<AppController>().getShow();
        Get.find<AppController>().internet.value = true;
      }
    } on SocketException catch (_) {
      Get.find<AppController>().internet.value = false;
    }
  }
}
/*---------------------Analytics---------------------*/
// Analytics analytics = AnalyticsIO(
//   kAnalyticsId,
//   kAppName,
//   kAppVer,
// );

// void logEvent({@required String category, @required String action}) =>
//     analytics.sendEvent(category, action);

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kAnalyticsId = "";
const kAppName = "";
const kAppVer = "";

class AppUrls {
  static String rate = "";
  static String more = "";
  static String support = "";
  static String privacy = "";
}

double kScreenHeight = Get.context.height - kBottomNavigationBarHeight;
double kScreenWidth = Get.context.width;

// Settings View
double kSettingsTitleContainerHeight = kScreenHeight * .35;
double kSettingsContainerHeight = kScreenHeight - kSettingsTitleContainerHeight;

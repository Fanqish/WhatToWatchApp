import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'consts/themes.dart';
import 'consts/global.dart';
import 'controller.dart';
import 'routes.dart';

void main() async {
  // await Hive.initFlutter();
  // await openBoxes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
            primaryColor: context.theme.accentColor.value, label: kAppName));
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GetMaterialApp(
      theme: Themes().light,
      darkTheme: Themes().dark,
      themeMode: isdark == null
          ? ThemeMode.system
          : isdark.value == true
              ? ThemeMode.dark
              : ThemeMode.light,
      initialBinding: AppControllerBinder(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

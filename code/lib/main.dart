import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'consts/themes.dart';
import 'consts/global.dart';
import 'controller.dart';
import 'routes.dart';
import 'utils/database.dart';

void main() async {
  await Hive.initFlutter();
  await openBoxes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
            primaryColor: context.theme.accentColor.value, label: kAppName));
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ValueListenableBuilder(
      valueListenable: settings.listenable(),
      builder: (context, box, child) {
        return GetMaterialApp(
          theme: Themes().light.copyWith(
                primaryColor: Color((settings.get("mainColor",
                    defaultValue: defaultMainColor))),
                primaryColorLight: Color((settings.get("mainColor",
                    defaultValue: defaultMainColor))),
                accentColor: Color((settings.get("mainColor",
                    defaultValue: defaultMainColor))),
              ),
          darkTheme: Themes().dark,
          themeMode: (box.get("isdark",
                  defaultValue:
                      ThemeMode.system == ThemeMode.dark ? true : false))
              ? ThemeMode.dark
              : ThemeMode.light,
          initialBinding: AppControllerBinder(),
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
            primaryColor: context.theme.colorScheme.secondary.value,
            label: kAppName));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return ValueListenableBuilder(
      valueListenable: settings.listenable(),
      builder: (context, box, child) {
        return GetMaterialApp(
          theme: Themes().light.copyWith(
                primaryColor: Color((settings.get("mainColor",
                    defaultValue: defaultMainColor))),
                primaryColorLight: Color((settings.get("mainColor",
                    defaultValue: defaultMainColor))),
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: Color((settings.get("mainColor",
                        defaultValue: defaultMainColor)))),
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

// TODO: Add Rate App https://pub.dev/packages/rate_my_app + emoji_feedback
// TODO: Add App Intro https://pub.dev/packages/intro_views_flutter
// TODO: Yotube Plyr >> https://pub.dev/packages/youtube_plyr_iframe
// TODO: Add Analytics >> https://pub.dev/packages/usage
// TODO: Add Category
// TODO: Add Category Setting


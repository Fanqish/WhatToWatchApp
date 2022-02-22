import '../../../consts/global.dart';
import '../../../consts/themes.dart';
import '../../../utils/database.dart';
import '../../../utils/online.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Donot Care
    double screenHeight = Get.context.height - kBottomNavigationBarHeight;
    double settingsTitleContainerHeight =
        Get.context.orientation == Orientation.portrait
            ? screenHeight * .15
            : Get.context.width * .1;
    // //Donot Care
    return Column(
      // fit: StackFit.expand,
      // clipBehavior: Clip.none,
      children: [
        Container(
          height: settingsTitleContainerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Get.context.theme.primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings,
                size: 55,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Settings",
                style: TextStyle(fontSize: 35, color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              SizedBox(height: 10),
              ListTile(
                title: Text(
                  "App Setting",
                  textAlign: TextAlign.left,
                ),
                enabled: false,
              ),
              ListTile(
                onTap: () {
                  settings.put("isdark", Get.isDarkMode ? false : true);
                  Get.changeThemeMode(
                      !Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);
                },
                title: (Text("Dark Mode", style: settingTextTheme)),
                trailing: Switch(
                  activeColor: Get.context.theme.colorScheme.secondary,
                  onChanged: (v) {
                    settings.put("isdark", Get.isDarkMode ? false : true);
                    Get.changeThemeMode(
                        !Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);
                  },
                  value: Get.isDarkMode,
                ),
              ),
              ListTile(
                enabled: Get.isDarkMode ? false : true,
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: Get.theme.colorScheme.secondary,
                          onColorChanged: (color) {
                            settings.put("mainColor", color.value);
                            Get.changeTheme(Themes().light.copyWith(
                                  primaryColor:
                                      Color((settings.get("mainColor"))),
                                  primaryColorLight: Color((settings.get(
                                    "mainColor",
                                  ))), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color((settings.get(
                                    "mainColor",
                                  )))),
                                ));
                          },
                        ),
                      ),
                    ),
                  );
                },
                title: (Text(
                  "App Color ",
                  style: settingTextTheme,
                )),
                trailing: Container(
                  transform: Matrix4.translationValues(-10, 0, 0),
                  height: 25,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Get.context.theme.disabledColor
                          : Get.theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              ListTile(
                title: Text("More"),
                enabled: false,
              ),
              LinkListTile("Share The App", Icons.share, "share"),
              LinkListTile("Rate 5 Stars", Icons.star_rounded, AppUrls.rate),
              LinkListTile(
                  "More Awesome Apps", Icons.apps_rounded, AppUrls.more),
              LinkListTile(
                  "Report A Bug", Icons.bug_report_rounded, AppUrls.support),
              LinkListTile("Suggest A Feature ", Icons.featured_play_list,
                  AppUrls.support),
              LinkListTile(
                  "Privacy Policy", Icons.privacy_tip_rounded, AppUrls.privacy),
            ],
          ),
        )
      ],
    );
  }
}

class LinkListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String link;

  const LinkListTile(this.title, this.icon, this.link);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: (Text(title.capitalize, style: settingTextTheme)),
      onTap: () => link == "share"
          ? Share.share(
              "Feel Bored And Want To Watch Something Awesome. Check ${AppUrls.rate}")
          : openURL(link),
      trailing: Container(
        transform: Matrix4.translationValues(-17.5, 0, 0),
        child: Icon(
          icon,
          color: Get.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

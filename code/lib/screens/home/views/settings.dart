import 'package:code/consts/global.dart';
import 'package:code/consts/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double kScreenWidth = Get.context.width;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: kSettingsTitleContainerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Get.context.theme.primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
          child: Container(
            transform: Matrix4.translationValues(
                0.0, -kSettingsTitleContainerHeight * .1, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings,
                  size: 60,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(
              kScreenWidth * .125, kSettingsTitleContainerHeight * .75, 0),
          width: kScreenWidth * .75,
          height:
              kSettingsContainerHeight + kSettingsTitleContainerHeight * .25,
          child: ListView(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("App Setting"),
              ),
              ListTile(
                title: (Text("Dark Mode")),
                trailing: Obx(
                  () => Switch(
                    // activeColor: mainColor.value,
                    onChanged: (v) async {
                      isdark.value = v;
                      Get.changeThemeMode(
                          isdark.value ? ThemeMode.dark : ThemeMode.light);
                    },
                    value: isdark.value,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: mainColor.value,
                          onColorChanged: (color) {
                            mainColor.value = color;
                            Get.changeTheme(Themes().light);
                          },
                        ),
                      ),
                    ),
                  );
                },
                title: (Text("App Color ")),
                trailing: Obx(() => Container(
                      transform: Matrix4.translationValues(-10, 0, 0),
                      height: 25,
                      width: 40,
                      decoration: BoxDecoration(
                          color: mainColor.value,
                          borderRadius: BorderRadius.circular(25)),
                    )),
              ),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              color: isdark.value
                  ? Get.context.theme.scaffoldBackgroundColor
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    blurRadius: 45,
                    offset: Offset(0, 0),
                    spreadRadius: 0)
              ]),
        )
      ],
    );
  }
}

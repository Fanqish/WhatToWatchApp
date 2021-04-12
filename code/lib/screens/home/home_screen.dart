import 'views/show.dart';
import 'views/settings.dart';
import 'views/watch_later.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxInt viewIndex = 0.obs;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => AnimatedSwitcher(
            duration: 250.milliseconds,
            child: [
              ShowView(),
              WatchLaterView(),
              SettingsView()
            ][viewIndex.value],
            transitionBuilder: (child, animation) {
              return FadeTransition(
                child: child,
                opacity: animation,
              );
            },
          )),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: Obx(() => BottomNavigationBar(
              backgroundColor: context.theme.primaryColor,
              onTap: (index) => viewIndex.value = index,
              currentIndex: viewIndex.value,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.watch_later_rounded),
                    label: "Watch Later"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_rounded), label: "Settings"),
              ],
            )),
      ),
    );
  }
}

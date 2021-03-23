import 'package:code/screens/home/views/movie.dart';
import 'package:code/screens/home/views/settings.dart';
import 'package:code/screens/home/views/watch_later.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> views = [MovieView(), WatchLaterView(), SettingsView()];
  final RxInt _index = 2.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: views[_index.value],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: BottomNavigationBar(
            backgroundColor: context.theme.primaryColor,
            onTap: (index) => _index.value = index,
            currentIndex: _index.value,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.watch_later_rounded), label: "Watch Later"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_rounded), label: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}

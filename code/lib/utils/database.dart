import 'package:hive/hive.dart';

Future<void> openBoxes() async {
  await Hive.openBox('settings');
  await Hive.openBox('shows');
}

Box settings = Hive.box("settings");
Box shows = Hive.box("shows");

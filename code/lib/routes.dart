import 'package:get/get.dart';
import 'screens/home/home_screen.dart';

class AppPages {
  static const initial = Routes.Home;

  static final routes = [
    GetPage(
      name: Routes.Home,
      page: () => HomeScreen(),
    ),
  ];
}

abstract class Routes {
  static const Home = '/home';
}

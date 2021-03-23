import 'package:get/get.dart';

class AppController extends GetxController {}

class AppControllerBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController);
  }
}

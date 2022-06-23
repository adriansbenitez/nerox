import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../features/login/authentication_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }
}
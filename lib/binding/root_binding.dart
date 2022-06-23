import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../features/login/authentication_controller.dart';
import '../features/login/authentication_service_impl.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
    Get.lazyPut(() => AuthenticationServiceImpl());
  }
}

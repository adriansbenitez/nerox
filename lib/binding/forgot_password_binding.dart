import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../features/password/reset_password_controller.dart';

class ForgotPasswordBinging implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}

import 'package:get/get.dart';

import '../features/register/customer_controller.dart';
import '../features/register/provider_controller.dart';
import '../features/register/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => CustomerController());
    Get.lazyPut(() => ProviderController());
  }

}
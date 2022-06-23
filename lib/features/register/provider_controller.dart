import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/provider.dart';
import '../../services/lyncel_api_client.dart';

class ProviderController extends GetxController {
  var _lynxcelApiClient = Get.put(LynxcelApiClient());

  Future<bool> register(firstName, email, password) {
    return _lynxcelApiClient.saveProvider(new Provider(
        id: 0,
        email: email,
        nombre: firstName,
        isActive: false,
        username: firstName,
        password: password));
  }
}

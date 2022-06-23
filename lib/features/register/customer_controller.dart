import 'package:get/get.dart';

import '../../models/customer.dart';
import '../../services/lyncel_api_client.dart';

class CustomerController extends GetxController {
  var _lynxcelApiClient = Get.put(LynxcelApiClient());

  Future<bool> register(firstName,email, password)  {
    return _lynxcelApiClient.saveCustomer(new Customer(
        id: 0, firstName: firstName, email: email, username: firstName, password: password));
  }
}

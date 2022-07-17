

import 'package:listar_flutter_pro/models/model_customer.dart';

import '../api/api.dart';

class CustomerRepository {

  static Future<CustomerModel?> getCustomer({
    required int id,
  }) async {
    CustomerModel? customerModel = await Api.getCustomer(id);
    return customerModel;
  }

}

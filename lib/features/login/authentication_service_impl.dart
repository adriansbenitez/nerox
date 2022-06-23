import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/user.dart';
import '../../services/lyncel_api_client.dart';
import 'authentication_service.dart';

class AuthenticationServiceImpl extends AuthenticationService {
  var _lynxcelApiClient = Get.put(LynxcelApiClient());

  late User _currentUser;


  @override
  User getCurrentUser() {
    return _currentUser;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return _currentUser =await  _lynxcelApiClient.loginUser(email, password);
  }

  @override
  Future<void>? signOut() {
    return null;
  }
}

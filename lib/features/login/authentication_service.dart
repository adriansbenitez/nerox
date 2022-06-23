import 'package:get/get.dart';

import '../../models/user.dart';

abstract class AuthenticationService extends GetxService{
  User getCurrentUser();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<void>? signOut();
}



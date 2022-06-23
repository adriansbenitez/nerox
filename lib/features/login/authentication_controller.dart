import 'package:get/get.dart';

import '../../../../exceptions/authentication_exception.dart';
import '../../../../models/user.dart';
import '../../../../views/full_app.dart';
import '../../binding/home_binding.dart';
import 'authentication_service_impl.dart';
import 'authentication_state.dart';


class AuthenticationController extends GetxController {
  final AuthenticationServiceImpl _authenticationService = Get.find();

  final _authenticationStateStream = AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<User> signIn(String email, String password) async {
    final user = await _authenticationService.signInWithEmailAndPassword(
        email, password);
    if (user.id > 0) {
      _authenticationStateStream.value = UnAuthenticated();
      Get.offAll( () => FullApp(), binding: HomeBinding());
    }

    return throw AuthenticationException(user.error);
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser();

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated();
    }
  }
}

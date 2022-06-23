import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../binding/forgot_password_binding.dart';
import '../../binding/register_binding.dart';
import '../../exceptions/authentication_exception.dart';
import '../../localizations/translator.dart';
import '../../theme/app_theme.dart';
import '../password/views/forgot_password_screen.dart';
import '../register/views/registration_screen.dart';
import 'authentication_controller.dart';
import 'login_state.dart';

class LogInController extends GetxController {
  RxBool isPasswordVisible = false.obs;

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  final _loginStateStream = LoginState().obs;

  LoginState get state => _loginStateStream.value;

  LogInController() {}

  void login(formKey, emailTE, passwordTE) async {
    if (formKey.currentState!.validate()) {
      _loginStateStream.value = LoginLoading();
      try {
        await _authenticationController.signIn(emailTE.text, passwordTE.text);
      } on AuthenticationException catch (e) {
        _loginStateStream.value = LoginFailure(error: e.message);
        Get.snackbar(
          "Error",
          e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xffe33239),
          colorText: AppTheme.theme.secondaryHeaderColor,
          icon: Icon(
            MdiIcons.accountCancel,
            color: AppTheme.theme.colorScheme.onPrimary,
            size: 35,
          ),
        );
      } finally {
        _loginStateStream.value = LoginState();
      }
    }
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return Translator.translate('login.input.email');
    } else if (!GetUtils.isEmail(text)) {
      return Translator.translate('login.validation.email');
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return Translator.translate('login.input.password');
    } else if (!FxStringValidator.validateStringRange(
      text,
    )) {
      return Translator.translate('login.validation.password');
    }
    return null;
  }

  void goToForgotPasswordScreen() {
    Get.to(ForgotPasswordScreen(), binding: ForgotPasswordBinging());
  }

  void goToRegisterScreen() {
    Get.to(() => RegistrationScreen(), binding: RegisterBinding());
  }

  void swithPasswordVisible() {
    isPasswordVisible.toggle();
  }
}

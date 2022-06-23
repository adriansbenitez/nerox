import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../localizations/translator.dart';
import '../../exceptions/forgot_password_exception.dart';
import '../../services/lyncel_api_client.dart';
import '../../theme/app_theme.dart';
import '../../widgets/lynxcel/forgot_password_success_widget.dart';
import '../login/views/login_screen.dart';
import 'forgot_password_state.dart';

class ResetPasswordController extends GetxController {
  final _forgotPasswordStateStream = ForgotPasswordState().obs;

  ForgotPasswordState get state => _forgotPasswordStateStream.value;
  var _lynxcelApiClient = Get.put(LynxcelApiClient());

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return Translator.translate('login.input.email');
    } else if (FxStringValidator.isEmail(text)) {
      return Translator.translate('login.validation.email');
    }
    return null;
  }

  Future<void> resetPassword(formKey, email) async {
    _forgotPasswordStateStream.value = ForgotPasswordLoading();
    try {
      if (formKey.currentState!.validate()) {
        if (await _lynxcelApiClient.resetLinkEmail(email.text)) {
          Get.defaultDialog(
              title: Translator.translate('register.success.title'),
              content: ForgotPasswordSuccessWidget());
        }
      }
    } on ForgotPasswordException catch (fpe) {
      Get.snackbar(
        "Error",
        fpe.message,
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
      _forgotPasswordStateStream.value = ForgotPasswordState();
    }
  }

  void gotToLoginScreen() {
    Get.to(LoginScreen());
  }
}

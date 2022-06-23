import 'package:nerox/features/register/provider_controller.dart';
import 'package:nerox/features/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../localizations/translator.dart';
import '../../exceptions/register_exception.dart';
import '../../theme/app_theme.dart';
import '../../widgets/lynxcel/register_success_widget.dart';
import '../login/views/login_screen.dart';
import 'customer_controller.dart';

class RegisterController extends GetxController {
  RxInt selectedRole = 1.obs;
  RxBool isPasswordVisible = false.obs ;

  final _registerStateStream = RegisterState().obs;
  RegisterState get state => _registerStateStream.value;

  RegisterController() {

  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return Translator.translate('login.input.email');
    } else if (FxStringValidator.isEmail(text)) {
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

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      return Translator.translate('register.validation.name');
    } else if (!FxStringValidator.validateStringRange(text, 4, 20)) {
      return "Password length must between 4 and 20";
    }
    return null;
  }

  void select(int select) {
    selectedRole.value = select;
  }

  Future<void> register(formKey, name, email, password) async {
    if (formKey.currentState!.validate()) {
      _registerStateStream.value = RegisterLoading();
      try {
       bool isSuccess = false;
        if (selectedRole.value == 2) {
          CustomerController customer = Get.find();
          isSuccess = await customer.register(name.text, email.text,password.text);
        } else {
          ProviderController provider = Get.find();
          isSuccess = await provider.register(name.text, email.text, password.text);
        }
        _registerStateStream.value = RegisterState();

        //registro correctamente
        if (isSuccess) {
          Get.defaultDialog(
              title: Translator.translate('register.success.title'),
              content: RegisterSuccessWidget()
          );
        }

      } on RegisterException catch (e) {
        _registerStateStream.value = RegistrationFailure(message: e.message);
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
      }
      finally {
        _registerStateStream.value = RegisterState();
      }
    }
  }

  void swithPasswordVisible() {
    isPasswordVisible.toggle();
  }

  void goToLogInScreen() {
    Get.to(LoginScreen());
  }

}

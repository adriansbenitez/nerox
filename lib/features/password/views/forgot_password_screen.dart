import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../localizations/translator.dart';
import '../../../../theme/constant.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../forgot_password_state.dart';
import '../reset_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  late ThemeData theme;
  late CustomTheme customTheme;
  late OutlineInputBorder outlineInputBorder;

  TextEditingController emailTE = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  var forgotPasswordController = Get.put(ResetPasswordController());

  void initState() {
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    outlineInputBorder = OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(Constant.textFieldRadius.medium)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() => Scaffold(
          body: ListView(
            padding: FxSpacing.fromLTRB(
                20, FxSpacing.safeAreaTop(context) + 40, 20, 20),
            children: [
              FxText.displaySmall(
                Translator.translate('forgot.password.title'),
                fontWeight: 500,
                color: theme.colorScheme.primary,
                textAlign: TextAlign.center,
                fontSize: 25,
              ),
              FxSpacing.height(24),
              Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage(
                        'assets/nerox/illustration/forgot_password.png'),
                    width: 320,
                  ),
                ),
              ),
              FxSpacing.height(40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.colorScheme.primaryContainer,
                          prefixIcon: Icon(
                            FeatherIcons.mail,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: Translator.translate('login.email'),
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: emailTE,
                      validator: forgotPasswordController.validateEmail,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                  ],
                ),
              ),
              FxSpacing.height(24),
              FxButton.block(
                elevation: 5,
                borderRadiusAll: Constant.buttonRadius.large,
                onPressed: () {
                  forgotPasswordController.resetPassword(formKey, emailTE);
                },
                splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                backgroundColor: theme.colorScheme.primary,
                child: (forgotPasswordController.state is ForgotPasswordLoading)
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ))
                    : FxText.labelLarge(
                        Translator.translate('forgot.password.title'),
                        color: theme.colorScheme.onPrimary,
                        letterSpacing: 0.4,
                      ),
              ),
            ],
          ),
        ));
  }
}

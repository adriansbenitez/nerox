import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../localizations/translator.dart';
import '../../../../../theme/constant.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../login_controller.dart';
import '../login_state.dart';

class LoginScreen extends StatelessWidget {
  late ThemeData theme;
  late CustomTheme customTheme;
  late OutlineInputBorder outlineInputBorder;
  var controller = Get.put(LogInController());
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailTE = TextEditingController();
  TextEditingController passwordTE = TextEditingController();

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
    return Scaffold(
        body: Obx(
      () => ListView(
        padding:
            FxSpacing.fromLTRB(16, FxSpacing.safeAreaTop(context) + 36, 16, 16),
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage(
                    'assets/nerox/illustration/wellcome.png'),
                width: 300,
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
                      labelStyle: FxTextStyle.bodyMedium(),
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
                  validator: controller.validateEmail,
                  cursorColor: theme.colorScheme.onPrimaryContainer,
                ),
                FxSpacing.height(20),
                TextFormField(
                  style: FxTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.colorScheme.primaryContainer,
                      prefixIcon: Icon(
                        FeatherIcons.lock,
                        color: theme.colorScheme.onBackground,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isPasswordVisible.isTrue
                            ? MdiIcons.eyeOutline
                            : MdiIcons.eyeOffOutline),
                        onPressed: () {
                          controller.swithPasswordVisible();
                        },
                      ),
                      hintText: Translator.translate('login.password'),
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: passwordTE,
                  validator: controller.validatePassword,
                  cursorColor: theme.colorScheme.onBackground,
                  obscureText: controller.isPasswordVisible.isFalse,
                ),
              ],
            ),
          ),
          FxSpacing.height(20),
          FxButton.block(
            elevation: 5,
            borderRadiusAll: Constant.buttonRadius.large,
            onPressed: () {
              controller.login(formKey, emailTE,passwordTE);
            },
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: (controller.state is LoginLoading)
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    ))
                : Text(Translator.translate('login.signin')),
          ),
          FxSpacing.height(16),
         /* Container(
            margin: EdgeInsets.only(top: 24),
            child: Center(
              child: FxText.bodyMedium(
                  Translator.translate('login.or').toUpperCase(),
                  fontWeight: 500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FxContainer.rounded(
                    width: 52,
                    height: 52,
                    paddingAll: 0,
                    color: theme.colorScheme.primary,
                    child: Icon(
                      MdiIcons.facebook,
                      color: theme.colorScheme.onPrimary,
                      size: 30,
                    )),
                SizedBox(
                  width: 20,
                ),
                FxContainer.rounded(
                    width: 52,
                    height: 52,
                    paddingAll: 0,
                    color: Color(0xffe33239),
                    child: Icon(
                      MdiIcons.google,
                      color: theme.colorScheme.onPrimary,
                      size: 30,
                    ),
                ),
              ],
            ),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton.text(
                onPressed: () {
                  controller.goToForgotPasswordScreen();
                },
                padding: FxSpacing.zero,
                splashColor: theme.colorScheme.primary.withAlpha(40),
                child: FxText.bodySmall(
                    Translator.translate('login.forgotpassword'),
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline),
              ),
              FxButton.text(
                onPressed: () {
                  controller.goToRegisterScreen();
                },
                padding: FxSpacing.zero,
                splashColor: theme.colorScheme.primary.withAlpha(40),
                child: FxText.bodySmall(
                  Translator.translate('login.signup'),
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../images.dart';
import '../../../../localizations/translator.dart';
import '../../../../theme/constant.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/custom_theme.dart';
import '../register_controller.dart';
import '../register_state.dart';

class RegistrationScreen extends StatelessWidget {
  late ThemeData theme;
  late CustomTheme customTheme;
  late OutlineInputBorder outlineInputBorder;
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameTE = TextEditingController();
  TextEditingController emailTE = TextEditingController();
  TextEditingController passwordTE = TextEditingController();

  var registerController = Get.put(RegisterController());

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
            FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 36, 20, 20),
        children: [
          FxText.displaySmall(
            Translator.translate('register.title'),
            fontWeight: 700,
            color: theme.colorScheme.primary,
            textAlign: TextAlign.center,
          ),
          FxSpacing.height(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FxContainer.bordered(
                border: Border.all(
                    color: registerController.selectedRole == 1
                        ? theme.colorScheme.primary
                        : Colors.transparent),
                padding: FxSpacing.xy(28, 20),
                borderRadiusAll: Constant.containerRadius.medium,
                onTap: () {
                  registerController.select(1);
                },
                child: Column(
                  children: [
                    Image(
                      height: 64,
                      width: 64,
                      image: AssetImage(Images.bussiness),
                    ),
                    FxSpacing.height(12),
                    FxText.bodySmall(
                      Translator.translate('register.business'),
                      fontWeight: 600,
                      color: registerController.selectedRole == 1
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onBackground,
                    ),
                  ],
                ),
              ),
              FxContainer.bordered(
                border: Border.all(
                    color: registerController.selectedRole == 2
                        ? theme.colorScheme.primary
                        : Colors.transparent),
                padding: FxSpacing.xy(28, 20),
                borderRadiusAll: Constant.containerRadius.medium,
                onTap: () {
                  registerController.select(2);
                },
                child: Column(
                  children: [
                    Image(
                      height: 64,
                      width: 64,
                      image: AssetImage(Images.client),
                    ),
                    FxSpacing.height(12),
                    FxText.bodySmall(
                      Translator.translate('register.client'),
                      fontWeight: 600,
                      color: registerController.selectedRole == 2
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onBackground,
                    ),
                  ],
                ),
              ),
            ],
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
                        FeatherIcons.user,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: Translator.translate('register.name'),
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: nameTE,
                  validator: registerController.validateName,
                  cursorColor: theme.colorScheme.onBackground,
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
                        FeatherIcons.mail,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: Translator.translate('register.email'),
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: emailTE,
                  validator: registerController.validateEmail,
                  cursorColor: theme.colorScheme.onBackground,
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
                        icon: Icon(registerController.isPasswordVisible.isTrue
                            ? MdiIcons.eyeOutline
                            : MdiIcons.eyeOffOutline),
                        onPressed: () {
                          registerController.swithPasswordVisible();
                        },
                      ),
                      hintText: Translator.translate('register.password'),
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: passwordTE,
                  validator: registerController.validatePassword,
                  cursorColor: theme.colorScheme.onBackground,
                  obscureText: registerController.isPasswordVisible.isFalse,
                ),
              ],
            ),
          ),
          FxSpacing.height(20),
          FxButton.block(
            elevation: 5,
            borderRadiusAll: Constant.buttonRadius.large,
            onPressed: () {
              registerController.register(formKey,nameTE,emailTE,passwordTE);
            },
            splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            backgroundColor: theme.colorScheme.primary,
            child: (registerController.state is RegisterLoading)
                ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,
                ))
                : FxText.labelLarge(
              Translator.translate('register.title'),
              color: theme.colorScheme.onPrimary,
            ),
          ),
          FxSpacing.height(16),
          Center(
            child: FxButton.text(
              onPressed: () {
                registerController.goToLogInScreen();
              },
              padding: FxSpacing.zero,
              splashColor: theme.colorScheme.primary.withAlpha(40),
              child: FxText.bodySmall(Translator.translate('register.account'),
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../loading_effect.dart';
import '../../../../localizations/translator.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/constant.dart';
import '../../../../theme/custom_theme.dart';
import '../../../../widgets/lynxcel/logout_widget.dart';
import '../profile_customer_controller.dart';
import 'edit_profile_customer_screen.dart';
import 'lang_customer_screen.dart';

class ProfileCustomerScreen extends StatelessWidget {
  late ThemeData theme;
  late CustomTheme customTheme;
  late OutlineInputBorder outlineInputBorder;
  var profileCustomerController = Get.put(ProfileCustomerController());

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
    if (false) {
      return Scaffold(
        body: Padding(
          padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 16),
          child: LoadingEffect.getProfileScreen(context),
        ),
      );
    } else {
      return Obx(() => Scaffold(
            body: ListView(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
              children: [
                FxContainer(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage(profileCustomerController.user.profileImage),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      FxSpacing.width(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxText.bodyLarge(profileCustomerController.user.name,
                                fontWeight: 700),
                            FxSpacing.width(8),
                            FxText.bodyMedium(
                              profileCustomerController.user.email,
                            ),
                            FxSpacing.height(8),
                            FxButton.outlined(
                                onPressed: () {
                                  Get.to(EditProfileCustomerScreen());
                                },
                                splashColor: theme.colorScheme.primaryContainer,
                                borderColor: theme.colorScheme.primary,
                                padding: FxSpacing.xy(16, 4),
                                borderRadiusAll: 32,
                                child: FxText.bodySmall(
                                    Translator.translate('profile.edit'),
                                    color: theme.colorScheme.primary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FxSpacing.height(24),
                FxContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.titleMedium(
                      Translator.translate('profile.option'),
                      fontWeight: 700,
                    ),
                    FxSpacing.height(8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: FxSpacing.zero,
                      inactiveTrackColor:
                          theme.colorScheme.primary.withAlpha(100),
                      activeTrackColor:
                          theme.colorScheme.primary.withAlpha(150),
                      activeColor: theme.colorScheme.primary,
                      title: FxText.bodyMedium(
                        Translator.translate('profile.notifications'),
                        letterSpacing: 0,
                      ),
                      onChanged: (value) {
                        profileCustomerController.notificationToggle();
                      },
                      value: profileCustomerController.notification.isTrue,
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: FxSpacing.zero,
                      visualDensity: VisualDensity.compact,
                      title: FxText.bodyMedium(
                        Translator.translate('profile.language'),
                        letterSpacing: 0,
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: theme.colorScheme.onBackground,
                      ),
                      onTap: () => {
                        Get.to(LangCustomerScreen())
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    /*FxSpacing.height(8),
                FxText.titleMedium(
                  Translator.translate('profile.account'),
                  fontWeight: 700,
                ),
                FxSpacing.height(8),
                ListTile(
                  dense: true,
                  contentPadding: FxSpacing.zero,
                  visualDensity: VisualDensity.compact,
                  title: FxText.bodyMedium(
                    Translator.translate('profile.information'),
                    letterSpacing: 0,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: theme.colorScheme.onBackground,
                  ),
                ),*/
                    FxSpacing.height(16),
                    Center(
                        child: FxButton.rounded(
                      onPressed: () {
                        Get.defaultDialog(
                            title: '',
                            barrierDismissible: false,
                            content: LogoutWidget());
                      },
                      child: FxText.labelLarge(
                        Translator.translate('profile.logout'),
                        color: theme.colorScheme.onPrimary,
                      ),
                      elevation: 5,
                      borderRadiusAll: Constant.buttonRadius.large,
                      splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                      backgroundColor: theme.colorScheme.primary,
                    ))
                  ],
                )),
                FxSpacing.height(24),
              ],
            ),
          ));
    }
  }
}

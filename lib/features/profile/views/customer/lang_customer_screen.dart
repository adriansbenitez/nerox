import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../localizations/translator.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/constant.dart';
import '../../../../theme/custom_theme.dart';
import '../profile_customer_controller.dart';

class LangCustomerScreen extends StatelessWidget {
  late ThemeData theme;
  late CustomTheme customTheme;
  late OutlineInputBorder outlineInputBorder;
  var profileCustomerController = Get.put(ProfileCustomerController());

  void initState() {
    theme = AppTheme.nftTheme;
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
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(MdiIcons.chevronLeft, size: 20),
          ),
          centerTitle: true,
          title: FxText.titleSmall(Translator.translate('profile.language'),
              color: theme.colorScheme.onBackground, fontWeight: 600),
        ),
        body: FxContainer(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: profileCustomerController.lang.value,
                      onChanged: (int? value) {
                        Get.updateLocale(Locale('es'));
                        profileCustomerController.langToogle(value);
                      },
                    ),
                    FxText.titleSmall(
                        Translator.translate('profile.lang.spanish'),
                        color: theme.colorScheme.onBackground,
                        fontWeight: 600)
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: profileCustomerController.lang.value,
                      onChanged: (int? value) {
                        Get.updateLocale(Locale('en'));
                        profileCustomerController.langToogle(value);
                      },
                    ),
                    FxText.titleSmall(
                        Translator.translate('profile.lang.english'),
                        color: theme.colorScheme.onBackground,
                        fontWeight: 600)
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}

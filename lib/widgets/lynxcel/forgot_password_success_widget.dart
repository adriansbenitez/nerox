import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../features/login/views/login_screen.dart';
import '../../localizations/translator.dart';
import '../../theme/constant.dart';

class ForgotPasswordSuccessWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Center(
              child: Icon(
                MdiIcons.accountCheckOutline,
                size: 40,
                color: theme.colorScheme.onBackground.withAlpha(220),
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Center(
              child: FxText.bodySmall(
                  Translator.translate('forgot.success.created'),
                  fontWeight: 600,
                  letterSpacing: 0)),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Center(
              child: FxText.bodySmall(
                Translator.translate('forgot.success.description'),
                fontWeight: 500,
                height: 1.15,
                textAlign: TextAlign.center,
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Center(
            child: FxButton(
                elevation: 2,
                borderRadiusAll: Constant.buttonRadius.large,
                splashColor: theme.colorScheme.primary.withAlpha(40),
                onPressed: () {
                  Get.offAll(LoginScreen());
                },
                child: FxText.labelLarge(Translator.translate('forgot.success.login'),
                  fontWeight: 600,
                  letterSpacing: 0.3,
                  color: theme.colorScheme.onPrimary,
                )),
          ),
        )
      ],
    );
  }
}

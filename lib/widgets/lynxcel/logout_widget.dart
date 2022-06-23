import 'package:flutter/material.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../features/profile/views/profile_customer_controller.dart';
import '../../localizations/translator.dart';
import '../../theme/constant.dart';

class LogoutWidget extends StatelessWidget {

   final ProfileCustomerController profileCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: FxSpacing.only(top: 8, left: 35),
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
                style:
                    FxTextStyle.titleSmall(fontWeight: 600, letterSpacing: 0.2),
                children: <TextSpan>[
                  TextSpan(
                    text: Translator.translate('logout.title'),
                  ),
                ]),
          ),
        ),
        Container(
            margin: FxSpacing.top(24),
            alignment: AlignmentDirectional.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FxButton.text(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    borderRadiusAll: Constant.buttonRadius.large,
                    child: FxText.bodyMedium(
                      Translator.translate('logout.cancel'),
                      fontWeight: 600,
                      color: theme.colorScheme.primary,
                    )),
                FxButton(
                  backgroundColor: theme.colorScheme.primary,
                  borderRadiusAll: Constant.buttonRadius.large,
                  elevation: 0,
                  onPressed: () {
                    profileCustomerController.exit();
                  },
                  child: FxText.labelLarge(Translator.translate('logout.accept'),
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

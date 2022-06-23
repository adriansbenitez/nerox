/*
* File : Hotel Onboarding
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../localizations/translator.dart';
import '../../../../theme/app_notifier.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/custom_theme.dart';
import '../../login/views/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    FxTextStyle.changeFontFamily(GoogleFonts.quicksand);
    FxTextStyle.changeDefaultFontWeight({
      100: FontWeight.w200,
      200: FontWeight.w300,
      300: FontWeight.w400,
      400: FontWeight.w500,
      500: FontWeight.w600,
      600: FontWeight.w700,
      700: FontWeight.w800,
      800: FontWeight.w900,
      900: FontWeight.w900,
    });
  }

  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  color: theme.backgroundColor,
                  child: FxOnBoarding(
                    pages: <PageViewModel>[
                      PageViewModel(
                        theme.backgroundColor,
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Center(
                                  child: Image(
                                image: AssetImage(
                                    './assets/nerox/illustration/appointment.png'),
                                width: 300,
                                height: 320,
                              )),
                              SizedBox(height: 30.0),
                              FxText.bodyLarge(
                                  Translator.translate(
                                      'onboarding.reserva.title'),
                                  fontWeight: 800),
                              SizedBox(height: 15.0),
                              FxText.bodyMedium(
                                  Translator.translate(
                                      'onboarding.reserva.description'),
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(200),
                                  letterSpacing: 0.1,
                                  fontWeight: 500),
                            ],
                          ),
                        ),
                      ),
                      PageViewModel(
                        theme.backgroundColor,
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Center(
                                  child: Image(
                                image: AssetImage(
                                    './assets/nerox/illustration/reminder.png'),
                                width: 300,
                                height: 320,
                              )),
                              SizedBox(height: 30.0),
                              FxText.bodyLarge(
                                  Translator.translate(
                                      'onboarding.recordatorio.title'),
                                  fontWeight: 800),
                              SizedBox(height: 15.0),
                              FxText.bodyMedium(
                                  Translator.translate(
                                      'onboarding.recordatorio.description'),
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(200),
                                  letterSpacing: 0.1,
                                  fontWeight: 500),
                            ],
                          ),
                        ),
                      ),
                      PageViewModel(
                        theme.backgroundColor,
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                  child: Image(
                                image: AssetImage(
                                    './assets/nerox/illustration/integration.png'),
                                width: 300,
                                height: 320,
                              )),
                              SizedBox(height: 30),
                              FxText.bodyLarge(
                                  Translator.translate(
                                      'onboarding.integration.title'),
                                  fontWeight: 800),
                              SizedBox(height: 15.0),
                              FxText.bodyMedium(
                                  Translator.translate(
                                      'onboarding.integration.description'),
                                  color: theme.colorScheme.onBackground
                                      .withAlpha(200),
                                  letterSpacing: 0.1,
                                  fontWeight: 500),
                            ],
                          ),
                        ),
                      ),
                    ],
                    unSelectedIndicatorColor: theme.colorScheme.secondary,
                    selectedIndicatorColor: theme.colorScheme.primary,
                    doneWidget: InkWell(
                      splashColor: theme.colorScheme.secondary,
                      onTap: () {
                        Get.offAll(LoginScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: FxText.titleSmall(
                            Translator.translate('onboarding.control.done')
                                .toUpperCase(),
                            color: theme.colorScheme.primary,
                            fontWeight: 700),
                      ),
                    ),
                    skipWidget: InkWell(
                      splashColor: theme.colorScheme.secondary,
                      onTap: () {
                        Get.offAll(LoginScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: FxText.titleSmall(
                            Translator.translate('onboarding.control.skip')
                                .toUpperCase(),
                            color: theme.colorScheme.secondary,
                            fontWeight: 700),
                      ),
                    ),
                  ))));
    });
  }
}

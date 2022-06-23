import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../localizations/language.dart';
import '../../theme/app_notifier.dart';
import '../controllers/handle_customer_controller.dart';
import '../controllers/handle_provider_controller.dart';
import '../features/login/authentication_service_impl.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class FullApp extends StatefulWidget {
  @override
  _FullAppState createState() => _FullAppState();
}

class _FullAppState extends State<FullApp>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  TabController? _tabController;
  var handleController;
  final AuthenticationServiceImpl _authenticationService = Get.find();

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }

  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    handleController = Get.put( _authenticationService.getCurrentUser().isPaciente ? HandleCustomerController() : HandleProviderController());
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.animation!.addListener(() {
      final aniValue = _tabController!.animation!.value;
      if (aniValue - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (aniValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          builder: (context, child) {
            return Directionality(
              textDirection: AppTheme.textDirection,
              child: child!,
            );
          },
          home: Scaffold(
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: customTheme.card,
              shape: CircularNotchedRectangle(),
              child: FxContainer(
                color: customTheme.card,
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: theme.colorScheme.primary,
                  tabs: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: customTheme.card.withAlpha(220),
                        // borderRadius: Shape.circular(16)
                      ),
                      child: (_currentIndex == 0)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.house,
                                  color: theme.colorScheme.primary,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(2.5))),
                                  height: 5,
                                  width: 5,
                                )
                              ],
                            )
                          : Icon(
                              Icons.house_outlined,
                              color: theme.colorScheme.onBackground,
                            ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: Language.autoDirection(0, 20)!,
                          right: Language.autoDirection(20, 0)!,
                        ),
                        child: (_currentIndex == 1)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.magnify,
                                    color: theme.colorScheme.primary,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(2.5))),
                                    height: 5,
                                    width: 5,
                                  )
                                ],
                              )
                            : Icon(
                                MdiIcons.magnify,
                                color: theme.colorScheme.onBackground,
                              )),
                    Container(
                        margin: EdgeInsets.only(
                          left: Language.autoDirection(20, 0)!,
                          right: Language.autoDirection(0, 20)!,
                        ),
                        child: (_currentIndex == 2)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.chat_bubble,
                                    color: theme.colorScheme.primary,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(2.5))),
                                    height: 5,
                                    width: 5,
                                  )
                                ],
                              )
                            : Icon(
                                Icons.chat_bubble_outline,
                                color: theme.colorScheme.onBackground,
                              )),
                    Container(
                        child: (_currentIndex == 3)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.account,
                                    color: theme.colorScheme.primary,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(2.5))),
                                    height: 5,
                                    width: 5,
                                  )
                                ],
                              )
                            : Icon(
                                MdiIcons.accountOutline,
                                color: theme.colorScheme.onBackground,
                              )),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MediCareHomeScreen();
                  }),
                );
              },
              child: Icon(
                Icons.date_range,
                color: theme.colorScheme.primary,
              ),
              backgroundColor: theme.backgroundColor,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: TabBarView(
              controller: _tabController,
              children: handleController.getMenu()
            ),
          ),
        );
      },
    );
  }
}

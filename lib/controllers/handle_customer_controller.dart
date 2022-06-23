import 'package:flutter/src/widgets/framework.dart';

import '../features/profile/views/customer/profile_customer_screen.dart';
import '../views/chat_screen.dart';
import '../views/home_screen.dart';
import '../views/schedule_screen.dart';
import 'handle_controller.dart';

class HandleCustomerController extends HandleController {
  @override
  List<Widget> getMenu() {
    return <Widget>[
      MediCareHomeScreen(
          //rootContext: context,
          ),
      MediCareScheduleScreen(
          //rootContext: context,
          ),
      MediCareChatScreen(
          //rootContext: context,
          ),
      ProfileCustomerScreen()
    ];
  }
}

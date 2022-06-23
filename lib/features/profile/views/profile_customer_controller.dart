import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../models/customer.dart';
import '../../../models/user.dart';
import '../../../services/lyncel_api_client.dart';
import '../../../utils/Helper.dart';
import '../../../utils/countries.dart';
import '../../login/authentication_service_impl.dart';
import '../../login/views/login_screen.dart';
import 'customer/state/edit_profile_state.dart';

class ProfileCustomerController extends GetxController {
  final AuthenticationServiceImpl _authenticationService = Get.find();

  User get user => _authenticationService.getCurrentUser();
  var _lynxcelApiClient = Get.put(LynxcelApiClient());
  late Customer customerInfo;

  RxBool notification = true.obs;
  RxInt lang = 1.obs;

  final _editProfileStateStream = EditProfileState().obs;

  EditProfileState get state => _editProfileStateStream.value;

  void exit() {
    Get.offAll(LoginScreen());
  }

  void notificationToggle() {
    notification.toggle();
  }

  void langToogle(int? value) {
    lang.value = value!;
  }

  Future<void> loadCustomerInformation() async {
    try {
      _editProfileStateStream.value = EditProfileLoading();
      customerInfo = await  _lynxcelApiClient.getCustomer(user) as Customer;
    } finally {
      _editProfileStateStream.value = EditProfileState();
    }
  }

  void completeLoadCustomInfo() {
    _editProfileStateStream.value = EditProfileState();
  }

  PhoneNumber getPhoneNumber() {
    if (customerInfo.phoneNumber != null) {
      var phoneNumber = countryList.where ((cl) => cl.phoneCode == customerInfo.countryCode?.replaceAll("+","")).toList()[0];
      return new PhoneNumber(countryISOCode: phoneNumber.isoCode,
          countryCode : phoneNumber.isoCode, number: customerInfo.phoneNumber != null ? customerInfo.phoneNumber! : "");
    } else {
      return new PhoneNumber(countryISOCode: "UY", countryCode: "598", number: "");
    }
  }

  /*String getCountryCode () {
    if (customerInfo.countryCode != null) {
      return customerInfo.countryCode!;
    } else {
      return Helper.getCountryPhoneCode() as String;
    }
  }*/

}

import 'package:nerox/features/profile/views/customer/state/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../loading_effect.dart';
import '../../../../localizations/translator.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/constant.dart';
import '../../../../utils/Helper.dart';
import '../profile_customer_controller.dart';

class EditProfileCustomerScreen extends GetView<ProfileCustomerController> {
  late ThemeData theme;
  late CustomTheme customTheme;
  late OutlineInputBorder outlineInputBorder;

  late TextEditingController name, email, birthday, phone;
  PhoneNumber phoneNumber = new PhoneNumber(countryISOCode: "", countryCode: "", number: "");
  late DateTime _selectedDate;

  EditProfileCustomerScreen() {
    name = new TextEditingController();
    email = new TextEditingController();
    birthday = new TextEditingController();
    phone = new TextEditingController();
    _selectedDate = DateTime.now();
    _loadingCustomerInfo();
  }

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

  Future<void> _loadingCustomerInfo() async {
    try {
      return await controller.loadCustomerInformation();
    } finally {
      _populateCustomerInfo();
    }
  }

  void _populateCustomerInfo() {
    name.text = controller.customerInfo.firstName +
        ' ' +
        controller.customerInfo.lastName!;
    email.text = controller.customerInfo.email;
    phoneNumber = controller.getPhoneNumber();
    phone.text = phoneNumber.number;
    birthday.text = (controller.customerInfo.birthdate == null
        ? ''
        : controller.customerInfo.birthdate)!;
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onBackground,
            ),
          ),
          elevation: 0,
        ),
        body: controller.state is EditProfileLoading
            ? LoadingEffect.getProfileScreen(context)
            : listViewContainer(context)));
  }

  ListView listViewContainer(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(controller.user.profileImage),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: theme.primaryColor,
                            width: 2,
                            style: BorderStyle.solid),
                        color: theme.primaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          MdiIcons.pencil,
                          size: 20,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              FxText.titleLarge(name.text, fontWeight: 600, letterSpacing: 0),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 36, left: 24, right: 24),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  style: FxTextStyle.bodyLarge(
                      letterSpacing: 0.1,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: Translator.translate('profile.name'),
                    hintStyle: FxTextStyle.titleSmall(
                        letterSpacing: 0.1,
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: customTheme.card,
                    prefixIcon: Icon(
                      MdiIcons.accountOutline,
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  controller: name,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  enabled: false,
                  style: FxTextStyle.bodyLarge(
                      letterSpacing: 0.1,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: Translator.translate('profile.email'),
                    hintStyle: FxTextStyle.titleSmall(
                        letterSpacing: 0.1,
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: customTheme.card,
                    prefixIcon: Icon(
                      MdiIcons.emailOutline,
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: Translator.translate('profile.number'),
                      hintStyle: FxTextStyle.titleSmall(
                          letterSpacing: 0.1,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: customTheme.card,
                      prefixIcon: Icon(
                        MdiIcons.emailOutline,
                      ),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    initialCountryCode: phoneNumber.countryCode,
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    invalidNumberMessage:
                        Translator.translate('profile.number.invalid'),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextFormField(
                  readOnly: true,
                  style: FxTextStyle.bodyLarge(
                      letterSpacing: 0.1,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    hintText: Translator.translate('profile.birthday'),
                    hintStyle: FxTextStyle.titleSmall(
                        letterSpacing: 0.1,
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: customTheme.card,
                    prefixIcon: Icon(
                      MdiIcons.calendar,
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  controller: birthday,
                  onTap: () => {_selectDate(context)},
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FxButton.rounded(
                    onPressed: () {},
                    elevation: 5,
                    borderRadiusAll: Constant.buttonRadius.large,
                    backgroundColor: theme.primaryColor,
                    child: FxText.labelLarge(
                        Translator.translate('profile.update'),
                        fontWeight: 600,
                        color: theme.colorScheme.onPrimary,
                        letterSpacing: 0.3)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      /*case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);*/
      case TargetPlatform.macOS:
        // TODO: Handle this case.
        break;
    }
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: Localizations.localeOf(context),
      initialDate: _selectedDate,
      // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != _selectedDate) _selectedDate = picked;
    List<String> dates =
        Helper.parseDateToStringArray(_selectedDate.toString());
    birthday.text = "${dates[0]}-${dates[1]}-${dates[2]}";
  }
}

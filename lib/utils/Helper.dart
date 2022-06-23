import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'countries.dart';

class Helper {

  static List<String> parseDateToStringArray(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted.split("-");
  }

  static Future<String> getCountryPhoneCode() async {
    var response = await get(Uri.parse('http://ip-api.com/json'));
    var jsonResponse = json.decode(response.body);
    final isoCode = jsonResponse['countryCode'];
    return "+" +
        countryList
            .firstWhere((element) => element.isoCode == isoCode,
            orElse: () => countryList.first)
            .phoneCode;
  }


}

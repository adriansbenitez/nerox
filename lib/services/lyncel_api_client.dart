/*
* File : Service Api Client
* Version : 1.0.0
* Author : Adrian Sosa Benitez
* */

import 'package:http/http.dart';

import '../exceptions/forgot_password_exception.dart';
import '../exceptions/register_exception.dart';
import '../localizations/translator.dart';
import '../models/customer.dart';
import '../models/provider.dart';
import '../models/reset.dart';
import '../models/response/response_customer.dart';
import '../models/user.dart';

class LynxcelApiClient {
  static const baseUrl = 'http://10.0.2.2:8000';
  //static const baseUrl = 'http://192.168.1.3:8080';

  Future<User> loginUser(String userOrEmail, String password) async {
    final userLoginUrl = '${baseUrl}/api/auth/login';

    try {
      final response = await post(Uri.parse(userLoginUrl), body: {
        "email": userOrEmail,
        "password": password,
      });

      if (response.statusCode == 200) {
        final String responseData = response.body;
        return userFromJson(responseData);
      } else
        return new User(
            id: 0,
            name: '',
            user: '',
            token: '',
            error: Translator.translate('login.validation.unauthorized'),
            email: '');
    } on Exception catch (se) {
      return new User(
          id: 0,
          name: '',
          user: '',
          token: '',
          error: se.toString(),
          email: '');
    }
  }

  Future<bool> saveCustomer(Customer customer) async {
    final customerUrl = '$baseUrl/api/customers';
    Map<String, String> headers = {"Content-type": "application/json"};
    final customerResponse = await post(Uri.parse(customerUrl),
        body: customerToJson(customer), headers: headers);

    if (customerResponse.statusCode == 201) {
      return true;
    } else {
      throw new RegisterException(customerResponse.reasonPhrase);
    }
  }

  Future<bool> saveProvider(Provider provider) async {
    final providerUrl = '$baseUrl/api/staff';
    Map<String, String> headers = {"Content-type": "application/json"};
    final providerResponse = await post(Uri.parse(providerUrl),
        body: providerModelToJson(provider), headers: headers);

    if (providerResponse.statusCode == 201) {
      return true;
    } else {
      throw new RegisterException(providerResponse.reasonPhrase);
    }
  }

  Future<bool> resetLinkEmail(String email) async {
    final resetUrl = '$baseUrl/api/password/email';
    Map<String, String> headers = {"Content-type": "application/json"};
    final resetLinkResponse = await post(Uri.parse(resetUrl),
        body: resetModelToJson(new Reset(email: email)), headers: headers);

    if (resetLinkResponse.statusCode == 201) {
      return true;
    } else {
      throw new ForgotPasswordException(resetLinkResponse.reasonPhrase);
    }
  }

  Future<Customer?> getCustomer(User user) async {
    final customerUrl = '${baseUrl}/api/customers?user_id=${user.id}';
    Map<String, String> headers = {
      "Content-type": "application/json",
      "authorization": "Bearer ${user.token}"
    };
    final customerResponse = await get(
      Uri.parse(customerUrl),
      headers: headers,
    );

    if (customerResponse.statusCode == 200) {
      final ResponseCustomer customerResponseModel =
      responseFromJson(customerResponse.body);
      List<Customer> customerList = customerResponseModel.response
          .map((e) => Customer.fromJson(e))
          .toList();
      return customerList[0];
    }

    return null;
  }
}

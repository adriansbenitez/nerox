import 'dart:convert';
import 'dart:io';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';

class UserRepository {


  ///Fetch api login
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    UserModel? userModel;
    final Map<String, dynamic> params = {
      "email": username,
      "password": password,
    };
    final response = await Api.requestLogin(params);

    if (response.success) {
      userModel = UserModel.fromSource(response.user);
      await AppBloc.userCubit.onSaveUser(userModel);

      if (userModel.isPaciente) {
        userModel.customerModel= await Api.getCustomer(userModel.id);
      }
      return userModel;
    }

    AppBloc.messageCubit.onShow(response.message);
    return null;
  }

  ///Fetch api validToken
  static Future<bool> validateToken() async {
    final response = await Api.requestValidateToken();
    if (response.success) {
      return true;
    }
    AppBloc.messageCubit.onShow(response.message);
    return false;
  }

  ///Fetch api change Password
  static Future<bool> changePassword({
    required String password,
  }) async {
    final Map<String, dynamic> params = {"password": password};
    final response = await Api.requestChangePassword(params);
    AppBloc.messageCubit.onShow(response.message);
    if (response.success) {
      return true;
    }
    return false;
  }

  ///Fetch api forgot Password
  static Future<bool> forgotPassword({required String email}) async {
    final Map<String, dynamic> params = {"email": email};
    final response = await Api.requestForgotPassword(params);
    AppBloc.messageCubit.onShow(response.message);
    if (response.success) {
      return true;
    }
    return false;
  }

  ///Fetch api register account
  static Future<bool> register({
    required String username,
    required String password,
    required String email,
  }) async {
    final Map<String, dynamic> params = {
      "username": username,
      "password": password,
      "email": email,
    };
    final response = await Api.requestRegister(params);
    AppBloc.messageCubit.onShow(response.message);
    if (response.success) {
      return true;
    }
    return false;
  }

  ///Fetch api forgot Password
  static Future<bool> changeProfile({
    required int id,
    required String name,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String gender,
    required String description,
  }) async {
    Map<String, dynamic> params = {
      "first_name": name,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "gender": gender,
      "notes": description,
    };
    final response = await Api.updateCustomer(id, params);
    AppBloc.messageCubit.onShow(response.message);

    ///Case success
    if (response.success) {
      return true;
    }
    return false;
  }

  ///Save User
  static Future<bool> saveUser({required UserModel user}) async {
    return await Preferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }

  ///Load User
  static Future<UserModel?> loadUser() async {
    final result = Preferences.getString(Preferences.user);
    if (result != null) {
      return UserModel.fromJson(jsonDecode(result));
    }
    return null;
  }

  ///Fetch User
  static Future<UserModel?> fetchUser() async {
    final response = await Api.requestUser();
    if (response.success) {
      return UserModel.fromJson(response.data);
    }
    AppBloc.messageCubit.onShow(response.message);
    return null;
  }

  ///Delete User
  static Future<bool> deleteUser() async {
    return await Preferences.remove(Preferences.user);
  }

  ///Save Image
  static Future<ResultApiModel> uploadProfileUser( File file, String sourceType, int sourceId, progress) async {
     return await Api.requestChangeImage(file, sourceType,sourceId, progress);
   }
}

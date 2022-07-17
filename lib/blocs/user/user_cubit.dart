import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/customer_repository.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

import '../../models/model_customer.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  ///Event load user
  Future<UserModel?> onLoadUser() async {
    UserModel? user = await UserRepository.loadUser();
    emit(user);
    return user;
  }

  ///Event fetch user
  Future<UserModel?> onFetchUser() async {
    UserModel? local = await UserRepository.loadUser();
    //UserModel? remote = await UserRepository.fetchUser();
    if (local != null/* && remote != null*/) {
     /* final sync = local.updateUser(
        name: remote.name,
        email: remote.email,
      );*/

      if (local.isPaciente) {
        CustomerModel? remoteCustomer = await CustomerRepository.getCustomer(id : local.id);
        local.updateCustomer(remoteCustomer!);
      }

      onSaveUser(local);
      return local;
    }
    return null;
  }

  ///Event save user
  Future<void> onSaveUser(UserModel user) async {
    await UserRepository.saveUser(user: user);
    emit(user);
  }

  ///Event delete user
  void onDeleteUser() {
    //FirebaseMessaging.instance.deleteToken();
    UserRepository.deleteUser();
    emit(null);
  }

  ///Event update user
  Future<bool> onUpdateUser({
    required String name,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String gender,
    required String description,
    required int id,
  }) async {
    ///Fetch change profile
    final result = await UserRepository.changeProfile(
      name: name,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      description: description,
      id: id,
    );

    ///Case success
    if (result) {
      await onFetchUser();
    }
    return result;
  }

  ///Event change password
  Future<bool> onChangePassword(String password) async {
    return await UserRepository.changePassword(password: password);
  }

  ///Event register
  Future<bool> onRegister({
    required String username,
    required String password,
    required String email,
  }) async {
    return await UserRepository.register(
      username: username,
      password: password,
      email: email,
    );
  }

  ///Event forgot password
  Future<bool> onForgotPassword(String email) async {
    return await UserRepository.forgotPassword(email: email);
  }
}

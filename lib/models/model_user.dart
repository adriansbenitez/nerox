import '../configs/image.dart';
import 'model_customer.dart';

class UserModel {
  late int id;
  late String user;
  late String name;
  late String token;
  late String profileImage;
  late String email;
  late bool isPaciente;

  //metadata
  late CustomerModel customerModel;

  UserModel({
    required this.id,
    required this.user,
    required this.name,
    required this.token,
    required this.email,
    this.profileImage = "./assets/lynxcel/images/profile_default.png",
    this.isPaciente = false
  });



  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id_user'],
      name: json['name'],
      token: json['access_token'],
      email: json['email'] ?? '',
      profileImage: json['url_logo'] ?? '',
      isPaciente: json['isPaciente'],
      user: '',
    );
  }

  UserModel updateUser({
    String? name,
    String? email,
    String? profileImage,
    String? token
  }) {
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.profileImage = profileImage ?? this.profileImage;
    this.token = token ?? this.token;
    return clone();
  }

  void updateCustomer(CustomerModel customerModel) {
    this.customerModel = customerModel;
  }

  UserModel.fromSource(source) {
    id = source.id;
    name = source.name;
    email = source.email;
    token = source.token;
    email = source.email;
    profileImage = source.profileImage;
    isPaciente = source.isPaciente;
  }

  UserModel clone() {
    return UserModel.fromSource(this);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": id,
      "name": name,
      "email": email,
      "access_token": token,
      "url_logo": profileImage,
      "isPaciente": isPaciente,
    };
  }
}

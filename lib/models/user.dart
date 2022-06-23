import 'dart:convert';

class User {
  int id;
  String user;
  String name;
  String token;
  String profileImage;
  String email;
  bool isPaciente;
  String? error;

  User({
    required this.id,
    required this.name,
    required this.user,
    required this.token,
    required this.email,
    this.profileImage = "./assets/nerox/images/profile_default.png",
    this.isPaciente = false, required,
    this.error
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id_user'],
      name: json['name'],
      token: json['access_token'],
      email: json['email'] == null ? '' : json['email'],
      profileImage: json['url_logo'] ?? "./assets/nerox/images/profile_default.png",
      isPaciente: json['isPaciente'],
      user: '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id_user": id,
        "name": name,
        "access_token": token,
        "url_logo": profileImage,
        "isPaciente": isPaciente,
      };
}

String userModelToJson(User data) => json.encode(data.toJson());

User userFromJson(String str) => User.fromJson(json.decode(str));

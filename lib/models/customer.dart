import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

String customerMinimumToJson(Customer data) =>
    json.encode(data.toJsonMinimum());

class Customer {
  Customer(
      {required this.id,
      this.userId,
      required this.firstName,
      this.lastName,
      this.phoneNumber,
      this.countryCode,
      required this.email,
      this.birthdate,
      this.notes,
      this.profileImage,
      this.gender,
      this.age,
      this.curp,
      this.password,
      this.username});

  int id;
  int? userId;
  String firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;
  String email;
  String? birthdate;
  String? notes;
  dynamic profileImage;
  String? gender;
  int? age;
  String? curp;
  String? username;
  String? password;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"] != null ? json["country_code"] : '+598',
        email: json["email"],
        birthdate: json["birthdate"],
        notes: json["notes"],
        profileImage: json["profile_image"],
        gender: json["gender"],
        age: json["age"],
        curp: json["curp"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "email": email,
        "birthdate": birthdate,
        "notes": notes,
        "profile_image": profileImage,
        "gender": gender,
        "age": age,
        "curp": curp,
        "user": username,
        "password": password,
      };

  Map<String, dynamic> toJsonMinimum() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "email": email,
        "birthdate": birthdate,
        "notes": notes,
        "gender": gender,
        "curp": curp
      };
}

import 'dart:convert';

class Reset {
  int? id;
  String email;

  Reset({this.id, required this.email});

  factory Reset.fromJson(dynamic json) {
    return Reset(id: json['id_user'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}

String resetModelToJson(Reset data) => json.encode(data.toJson());

Reset resetFromJson(String str) => Reset.fromJson(json.decode(str));

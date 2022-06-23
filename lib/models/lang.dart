
import 'dart:convert';

Lang langFromJson(String str) => Lang.fromJson(json.decode(str));

String langToJson(Lang data) => json.encode(data.toJson());

class Lang {
  Lang({
    required this.lang,
    required this.value,
  });

  String lang;
  String value;

  factory Lang.fromJson(Map<String, dynamic> json) => Lang(
        lang: json["lang"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "lang": lang,
        "value": value,
      };
}

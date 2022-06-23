import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'lang.dart';

class Localizacion extends Equatable {
  final int id;
  final String name;
  final String? srcImage;
  final String? address;
  final String? phoneNumber;
  final String? notes;
  final String? latitude;
  final String? longitude;
  final bool isActive;
  final List<Lang>? lang;

  const Localizacion({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.address,
    this.srcImage,
    this.notes,
    this.latitude,
    this.longitude,
    required this.isActive,
    this.lang,
  });

  factory Localizacion.fromJson(dynamic json) {
    var _lang = json['lang'] != null && json['lang'] != ''
        ? jsonDecode(json['lang'])
        : null;
    return Localizacion(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      notes: json['notes'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      isActive: json['is_active'] == 1,
      srcImage: json['image'],
      lang: json['lang'] != null && json['lang'] != ''
          ? List<Lang>.from(_lang.map((x) => Lang.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone_number": phoneNumber,
        "notes": notes,
        "latitude": latitude,
        "longitude": longitude,
        "is_active": isActive,
        "image": srcImage,
        "lang": lang,
      };

  @override
  List<Object> get props => [id, name, isActive];

  @override
  String toString() => 'Localization { id: $id}';
}

String localizacionModelToJson(Localizacion data) => json.encode(data.toJson());

Localizacion localizacionFromJson(String str) =>
    Localizacion.fromJson(json.decode(str));

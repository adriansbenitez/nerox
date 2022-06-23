import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'localizacion.dart';

class Provider extends Equatable {
  int id;
  int? userId;
  String? username;
  String? password;
  String email;
  String nombre;
  String? apellidos;
  String? dob;
  String? mobile;
  String? mobileWhatsapp;
  String? about;
  String? curp;
  List<ProfesionalRegistration>? regitroProfesionalList;
  String ?srcImage;
  String ?zoomUser;
  bool isActive;
  List<Localizacion>? locations;

  Provider({
    required this.id,
    required this.email,
    this.username,
    this.password,
    this.userId,
    required this.nombre,
    this.apellidos,
    this.dob,
    this.mobile,
    this.mobileWhatsapp,
    this.curp,
    this.srcImage,
    this.regitroProfesionalList,
    this.zoomUser,
    required this.isActive,
    this.locations,
    this.about,
  });

  factory Provider.fromJson(dynamic json) {
    return Provider(
      id: json['id'],
      email: json['email'],
      userId: json['user_id'],
      nombre: json['first_name'],
      apellidos: json['last_name'],
      mobile: json['phone_number'],
      curp: json['curp'],
      srcImage: json['profile_image'],
      regitroProfesionalList: json['info_adicional'] != null
          ? (json['info_adicional'] as List)
          .map((i) => ProfesionalRegistration.fromJson(i))
          .toList()
          : [],
      zoomUser: json['zoom_user'],
      isActive: json['is_active'] != null ? json['is_active'] == 1 : false,
      locations: json['locations'] != null
          ? (json['locations'] as List)
          .map((i) => Localizacion.fromJson(i))
          .toList()
          : null,
      about: json['about'],
      mobileWhatsapp: json['phone_whatsapp'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id != null ? id : 0,
    "email": email,
    "user_id": userId != null ? userId : 0,
    "first_name": nombre,
    "last_name": apellidos,
    "phone_number": mobile,
    "curp": curp,
    "profile_image": srcImage,
    "info_adicional": regitroProfesionalList != null
        ? regitroProfesionalList
        ?.map((register) => register.toJson())
        .toList()
        : null,
    "zoom_user": zoomUser,
    "is_active": isActive ? 1 : 0,
    "locations": locations != null
        ? locations?.map((location) => location.toJson()).toList()
        : null,
    "about": about,
    "phone_whatsapp": mobileWhatsapp,
    "username": username,
    "password": password,
  };

  Map<String, dynamic> toJsonReduce() => {
    "id": id,
    "email": email,
    "user_id": userId,
    "first_name": nombre,
    "last_name": apellidos,
    "phone_number": mobile,
    "curp": curp,
    "zoom_user": zoomUser,
    "is_active": isActive ? 1 : 0,
    "about": about,
    "phone_whatsapp": mobileWhatsapp,
    "info_adicional":
    regitroProfesionalList != null
        ? regitroProfesionalList
        ?.map((register) => register.toJson())
        .toList()
        : null,
  };

  factory Provider.fromJsonReduce(dynamic json) {
    return Provider(
      id: json['id'],
      email: json['email'],
      userId: json['user_id'],
      nombre: json['first_name'],
      apellidos: json['last_name'],
      mobile: json['phone_number'],
      curp: json['curp'],
      regitroProfesionalList: null,
      zoomUser: json['zoom_user'],
      isActive: json['is_active'] != null ? json['is_active'] == 1 : false,
      about: json['about'],
      mobileWhatsapp: json['phone_whatsapp'],
      srcImage: json['profile_image'],
    );
  }

  @override
  List<Object> get props => [id, nombre, email];
}

String providerModelToJson(Provider data) => json.encode(data.toJson());

String providerModelToJsonReduce(Provider data) =>
    json.encode(data.toJsonReduce());

Provider providerFromJson(String str) => Provider.fromJson(json.decode(str));

Provider providerFromJsonReduce(String str) =>
    Provider.fromJsonReduce(json.decode(str));

class ProfesionalRegistration extends Equatable {
  final String cedula;
  final String especialidad;

  ProfesionalRegistration({required this.cedula, required this.especialidad});

  @override
  List<Object> get props => [cedula, especialidad];

  factory ProfesionalRegistration.fromJson(dynamic json) {
    return ProfesionalRegistration(
      cedula: json['cedula'],
      especialidad: json['especialidad'],
    );
  }

  Map<String, dynamic> toJson() => {
    "cedula": cedula,
    "especialidad": especialidad,
  };
}

String profesionalRegistrationModelToJson(ProfesionalRegistration data) =>
    json.encode(data.toJson());

String changeProfesionalRegistrationRequestToJson(
    List<ProfesionalRegistration> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ProfesionalRegistration profesionalRegistrationFromJson(String str) =>
    ProfesionalRegistration.fromJson(json.decode(str));

class ProfesionalRegistrationArguments {
  final List<ProfesionalRegistration> matriculasProfesionales;
  final int index;

  ProfesionalRegistrationArguments({required this.matriculasProfesionales, required this.index});
}
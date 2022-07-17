
class CustomerModel {
  late int id;
  late int userId;
  late String email;
  late String username;
  late String password;
  late String nombre;
  late String apellidos;
  late String dob;
  late String mobile;
  late String notes;
  late String gender;

  //metadata

  CustomerModel({
    required this.id,
    required this.userId,
    required this.email,
    required this.username,
    required this.password,
    required this.nombre,
    required this.apellidos,
    required this.dob,
    required this.mobile,
    required this.notes,
    required this.gender,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      userId: json['user_id'],
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      nombre: json['first_name'] ?? '',
      apellidos: json['last_name'] ?? '',
      dob: json['birthdate'] ?? '',
      notes: json['notes'] ?? '',
      mobile: json['phone_number'] ?? '',
      gender: json['gender'] ?? 'male', //TODO internacionalizar
    );
  }

  CustomerModel updateCustomer({
    String? username,
    String? password,
    String? nombre,
    String? apellidos,
    String? dob,
    String? notes,
    String? mobile,
    String? gender,
  }) {
    this.username = username ?? this.username;
    this.password = password ?? this.password;
    this.nombre = nombre ?? this.nombre;
    this.apellidos = apellidos ?? this.apellidos;
    this.dob = dob ?? this.dob;
    this.notes = notes ?? this.notes;
    this.mobile = mobile ?? this.mobile;
    this.gender = gender ?? this.gender;
    return clone();
  }

  CustomerModel.fromSource(source) {
    id = source.id;
    userId: source.userId;
    email: source.email;
    username: source.username;
    password: source.password;
    nombre: source.nombre;
    apellidos: source.apellidos;
    dob: source.dob;
    notes: source.notes;
    mobile: source.mobile;
    gender: source.gender;
  }

  CustomerModel clone() {
    return CustomerModel.fromSource(this);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": id,
      "user_id": userId,
      "email": email,
      "username": username,
      "password": password,
      "first_name": nombre,
      "last_name": apellidos,
      "birthdate": dob,
      "notes": notes,
      "phone_number": mobile,
      "gender": gender,
    };
  }


}
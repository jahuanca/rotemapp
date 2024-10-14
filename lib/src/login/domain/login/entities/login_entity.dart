class LoginEntity {
  String cedula;
  String password;

  LoginEntity({required this.cedula, required this.password});

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
    cedula: json["cedula"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "cedula": cedula,
    "password": password,
  };

}

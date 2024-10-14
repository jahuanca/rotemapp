
class ErrorEntity{

  String code;
  String message;

  ErrorEntity({
    required this.code,
    required this.message,
  });

  factory ErrorEntity.fromJson(Map<String, dynamic> json) => ErrorEntity(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
  };

}
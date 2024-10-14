
class XCsrfTokenResponse{

  String token;
  String cookie;

  XCsrfTokenResponse({
    required this.cookie,
    required this.token,
  });

  factory XCsrfTokenResponse.fromJson(Map<String, dynamic> json) => XCsrfTokenResponse(
      cookie: json["cookie"],
      token: json["token"],
    );

    Map<String, dynamic> toJson() => {
      "cookie": cookie,
      "token": token,
    };

}
import 'dart:convert';

SapResponse sapResponseFromJson(String str, Function(dynamic)? toElement) =>
    SapResponse.fromJson(json: json.decode(str), toElement: toElement);

String sapResponseToJson(SapResponse data) => json.encode(data.toJson());

class SapResponse {
  D d;

  SapResponse({
    required this.d,
  });

  factory SapResponse.fromJson({
    required Map<String, dynamic> json,
    Function(dynamic)? toElement,
    }) => SapResponse(
    d: D.fromJson(json: json["d"], toElement: toElement),

  );

  Map<String, dynamic> toJson() => {
    "d": d.toJson(),
  };
}

class D {
  D({
    required this.results,
  });

  List<dynamic> results;

  factory D.fromJson({
    required Map<String, dynamic> json, Function(dynamic)? toElement}) => D(
    results: List<dynamic>.from(json["results"].map(toElement!)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}


// To parse this JSON data, do
//
//     final createUserRequestResponse = createUserRequestResponseFromJson(jsonString);

import 'dart:convert';

List<CreateUserRequestResponse> createUserRequestResponseFromJson(String str) => List<CreateUserRequestResponse>.from(json.decode(str).map((x) => CreateUserRequestResponse.fromJson(x)));

String createUserRequestResponseToJson(List<CreateUserRequestResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreateUserRequestResponse {
    int id;
    int pernr;
    DateTime fechaTransf;
    String horaTransf;
    String estado;
    String mensaje;
    String success;

    CreateUserRequestResponse({
        required this.id,
        required this.pernr,
        required this.fechaTransf,
        required this.horaTransf,
        required this.estado,
        required this.mensaje,
        required this.success,
    });

    factory CreateUserRequestResponse.fromJson(Map<String, dynamic> json) => CreateUserRequestResponse(
        id: json["ID"],
        pernr: json["PERNR"],
        fechaTransf: DateTime.parse(json["FECHA_TRANSF"]),
        horaTransf: json["HORA_TRANSF"],
        estado: json["ESTADO"],
        mensaje: json["MENSAJE"],
        success: json["SUCCESS"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "PERNR": pernr,
        "FECHA_TRANSF": "${fechaTransf.year.toString().padLeft(4, '0')}-${fechaTransf.month.toString().padLeft(2, '0')}-${fechaTransf.day.toString().padLeft(2, '0')}",
        "HORA_TRANSF": horaTransf,
        "ESTADO": estado,
        "MENSAJE": mensaje,
        "SUCCESS": success,
    };
}

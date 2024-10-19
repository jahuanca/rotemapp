// To parse this JSON data, do
//
//     final manageRequestResponse = manageRequestResponseFromJson(jsonString);

import 'dart:convert';

ManageRequestResponse manageRequestResponseFromJson(String str) => ManageRequestResponse.fromJson(json.decode(str));

String manageRequestResponseToJson(ManageRequestResponse data) => json.encode(data.toJson());

class ManageRequestResponse {
    String id;
    String codigoestado;
    String? nombre;
    String? concepto;

    ManageRequestResponse({
        required this.id,
        required this.codigoestado,
        this.nombre,
        this.concepto,
    });

    factory ManageRequestResponse.fromJson(Map<String, dynamic> json) => ManageRequestResponse(
        id: json["ID"],
        codigoestado: json["CODIGOESTADO"],
        nombre: json["nombre"],
        concepto: json["concepto"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "CODIGOESTADO": codigoestado,
        "nombre": nombre,
        "concepto": concepto,
    };
}

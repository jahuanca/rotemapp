// To parse this JSON data, do
//
//     final getUserAmountRequest = getUserAmountRequestFromJson(jsonString);

import 'dart:convert';

import 'package:app_metor/src/utils/core/formats.dart';

List<GetUserAmountRequest> getUserAmountRequestFromJson(String str) => List<GetUserAmountRequest>.from(json.decode(str).map((x) => GetUserAmountRequest.fromJson(x)));

String getUserAmountRequestToJson(List<GetUserAmountRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUserAmountRequest {
    String cedula;
    DateTime? fechasolicitud;
    String? importe;
    String codigoAmount;
    String? errorAmount;
    String? concepto;

    GetUserAmountRequest({
        required this.cedula,
        required this.fechasolicitud,
        this.importe,
        required this.codigoAmount,
        this.errorAmount,
        this.concepto,
    });

    factory GetUserAmountRequest.fromJson(Map<String, dynamic> json) => GetUserAmountRequest(
        cedula: json["PERNR"],
        fechasolicitud: DateTime.tryParse(json["FECHASOLICITUD"]),
        importe: json["IMPORTE"],
        codigoAmount: json["CODIGOCC"],
        errorAmount: json["errorAmount"],
        concepto: json["concepto"],
    );

    Map<String, dynamic> toJson() => {
        "PERNR": cedula,
        "FECHASOLICITUD": fechasolicitud,
        "IMPORTE": importe,
        "CODIGOCC": codigoAmount,
        "errorAmount": errorAmount,
        "concepto": concepto,
    };

    Map<String, dynamic> toJsonByServer() => {
        "PERNR": cedula,
        "FECHASOLICITUD": fechasolicitud?.formatDateToServer(),
        "IMPORTE": importe,
        "CODIGOCC": codigoAmount,
    };
}

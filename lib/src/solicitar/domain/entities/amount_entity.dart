
// To parse this JSON data, do
//
//     final amountEntity = amountEntityFromJson(jsonString);

import 'dart:convert';

AmountEntity amountEntityFromJson(String str) => AmountEntity.fromJson(json.decode(str));

String amountEntityToJson(AmountEntity data) => json.encode(data.toJson());

class AmountEntity {
    String pernr;
    String fechapago;
    String codigocc;
    String detallecodigocc;
    String importe;

    bool? showItem;

    AmountEntity({
        required this.pernr,
        required this.fechapago,
        required this.codigocc,
        required this.detallecodigocc,
        required this.importe,
        this.showItem = false,
    });

    factory AmountEntity.fromJson(Map<String, dynamic> json) => AmountEntity(
        pernr: json["Pernr"],
        fechapago: json["Fechapago"],
        codigocc: json["Codigocc"],
        detallecodigocc: json["Detallecodigocc"],
        importe: json["Importe"],
        showItem: json["showItem"],
    );

    Map<String, dynamic> toJson() => {
        "Pernr": pernr,
        "Fechapago": fechapago,
        "Codigocc": codigocc,
        "Detallecodigocc": detallecodigocc,
        "Importe": importe,
        "showItem": showItem,
    };
}

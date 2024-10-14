
import 'dart:convert';

import 'package:utils/utils.dart';

PendienteEntity pendienteEntityFromJson(String str) => PendienteEntity.fromJson(json.decode(str));

String pendienteEntityToJson(PendienteEntity data) => json.encode(data.toJson());

class PendienteEntity {
    String? codigosap;
    int id;
    String codigo;
    String? nomcomp;
    String fechasolicitud;
    double importe;
    String codigoestado;
    String detalleestado;
    String? area;
    double? importeTotal;

    PendienteEntity({
        this.codigosap,
        required this.id,
        required this.codigo,
        this.nomcomp,
        required this.fechasolicitud,
        required this.importe,
        required this.codigoestado,
        required this.detalleestado,
        this.area,
        this.importeTotal = 0,
    });

    get imagenEstado {
      switch(codigoestado.toUpperCase()){
        case 'P': 
          return 'assets/images/pending_state.png';
        case 'A':
          return 'assets/images/check_state.png';
        case 'R':
          return 'assets/images/rejected_state.png';
        case 'C':
          return 'assets/images/completed_state.png';
        default: 
          return 'assets/images/completed_state.png';
      }
    }

    get colorState {
      switch(codigoestado.toUpperCase()){
        case 'P': 
          return alertColor();
        case 'A':
          return successColor();
        case 'R':
          return dangerColor();
        case 'C':
          return infoColor();
        default: 
          return infoColor();
      }
    }

    factory PendienteEntity.fromJson(Map<String, dynamic> json) => PendienteEntity(
        codigosap: json["codigosap"],
        id: json["id"],
        codigo: json["codigo"],
        nomcomp: json["nomcomp"],
        fechasolicitud: json["fechasolicitud"],
        importe: double.tryParse(json["importe"]) ?? 0,
        codigoestado: json["codigoestado"],
        detalleestado: json["detalleestado"],
        area: json["area"],
        importeTotal: (json['importeTotal'] == null) ? null : json["importeTotal"],
    );

    Map<String, dynamic> toJson() => {
        "codigosap": codigosap,
        "id": id,
        "codigo": codigo,
        "nomcomp": nomcomp,
        "fechasolicitud": fechasolicitud,
        "importe": importe,
        "codigoestado": codigoestado,
        "detalleestado": detalleestado,
        "area": area,
        "importeTotal": importeTotal,
    };
}
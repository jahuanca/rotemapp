
import 'dart:convert';

UserEntity userEntityFromJson(String str) => UserEntity.fromJson(json.decode(str));

String userEntityToJson(UserEntity data) => json.encode(data.toJson());


class UserEntity {
    String iusuario;
    String iclave;
    int id;
    String usuario;
    String clave;
    String email;
    String pernr;
    String nomcomp;
    int codigoperfil;
    String detalleperfil;
    String uname;
    String fechamod;

    UserEntity({
        required this.iusuario,
        required this.iclave,
        required this.id,
        required this.usuario,
        required this.clave,
        required this.email,
        required this.pernr,
        required this.nomcomp,
        required this.codigoperfil,
        required this.detalleperfil,
        required this.uname,
        required this.fechamod,
    });

    factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        iusuario: json["iusuario"],
        iclave: json["iclave"],
        id: json["id"],
        usuario: json["usuario"],
        clave: json["clave"],
        email: json["email"],
        pernr: json["pernr"],
        nomcomp: json["nomcomp"],
        codigoperfil: json["codigoperfil"],
        detalleperfil: json["detalleperfil"],
        uname: json["uname"],
        fechamod: json["fechamod"],
    );

    Map<String, dynamic> toJson() => {
        "iusuario": iusuario,
        "iclave": iclave,
        "id": id,
        "usuario": usuario,
        "clave": clave,
        "email": email,
        "pernr": pernr,
        "nomcomp": nomcomp,
        "codigoperfil": codigoperfil,
        "detalleperfil": detalleperfil,
        "uname": uname,
        "fechamod": fechamod,
    };
}
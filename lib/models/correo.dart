import 'dart:convert';

class Correo {
  Correo({
    this.codEmp = "",
    this.codRef = "",
    this.datCli = "",
    this.ordena = 0,
    this.corTel = "",
    this.activo = "",
  });

  String codEmp;
  String codRef;
  String datCli;
  int ordena;
  String corTel;
  String activo;

  factory Correo.fromJson(String str) => Correo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Correo.fromMap(Map<String, dynamic> json) => Correo(
        codEmp: json["cod_emp"],
        codRef: json["cod_ref"],
        datCli: json["dat_cli"],
        ordena: json["ordena"],
        corTel: json["cor_tel"],
        activo: json["activo"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_ref": codRef,
        "dat_cli": datCli,
        "ordena": ordena,
        "cor_tel": corTel,
        "activo": activo,
      };
}

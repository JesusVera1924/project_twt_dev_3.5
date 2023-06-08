import 'dart:convert';

class Usuario {
  Usuario({
    required this.codEmp,
    required this.codPry,
    required this.codUsr,
    required this.nomUsr,
    required this.clvUsr,
    required this.ctaUsr,
    required this.nicUsr,
    required this.corUsr,
    required this.celUsr,
    required this.rolUsr,
    required this.clsUsr,
    required this.fexUsr,
    required this.stsUsr,
  });

  String codEmp;
  String codPry;
  String codUsr;
  String nomUsr;
  String clvUsr;
  String ctaUsr;
  String nicUsr;
  String corUsr;
  String celUsr;
  String rolUsr;
  String clsUsr;
  DateTime fexUsr;
  String stsUsr;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        codEmp: json["cod_emp"],
        codPry: json["cod_pry"],
        codUsr: json["cod_usr"],
        nomUsr: json["nom_usr"],
        clvUsr: json["clv_usr"],
        ctaUsr: json["cta_usr"],
        nicUsr: json["nic_usr"],
        corUsr: json["cor_usr"],
        celUsr: json["cel_usr"],
        rolUsr: json["rol_usr"],
        clsUsr: json["cls_usr"],
        fexUsr: DateTime.parse(json["fex_usr"]),
        stsUsr: json["sts_usr"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pry": codPry,
        "cod_usr": codUsr,
        "nom_usr": nomUsr,
        "clv_usr": clvUsr,
        "cta_usr": ctaUsr,
        "nic_usr": nicUsr,
        "cor_usr": corUsr,
        "cel_usr": celUsr,
        "rol_usr": rolUsr,
        "cls_usr": clsUsr,
        "fex_usr": fexUsr.toIso8601String(),
        "sts_usr": stsUsr,
      };
}

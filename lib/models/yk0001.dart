import 'dart:convert';

class Yk0001 {
  final String codEmp;
  final String grpYkk;
  final String codYkk;
  final String nomYkk;
  final String codUsr;
  final String filtrar;
  final String omision;

  Yk0001({
    required this.codEmp,
    required this.grpYkk,
    required this.codYkk,
    required this.nomYkk,
    required this.codUsr,
    required this.filtrar,
    required this.omision,
  });

  factory Yk0001.fromJson(String str) => Yk0001.fromJson(json.decode(str));

  String toJson() => json.encode(toJson());

  factory Yk0001.fromMap(Map<String, dynamic> json) => Yk0001(
        codEmp: json["cod_emp"],
        grpYkk: json["grp_ykk"],
        codYkk: json["cod_ykk"],
        nomYkk: json["nom_ykk"],
        codUsr: json["cod_usr"],
        filtrar: json["filtrar"],
        omision: json["omision"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "grp_ykk": grpYkk,
        "cod_ykk": codYkk,
        "nom_ykk": nomYkk,
        "cod_usr": codUsr,
        "filtrar": filtrar,
        "omision": omision,
      };
}

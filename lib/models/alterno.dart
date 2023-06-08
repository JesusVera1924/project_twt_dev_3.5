import 'dart:convert';

class Alterno {
  Alterno({
    required this.codAlt,
    required this.codEmp,
    required this.codPro,
    required this.ordAlt,
  });

  String codAlt;
  String codEmp;
  String codPro;
  int ordAlt;

  factory Alterno.fromJson(String str) => Alterno.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alterno.fromMap(Map<String, dynamic> json) => Alterno(
        codAlt: json["cod_alt"],
        codEmp: json["cod_emp"],
        codPro: json["cod_pro"],
        ordAlt: json["ord_alt"],
      );

  Map<String, dynamic> toMap() => {
        "cod_alt": codAlt,
        "cod_emp": codEmp,
        "cod_pro": codPro,
        "ord_alt": ordAlt,
      };
}

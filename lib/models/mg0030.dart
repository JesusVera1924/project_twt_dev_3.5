import 'dart:convert';

class Mg0030 {
  Mg0030({
    required this.cIOcg,
    required this.codOcg,
    required this.nomOcg,
  });

  String cIOcg;
  String codOcg;
  String nomOcg;

  factory Mg0030.fromJson(String str) => Mg0030.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mg0030.fromMap(Map<String, dynamic> json) => Mg0030(
        cIOcg: json["c_i_ocg"],
        codOcg: json["cod_ocg"],
        nomOcg: json["nom_ocg"],
      );

  Map<String, dynamic> toMap() => {
        "c_i_ocg": cIOcg,
        "cod_ocg": codOcg,
        "nom_ocg": nomOcg,
      };
}

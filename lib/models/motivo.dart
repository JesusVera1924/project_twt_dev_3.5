import 'dart:convert';

class Motivo {
  Motivo({
    required this.cICmg,
    required this.codCmg,
    required this.nomCmg,
    required this.numMes,
  });

  String cICmg;
  String codCmg;
  String nomCmg;
  double numMes;

  factory Motivo.fromJson(String str) => Motivo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Motivo.fromMap(Map<String, dynamic> json) => Motivo(
        cICmg: json["c_i_cmg"],
        codCmg: json["cod_cmg"],
        nomCmg: json["nom_cmg"],
        numMes: json["num_mes"],
      );

  Map<String, dynamic> toMap() => {
        "c_i_cmg": cICmg,
        "cod_cmg": codCmg,
        "nom_cmg": nomCmg,
        "num_mes": numMes,
      };

  @override
  String toString() {
    return nomCmg;
  }

  @override
  int get hashCode => super.hashCode;
}

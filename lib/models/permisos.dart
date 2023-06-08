import 'dart:convert';

class Permisos {
  Permisos({
    required this.codUsr,
    required this.perAcc,
    required this.codPry,
    required this.nomPry,
    required this.clsPry,
    required this.hpvPry,
    required this.clxPry,
    required this.idxPry,
    required this.rtxPry,
    required this.l01Pry,
    required this.l02Pry,
    required this.stsPry,
    required this.rolUsr,
  });

  String codUsr;
  String perAcc;
  String codPry;
  String nomPry;
  String clsPry;
  String hpvPry;
  String clxPry;
  int idxPry;
  String rtxPry;
  String l01Pry;
  String l02Pry;
  String stsPry;
  String rolUsr;

  factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
        codUsr: json["cod_usr"],
        perAcc: json["per_acc"],
        codPry: json["cod_pry"],
        nomPry: json["nom_pry"],
        clsPry: json["cls_pry"],
        hpvPry: json["hpv_pry"],
        clxPry: json["clx_pry"],
        idxPry: json["idx_pry"],
        rtxPry: json["rtx_pry"],
        l01Pry: json["l01_pry"],
        l02Pry: json["l02_pry"],
        stsPry: json["sts_pry"],
        rolUsr: json["rol_usr"],
      );

  Map<String, dynamic> toMap() => {
        "cod_usr": codUsr,
        "per_acc": perAcc,
        "cod_pry": codPry,
        "nom_pry": nomPry,
        "cls_pry": clsPry,
        "hpv_pry": hpvPry,
        "clx_pry": clxPry,
        "idx_pry": idxPry,
        "rtx_pry": rtxPry,
        "l01_pry": l01Pry,
        "l02_pry": l02Pry,
        "sts_pry": stsPry,
        "rol_usr": rolUsr,
      };
}

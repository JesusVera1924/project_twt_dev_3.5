import 'dart:convert';

class Kardex {
  Kardex({
    required this.codEmp,
    required this.codPto,
    required this.clsSdv,
    required this.codMov,
    required this.numMov,
    required this.fecMov,
    required this.codRel,
    required this.numRel,
    required this.fecRel,
    required this.codRef,
    required this.nomRef,
    required this.codPro,
    required this.codBod,
    required this.canMov,
    required this.pacCos,
    required this.vacCos,
    required this.codMdm,
    required this.obsMdm,
    required this.obsMov,
    required this.ucrMov,
    required this.dcrMov,
    required this.uacMov,
    required this.dacMov,
    required this.somMov,
    required this.stsMov,
  });

  String codEmp;
  String codPto;
  String clsSdv;
  String codMov;
  String numMov;
  DateTime fecMov;
  String codRel;
  String numRel;
  DateTime fecRel;
  String codRef;
  String nomRef;
  String codPro;
  String codBod;
  double canMov;
  double pacCos;
  double vacCos;
  String codMdm;
  String obsMdm;
  String obsMov;
  String ucrMov;
  DateTime dcrMov;
  String uacMov;
  DateTime dacMov;
  String somMov;
  String stsMov;

  factory Kardex.fromJson(String str) => Kardex.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Kardex.fromMap(Map<String, dynamic> json) => Kardex(
        codEmp: json["cod_emp"],
        codPto: json["cod_pto"],
        clsSdv: json["cls_sdv"],
        codMov: json["cod_mov"],
        numMov: json["num_mov"],
        fecMov: DateTime.parse(json["fec_mov"]),
        codRel: json["cod_rel"],
        numRel: json["num_rel"],
        fecRel: DateTime.parse(json["fec_rel"]),
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        codPro: json["cod_pro"],
        codBod: json["cod_bod"],
        canMov: json["can_mov"].toDouble(),
        pacCos: json["pac_cos"].toDouble(),
        vacCos: json["vac_cos"].toDouble(),
        codMdm: json["cod_mdm"],
        obsMdm: json["obs_mdm"],
        obsMov: json["obs_mov"],
        ucrMov: json["ucr_mov"],
        dcrMov: DateTime.parse(json["dcr_mov"]),
        uacMov: json["uac_mov"],
        dacMov: DateTime.parse(json["dac_mov"]),
        somMov: json["som_mov"],
        stsMov: json["sts_mov"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pto": codPto,
        "cls_sdv": clsSdv,
        "cod_mov": codMov,
        "num_mov": numMov,
        "fec_mov": fecMov.toIso8601String(),
        "cod_rel": codRel,
        "num_rel": numRel,
        "fec_rel": fecRel.toIso8601String(),
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "cod_pro": codPro,
        "cod_bod": codBod,
        "can_mov": canMov,
        "pac_cos": pacCos,
        "vac_cos": vacCos,
        "cod_mdm": codMdm,
        "obs_mdm": obsMdm,
        "obs_mov": obsMov,
        "ucr_mov": ucrMov,
        "dcr_mov": dcrMov.toIso8601String(),
        "uac_mov": uacMov,
        "dac_mov": dacMov.toIso8601String(),
        "som_mov": somMov,
        "sts_mov": stsMov,
      };
}

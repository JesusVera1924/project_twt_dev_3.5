import 'dart:convert';

class InvoiceDetail {
  InvoiceDetail({
    this.codEmp = "",
    this.codPto = "",
    this.codMov = "",
    this.numMov = "",
    this.fecMov = "",
    this.codRel = "",
    this.numRel = "",
    this.fecRel = "",
    this.codRef = "",
    this.nomRef = "",
    this.codPro = "",
    this.codBod = "",
    this.canMov = 0.0,
    this.pacLis = 0.0,
    this.vacLis = 0.0,
    this.pacCos = 0.0,
    this.vacCos = 0.0,
    this.pacVen = 0.0,
    this.vacVen = 0.0,
    this.clsDs1 = "",
    this.prcDs1 = 0.0,
    this.vacDs1 = 0.0,
    this.clsDs2 = "",
    this.prcDs2 = 0.0,
    this.vacDs2 = 0.0,
    this.vacDsc = 0.0,
    this.vacPr1 = 0.0,
    this.vacPr2 = 0.0,
    this.vacPar = 0.0,
    this.cargado = "",
    this.cruzado = "",
    this.aplicar = 0.0,
    this.auxilia = "",
    this.precios = "",
    this.codMdm = "",
    this.obsMdm = "",
    this.codDiv = "",
    this.cotDiv = 0.0,
    this.stsMov = "",
    this.codUsr = "",
  });

  String codEmp;
  String codPto;
  String codMov;
  String numMov;
  String fecMov;
  String codRel;
  String numRel;
  String fecRel;
  String codRef;
  String nomRef;
  String codPro;
  String codBod;
  double canMov;
  double pacLis;
  double vacLis;
  double pacCos;
  double vacCos;
  double pacVen;
  double vacVen;
  String clsDs1;
  double prcDs1;
  double vacDs1;
  String clsDs2;
  double prcDs2;
  double vacDs2;
  double vacDsc;
  double vacPr1;
  double vacPr2;
  double vacPar;
  String cargado;
  String cruzado;
  double aplicar;
  String auxilia;
  String precios;
  String codMdm;
  String obsMdm;
  String codDiv;
  double cotDiv;
  String stsMov;
  String codUsr;

  factory InvoiceDetail.fromJson(String str) =>
      InvoiceDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvoiceDetail.fromMap(Map<String, dynamic> json) => InvoiceDetail(
        codEmp: json["cod_emp"],
        codPto: json["cod_pto"],
        codMov: json["cod_mov"],
        numMov: json["num_mov"],
        fecMov: json["fec_mov"],
        codRel: json["cod_rel"],
        numRel: json["num_rel"],
        fecRel: json["fec_rel"],
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        codPro: json["cod_pro"],
        codBod: json["cod_bod"],
        canMov: json["can_mov"],
        pacLis: json["pac_lis"].toDouble(),
        vacLis: json["vac_lis"].toDouble(),
        pacCos: json["pac_cos"].toDouble(),
        vacCos: json["vac_cos"].toDouble(),
        pacVen: json["pac_ven"].toDouble(),
        vacVen: json["vac_ven"].toDouble(),
        clsDs1: json["cls_ds1"],
        prcDs1: json["prc_ds1"].toDouble(),
        vacDs1: json["vac_ds1"].toDouble(),
        clsDs2: json["cls_ds2"],
        prcDs2: json["prc_ds2"],
        vacDs2: json["vac_ds2"].toDouble(),
        vacDsc: json["vac_dsc"].toDouble(),
        vacPr1: json["vac_pr1"].toDouble(),
        vacPr2: json["vac_pr2"].toDouble(),
        vacPar: json["vac_par"].toDouble(),
        cargado: json["cargado"],
        cruzado: json["cruzado"],
        aplicar: json["aplicar"],
        auxilia: json["auxilia"],
        precios: json["precios"],
        codMdm: json["cod_mdm"],
        obsMdm: json["obs_mdm"],
        codDiv: json["cod_div"],
        cotDiv: json["cot_div"],
        stsMov: json["sts_mov"],
        codUsr: json["cod_usr"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pto": codPto,
        "cod_mov": codMov,
        "num_mov": numMov,
        "fec_mov": fecMov,
        "cod_rel": codRel,
        "num_rel": numRel,
        "fec_rel": fecRel,
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "cod_pro": codPro,
        "cod_bod": codBod,
        "can_mov": canMov,
        "pac_lis": pacLis,
        "vac_lis": vacLis,
        "pac_cos": pacCos,
        "vac_cos": vacCos,
        "pac_ven": pacVen,
        "vac_ven": vacVen,
        "cls_ds1": clsDs1,
        "prc_ds1": prcDs1,
        "vac_ds1": vacDs1,
        "cls_ds2": clsDs2,
        "prc_ds2": prcDs2,
        "vac_ds2": vacDs2,
        "vac_dsc": vacDsc,
        "vac_pr1": vacPr1,
        "vac_pr2": vacPr2,
        "vac_par": vacPar,
        "cargado": cargado,
        "cruzado": cruzado,
        "aplicar": aplicar,
        "auxilia": auxilia,
        "precios": precios,
        "cod_mdm": codMdm,
        "obs_mdm": obsMdm,
        "cod_div": codDiv,
        "cot_div": cotDiv,
        "sts_mov": stsMov,
        "cod_usr": codUsr,
      };

  @override
  String toString() {
    return numMov;
  }
}

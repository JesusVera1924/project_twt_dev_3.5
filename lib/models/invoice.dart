// To parse this JSON data, do
//
//     final invoice = invoiceFromMap(jsonString);

import 'dart:convert';

class Invoice {
  Invoice({
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
    this.dirRef = "",
    this.codVen = "",
    this.dscGen = 0,
    this.ivaGen = 0,
    this.precios = "",
    this.codOrd = "",
    this.numOrd = "",
    this.totCos = 0,
    this.totI00 = 0,
    this.totI12 = 0,
    this.totMov = 0,
    this.totDs1 = 0,
    this.totDs2 = 0,
    this.totDsc = 0,
    this.totPr1 = 0,
    this.totPr2 = 0,
    this.totPar = 0,
    this.totIva = 0,
    this.totTra = 0,
    this.totVar = 0,
    this.totNet = 0,
    this.tipovta = "",
    this.cancela = "",
    this.plzPag = 0,
    this.conPag = "",
    this.obsMov = "",
    this.codNex = "",
    this.numNex = "",
    this.alertar = "",
    this.codDiv = "",
    this.cotDiv = 0,
    this.prtMov = 0,
    this.sriMov = "",
    this.stsMov = "",
    this.mt1Mov = 0,
    this.mt2Mov = 0,
    this.codUsr = "",
    this.ucrMov = "",
    this.fcrMov = "",
    this.uauMov = "",
    this.fauMov,
  });

  String codEmp;
  String codPto;
  String codMov;
  String numMov;
  String fecMov;
  String codRel;
  String numRel;
  dynamic fecRel;
  String codRef;
  String nomRef;
  String dirRef;
  String codVen;
  double dscGen;
  double ivaGen;
  String precios;
  String codOrd;
  String numOrd;
  double totCos;
  double totI00;
  double totI12;
  double totMov;
  double totDs1;
  double totDs2;
  double totDsc;
  double totPr1;
  double totPr2;
  double totPar;
  double totIva;
  double totTra;
  double totVar;
  double totNet;
  String tipovta;
  String cancela;
  int plzPag;
  String conPag;
  String obsMov;
  String codNex;
  String numNex;
  String alertar;
  String codDiv;
  double cotDiv;
  int prtMov;
  String sriMov;
  String stsMov;
  int mt1Mov;
  int mt2Mov;
  String codUsr;
  String ucrMov;
  String fcrMov;
  String uauMov;
  dynamic fauMov;

  factory Invoice.fromJson(String str) => Invoice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Invoice.fromMap(Map<String, dynamic> json) => Invoice(
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
        dirRef: json["dir_ref"],
        codVen: json["cod_ven"],
        dscGen: json["dsc_gen"].toDouble(),
        ivaGen: json["iva_gen"].toDouble(),
        precios: json["precios"],
        codOrd: json["cod_ord"],
        numOrd: json["num_ord"],
        totCos: json["tot_cos"].toDouble(),
        totI00: json["tot_i00"].toDouble(),
        totI12: json["tot_i12"].toDouble(),
        totMov: json["tot_mov"].toDouble(),
        totDs1: json["tot_ds1"].toDouble(),
        totDs2: json["tot_ds2"].toDouble(),
        totDsc: json["tot_dsc"].toDouble(),
        totPr1: json["tot_pr1"].toDouble(),
        totPr2: json["tot_pr2"].toDouble(),
        totPar: json["tot_par"].toDouble(),
        totIva: json["tot_iva"].toDouble(),
        totTra: json["tot_tra"].toDouble(),
        totVar: json["tot_var"].toDouble(),
        totNet: json["tot_net"].toDouble(),
        tipovta: json["tipovta"],
        cancela: json["cancela"],
        plzPag: json["plz_pag"],
        conPag: json["con_pag"],
        obsMov: json["obs_mov"],
        codNex: json["cod_nex"],
        numNex: json["num_nex"],
        alertar: json["alertar"],
        codDiv: json["cod_div"],
        cotDiv: json["cot_div"].toDouble(),
        prtMov: json["prt_mov"],
        sriMov: json["sri_mov"],
        stsMov: json["sts_mov"],
        mt1Mov: json["mt1_mov"],
        mt2Mov: json["mt2_mov"],
        codUsr: json["cod_usr"],
        ucrMov: json["ucr_mov"],
        fcrMov: json["fcr_mov"],
        uauMov: json["uau_mov"],
        fauMov: json["fau_mov"],
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
        "dir_ref": dirRef,
        "cod_ven": codVen,
        "dsc_gen": dscGen,
        "iva_gen": ivaGen,
        "precios": precios,
        "cod_ord": codOrd,
        "num_ord": numOrd,
        "tot_cos": totCos,
        "tot_i00": totI00,
        "tot_i12": totI12,
        "tot_mov": totMov,
        "tot_ds1": totDs1,
        "tot_ds2": totDs2,
        "tot_dsc": totDsc,
        "tot_pr1": totPr1,
        "tot_pr2": totPr2,
        "tot_par": totPar,
        "tot_iva": totIva,
        "tot_tra": totTra,
        "tot_var": totVar,
        "tot_net": totNet,
        "tipovta": tipovta,
        "cancela": cancela,
        "plz_pag": plzPag,
        "con_pag": conPag,
        "obs_mov": obsMov,
        "cod_nex": codNex,
        "num_nex": numNex,
        "alertar": alertar,
        "cod_div": codDiv,
        "cot_div": cotDiv,
        "prt_mov": prtMov,
        "sri_mov": sriMov,
        "sts_mov": stsMov,
        "mt1_mov": mt1Mov,
        "mt2_mov": mt2Mov,
        "cod_usr": codUsr,
        "ucr_mov": ucrMov,
        "fcr_mov": fcrMov,
        "uau_mov": uauMov,
        "fau_mov": fauMov,
      };
}

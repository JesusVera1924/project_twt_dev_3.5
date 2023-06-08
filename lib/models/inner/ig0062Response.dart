import 'dart:convert';

class Ig0062Response {
  Ig0062Response({
    this.codEmp = "",
    this.numSdv = "",
    this.fecSdv = "",
    this.nunSdv = "",
    this.frmSdv = "",
    this.codRef = "",
    this.codVen = "",
    this.codPto = "",
    this.codMov = "",
    this.numMov = "",
    this.fecMov = "",
    this.secMov = 0,
    this.codPro = "",
    this.canSdv = 0,
    this.canMov = 0,
    this.clsMdm = "",
    this.codMdm = "",
    this.obsMdm = "",
    this.ofsSdv = "",
    this.obsSdv = "",
    this.codCop = "",
    this.nomCop = "",
    this.ngrCop = "",
    this.fgrCop = "",
    this.bltCop = 0,
    this.destino = "",
    this.ptoRel = "",
    this.codRel = "",
    this.numRel = "",
    this.fecRel = "",
    this.ptoNex = "",
    this.codNex = "",
    this.numNex = "",
    this.fecNex = "",
    this.swsSdv = "",
    this.uarSdv = "",
    this.farSdv = "",
    this.ucrSdv = "",
    this.fcrSdv = "",
    this.uacSdv = "",
    this.facSdv = "",
    this.uapSdv = "",
    this.fapSdv = "",
    this.stsSdv = "",
    this.cliente = "",
    this.vendedor = "",
    this.kd1Mdm = "",
    this.contar = 0,
  });

  String codEmp;
  String numSdv;
  String fecSdv;
  String nunSdv;
  String frmSdv;
  String codRef;
  String codVen;
  String codPto;
  String codMov;
  String numMov;
  String fecMov;
  int secMov;
  String codPro;
  double canSdv;
  double canMov;
  String clsMdm;
  String codMdm;
  String obsMdm;
  String ofsSdv;
  String obsSdv;
  String codCop;
  String nomCop;
  String ngrCop;
  dynamic fgrCop;
  double bltCop;
  String destino;
  String ptoRel;
  String codRel;
  String numRel;
  String fecRel;
  String ptoNex;
  String codNex;
  String numNex;
  String fecNex;
  String swsSdv;
  String uarSdv;
  String farSdv;
  String ucrSdv;
  String fcrSdv;
  String uacSdv;
  String facSdv;
  String uapSdv;
  String fapSdv;
  String stsSdv;
  String cliente;
  String vendedor;
  String kd1Mdm;
  int contar;

  factory Ig0062Response.fromJson(String str) =>
      Ig0062Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ig0062Response.fromMap(Map<String, dynamic> json) => Ig0062Response(
      codEmp: json["cod_emp"],
      numSdv: json["num_sdv"],
      fecSdv: json["fec_sdv"],
      nunSdv: json["nun_sdv"],
      frmSdv: json["frm_sdv"],
      codRef: json["cod_ref"],
      codVen: json["cod_ven"],
      codPto: json["cod_pto"],
      codMov: json["cod_mov"],
      numMov: json["num_mov"],
      fecMov: json["fec_mov"],
      secMov: json["sec_mov"],
      codPro: json["cod_pro"],
      canMov: json["can_mov"],
      canSdv: json["can_sdv"],
      clsMdm: json["cls_mdm"],
      codMdm: json["cod_mdm"],
      obsMdm: json["obs_mdm"],
      ofsSdv: json["ofs_sdv"],
      obsSdv: json["obs_sdv"],
      codCop: json["cod_cop"],
      nomCop: json["nom_cop"],
      ngrCop: json["ngr_cop"],
      fgrCop: json["fgr_cop"],
      bltCop: json["blt_cop"].toDouble(),
      destino: json["destino"],
      ptoRel: json["pto_rel"],
      codRel: json["cod_rel"],
      numRel: json["num_rel"],
      fecRel: json["fec_rel"],
      ptoNex: json["pto_nex"],
      codNex: json["cod_nex"],
      numNex: json["num_nex"],
      fecNex: json["fec_nex"],
      swsSdv: json["sws_sdv"],
      uarSdv: json["uar_sdv"],
      farSdv: json["far_sdv"],
      ucrSdv: json["ucr_sdv"],
      fcrSdv: json["fcr_sdv"],
      uacSdv: json["uac_sdv"],
      facSdv: json["fac_sdv"],
      uapSdv: json["uap_sdv"],
      fapSdv: json["fap_sdv"],
      stsSdv: json["sts_sdv"],
      cliente: json["cliente"],
      vendedor: json["vendedor"],
      kd1Mdm: json["kd1_mdm"],
      contar: json["contar"]);

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "num_sdv": numSdv,
        "fec_sdv": fecSdv,
        "nun_sdv": nunSdv,
        "frm_sdv": frmSdv,
        "cod_ref": codRef,
        "cod_ven": codVen,
        "cod_pto": codPto,
        "cod_mov": codMov,
        "num_mov": numMov,
        "fec_mov": fecMov,
        "sec_mov": secMov,
        "cod_pro": codPro,
        "can_sdv": canSdv,
        "can_mov": canMov,
        "cls_mdm": clsMdm,
        "cod_mdm": codMdm,
        "obs_mdm": obsMdm,
        "ofs_sdv": ofsSdv,
        "obs_sdv": obsSdv,
        "cod_cop": codCop,
        "nom_cop": nomCop,
        "ngr_cop": ngrCop,
        "fgr_cop": fgrCop,
        "blt_cop": bltCop,
        "destino": destino,
        "pto_rel": ptoRel,
        "cod_rel": codRel,
        "num_rel": numRel,
        "fec_rel": fecRel,
        "pto_nex": ptoNex,
        "cod_nex": codNex,
        "num_nex": numNex,
        "fec_nex": fecNex,
        "sws_sdv": swsSdv,
        "uar_sdv": uarSdv,
        "far_sdv": farSdv,
        "ucr_sdv": ucrSdv,
        "fcr_sdv": fcrSdv,
        "uac_sdv": uacSdv,
        "fac_sdv": facSdv,
        "uap_sdv": uapSdv,
        "fap_sdv": fapSdv,
        "sts_sdv": stsSdv,
        "cliente": cliente,
        "vendedor": vendedor,
        "kd1_mdm": kd1Mdm,
        "contar": contar,
      };

  @override
  String toString() {
    return "numero de solicitud : $numSdv";
  }
}

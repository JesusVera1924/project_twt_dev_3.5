import 'dart:convert';

class Mg0031 {
  Mg0031({
    this.codEmp = "",
    this.codRef = "",
    this.clsNic = "",
    this.secNic = "",
    this.numSdc = "",
    this.fecSdc = "",
    this.fecAdm = "",
    this.plzSol = 0,
    this.mntSol = 0.0,
    this.codRtc = "",
    this.nomRef = "",
    this.nmcRef = "",
    this.dirRef = "",
    this.estRef = "",
    this.ciuRef = "",
    this.tlfRef = "",
    this.ce1Ref = "",
    this.ce2Ref = "",
    this.mv1Ref = "",
    this.nomPer = "",
    this.nicPer = "",
    this.dirPer = "",
    this.ciuPer = "",
    this.tlfPer = "",
    this.tltPer = "",
    this.ce1Per = "",
    this.mv1Per = "",
    this.ecrPer = "",
    this.nomCyg = "",
    this.nicCyg = "",
    this.ingMes = 0.0,
    this.gasMes = 0.0,
    this.oiaMes = "",
    this.tipRef = "",
    this.clsRef = "",
    this.locRef = "",
    this.tdsRef = "",
    this.dpnCcp = "0",
    this.dpnCcc = "0",
    this.dpnCrp = "0",
    this.dpnCpf = "0",
    this.dpnCsb = "0",
    this.dpjCre = "0",
    this.dpjCne = "0",
    this.dpjCge = "0",
    this.ct1Nom = "",
    this.ct1Crg = "",
    this.ct1Tlf = "",
    this.ct1Ext = "",
    this.ct1Cor = "",
    this.ct2Nom = "",
    this.ct2Crg = "",
    this.ct2Tlf = "",
    this.ct2Ext = "",
    this.ct2Cor = "",
    this.ct3Nom = "",
    this.ct3Crg = "",
    this.ct3Tlf = "",
    this.ct3Ext = "",
    this.ct3Cor = "",
    this.rb1Bco = "",
    this.rb1Agn = "",
    this.rb1Tlf = "",
    this.rb1Cta = "",
    this.rb1Tip = "",
    this.rb2Bco = "",
    this.rb2Agn = "",
    this.rb2Tlf = "",
    this.rb2Cta = "",
    this.rb2Tip = "",
    this.rb3Bco = "",
    this.rb3Agn = "",
    this.rb3Tlf = "",
    this.rb3Cta = "",
    this.rb3Tip = "",
    this.rc1Emp = "",
    this.rc1Ciu = "",
    this.rc1Tlf = "",
    this.rc1Fcr = "",
    this.rc1Vcr = 0,
    this.rc1Dcr = 0,
    this.rc1Ccr = 0,
    this.rc1Pcr = 0,
    this.rc1Fdp = "",
    this.rc1Chp = 0,
    this.rc1Mmc = 0,
    this.rc1Pdp = 0,
    this.rc2Emp = "",
    this.rc2Ciu = "",
    this.rc2Tlf = "",
    this.rc2Fcr = "",
    this.rc2Vcr = 0,
    this.rc2Dcr = 0,
    this.rc2Ccr = 0,
    this.rc2Pcr = 0,
    this.rc2Fdp = "",
    this.rc2Chp = 0,
    this.rc2Mmc = 0,
    this.rc2Pdp = 0,
    this.rc3Emp = "",
    this.rc3Ciu = "",
    this.rc3Tlf = "",
    this.rc3Fcr = "",
    this.rc3Vcr = 0,
    this.rc3Dcr = 0,
    this.rc3Ccr = 0,
    this.rc3Pcr = 0,
    this.rc3Fdp = "",
    this.rc3Chp = 0,
    this.rc3Mmc = 0,
    this.rc3Pdp = 0,
    this.rd1Nom = "",
    this.rd1Ubi = "",
    this.rd1Val = 0,
    this.rd1Hip = "",
    this.rd2Nom = "",
    this.rd2Ubi = "",
    this.rd2Val = 0,
    this.rd2Hip = "",
    this.rd3Nom = "",
    this.rd3Ubi = "",
    this.rd3Val = 0,
    this.rd3Hip = "",
    this.rf1Nom = "",
    this.rf1Nex = "",
    this.rf1Ciu = "",
    this.rf1Tlf = "",
    this.rf2Nom = "",
    this.rf2Nex = "",
    this.rf2Ciu = "",
    this.rf2Tlf = "",
    this.rf3Nom = "",
    this.rf3Nex = "",
    this.rf3Ciu = "",
    this.rf3Tlf = "",
    this.uapSdc = "",
    this.cupSdc = 0,
    this.plzSdc = 0,
    this.fdpSdc = "",
    this.clsSdc = "",
    this.ucrSdc = "",
    this.dcrSdc = "",
    this.uacSdc = "",
    this.dacSdc = "",
    this.ntsSdc = "",
    this.stsSdc = "",
  });

  String codEmp;
  String codRef;
  String clsNic;
  String secNic;
  String numSdc;
  String fecSdc;
  String fecAdm;
  int plzSol;
  double mntSol;
  String codRtc;
  String nomRef;
  String nmcRef;
  String dirRef;
  String estRef;
  String ciuRef;
  String tlfRef;
  String ce1Ref;
  String ce2Ref;
  String mv1Ref;
  String nomPer;
  String nicPer;
  String dirPer;
  String ciuPer;
  String tlfPer;
  String tltPer;
  String ce1Per;
  String mv1Per;
  String ecrPer;
  String nomCyg;
  String nicCyg;
  double ingMes;
  double gasMes;
  String oiaMes;
  String tipRef;
  String clsRef;
  String locRef;
  String tdsRef;
  String dpnCcp;
  String dpnCcc;
  String dpnCrp;
  String dpnCpf;
  String dpnCsb;
  String dpjCre;
  String dpjCne;
  String dpjCge;
  String ct1Nom;
  String ct1Crg;
  String ct1Tlf;
  String ct1Ext;
  String ct1Cor;
  String ct2Nom;
  String ct2Crg;
  String ct2Tlf;
  String ct2Ext;
  String ct2Cor;
  String ct3Nom;
  String ct3Crg;
  String ct3Tlf;
  String ct3Ext;
  String ct3Cor;
  String rb1Bco;
  String rb1Agn;
  String rb1Tlf;
  String rb1Cta;
  String rb1Tip;
  String rb2Bco;
  String rb2Agn;
  String rb2Tlf;
  String rb2Cta;
  String rb2Tip;
  String rb3Bco;
  String rb3Agn;
  String rb3Tlf;
  String rb3Cta;
  String rb3Tip;
  String rc1Emp;
  String rc1Ciu;
  String rc1Tlf;
  String rc1Fcr;
  double rc1Vcr;
  int rc1Dcr;
  double rc1Ccr;
  int rc1Pcr;
  String rc1Fdp;
  int rc1Chp;
  double rc1Mmc;
  double rc1Pdp;
  String rc2Emp;
  String rc2Ciu;
  String rc2Tlf;
  String rc2Fcr;
  double rc2Vcr;
  int rc2Dcr;
  double rc2Ccr;
  int rc2Pcr;
  String rc2Fdp;
  int rc2Chp;
  double rc2Mmc;
  double rc2Pdp;
  String rc3Emp;
  String rc3Ciu;
  String rc3Tlf;
  String rc3Fcr;
  double rc3Vcr;
  int rc3Dcr;
  double rc3Ccr;
  int rc3Pcr;
  String rc3Fdp;
  int rc3Chp;
  double rc3Mmc;
  double rc3Pdp;
  String rd1Nom;
  String rd1Ubi;
  double rd1Val;
  String rd1Hip;
  String rd2Nom;
  String rd2Ubi;
  double rd2Val;
  String rd2Hip;
  String rd3Nom;
  String rd3Ubi;
  double rd3Val;
  String rd3Hip;
  String rf1Nom;
  String rf1Nex;
  String rf1Ciu;
  String rf1Tlf;
  String rf2Nom;
  String rf2Nex;
  String rf2Ciu;
  String rf2Tlf;
  String rf3Nom;
  String rf3Nex;
  String rf3Ciu;
  String rf3Tlf;
  String uapSdc;
  double cupSdc;
  int plzSdc;
  String fdpSdc;
  String clsSdc;
  String ucrSdc;
  String dcrSdc;
  String uacSdc;
  String dacSdc;
  String ntsSdc;
  String stsSdc;

  factory Mg0031.fromJson(String str) => Mg0031.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mg0031.fromMap(Map<String, dynamic> json) => Mg0031(
        codEmp: json["cod_emp"],
        codRef: json["cod_ref"],
        clsNic: json["cls_nic"],
        secNic: json["sec_nic"],
        numSdc: json["num_sdc"],
        fecSdc: json["fec_sdc"],
        fecAdm: json["fec_adm"],
        plzSol: json["plz_sol"],
        mntSol: json["mnt_sol"].toDouble(),
        codRtc: json["cod_rtc"],
        nomRef: json["nom_ref"],
        nmcRef: json["nmc_ref"],
        dirRef: json["dir_ref"],
        estRef: json["est_ref"],
        ciuRef: json["ciu_ref"],
        tlfRef: json["tlf_ref"],
        ce1Ref: json["ce1_ref"],
        ce2Ref: json["ce2_ref"],
        mv1Ref: json["mv1_ref"],
        nomPer: json["nom_per"],
        nicPer: json["nic_per"],
        dirPer: json["dir_per"],
        ciuPer: json["ciu_per"],
        tlfPer: json["tlf_per"],
        tltPer: json["tlt_per"],
        ce1Per: json["ce1_per"],
        mv1Per: json["mv1_per"],
        ecrPer: json["ecr_per"],
        nomCyg: json["nom_cyg"],
        nicCyg: json["nic_cyg"],
        ingMes: json["ing_mes"].toDouble(),
        gasMes: json["gas_mes"].toDouble(),
        oiaMes: json["oia_mes"],
        tipRef: json["tip_ref"],
        clsRef: json["cls_ref"],
        locRef: json["loc_ref"],
        tdsRef: json["tds_ref"],
        dpnCcp: json["dpn_ccp"],
        dpnCcc: json["dpn_ccc"],
        dpnCrp: json["dpn_crp"],
        dpnCpf: json["dpn_cpf"],
        dpnCsb: json["dpn_csb"],
        dpjCre: json["dpj_cre"],
        dpjCne: json["dpj_cne"],
        dpjCge: json["dpj_cge"],
        ct1Nom: json["ct1_nom"],
        ct1Crg: json["ct1_crg"],
        ct1Tlf: json["ct1_tlf"],
        ct1Ext: json["ct1_ext"],
        ct1Cor: json["ct1_cor"],
        ct2Nom: json["ct2_nom"],
        ct2Crg: json["ct2_crg"],
        ct2Tlf: json["ct2_tlf"],
        ct2Ext: json["ct2_ext"],
        ct2Cor: json["ct2_cor"],
        ct3Nom: json["ct3_nom"],
        ct3Crg: json["ct3_crg"],
        ct3Tlf: json["ct3_tlf"],
        ct3Ext: json["ct3_ext"],
        ct3Cor: json["ct3_cor"],
        rb1Bco: json["rb1_bco"],
        rb1Agn: json["rb1_agn"],
        rb1Tlf: json["rb1_tlf"],
        rb1Cta: json["rb1_cta"],
        rb1Tip: json["rb1_tip"],
        rb2Bco: json["rb2_bco"],
        rb2Agn: json["rb2_agn"],
        rb2Tlf: json["rb2_tlf"],
        rb2Cta: json["rb2_cta"],
        rb2Tip: json["rb2_tip"],
        rb3Bco: json["rb3_bco"],
        rb3Agn: json["rb3_agn"],
        rb3Tlf: json["rb3_tlf"],
        rb3Cta: json["rb3_cta"],
        rb3Tip: json["rb3_tip"],
        rc1Emp: json["rc1_emp"],
        rc1Ciu: json["rc1_ciu"],
        rc1Tlf: json["rc1_tlf"],
        rc1Fcr: json["rc1_fcr"],
        rc1Vcr: json["rc1_vcr"].toDouble(),
        rc1Dcr: json["rc1_dcr"],
        rc1Ccr: json["rc1_ccr"].toDouble(),
        rc1Pcr: json["rc1_pcr"],
        rc1Fdp: json["rc1_fdp"],
        rc1Chp: json["rc1_chp"],
        rc1Mmc: json["rc1_mmc"].toDouble(),
        rc1Pdp: json["rc1_pdp"].toDouble(),
        rc2Emp: json["rc2_emp"],
        rc2Ciu: json["rc2_ciu"],
        rc2Tlf: json["rc2_tlf"],
        rc2Fcr: json["rc2_fcr"],
        rc2Vcr: json["rc2_vcr"].toDouble(),
        rc2Dcr: json["rc2_dcr"],
        rc2Ccr: json["rc2_ccr"].toDouble(),
        rc2Pcr: json["rc2_pcr"],
        rc2Fdp: json["rc2_fdp"],
        rc2Chp: json["rc2_chp"],
        rc2Mmc: json["rc2_mmc"].toDouble(),
        rc2Pdp: json["rc2_pdp"].toDouble(),
        rc3Emp: json["rc3_emp"],
        rc3Ciu: json["rc3_ciu"],
        rc3Tlf: json["rc3_tlf"],
        rc3Fcr: json["rc3_fcr"],
        rc3Vcr: json["rc3_vcr"].toDouble(),
        rc3Dcr: json["rc3_dcr"],
        rc3Ccr: json["rc3_ccr"].toDouble(),
        rc3Pcr: json["rc3_pcr"],
        rc3Fdp: json["rc3_fdp"],
        rc3Chp: json["rc3_chp"],
        rc3Mmc: json["rc3_mmc"].toDouble(),
        rc3Pdp: json["rc3_pdp"].toDouble(),
        rd1Nom: json["rd1_nom"],
        rd1Ubi: json["rd1_ubi"],
        rd1Val: json["rd1_val"].toDouble(),
        rd1Hip: json["rd1_hip"],
        rd2Nom: json["rd2_nom"],
        rd2Ubi: json["rd2_ubi"],
        rd2Val: json["rd2_val"].toDouble(),
        rd2Hip: json["rd2_hip"],
        rd3Nom: json["rd3_nom"],
        rd3Ubi: json["rd3_ubi"],
        rd3Val: json["rd3_val"].toDouble(),
        rd3Hip: json["rd3_hip"],
        rf1Nom: json["rf1_nom"],
        rf1Nex: json["rf1_nex"],
        rf1Ciu: json["rf1_ciu"],
        rf1Tlf: json["rf1_tlf"],
        rf2Nom: json["rf2_nom"],
        rf2Nex: json["rf2_nex"],
        rf2Ciu: json["rf2_ciu"],
        rf2Tlf: json["rf2_tlf"],
        rf3Nom: json["rf3_nom"],
        rf3Nex: json["rf3_nex"],
        rf3Ciu: json["rf3_ciu"],
        rf3Tlf: json["rf3_tlf"],
        uapSdc: json["uap_sdc"],
        cupSdc: json["cup_sdc"].toDouble(),
        plzSdc: json["plz_sdc"],
        fdpSdc: json["fdp_sdc"],
        clsSdc: json["cls_sdc"],
        ucrSdc: json["ucr_sdc"],
        dcrSdc: json["dcr_sdc"],
        uacSdc: json["uac_sdc"],
        dacSdc: json["dac_sdc"],
        ntsSdc: json["nts_sdc"],
        stsSdc: json["sts_sdc"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_ref": codRef,
        "cls_nic": clsNic,
        "sec_nic": secNic,
        "num_sdc": numSdc,
        "fec_sdc": fecSdc,
        "fec_adm": fecAdm,
        "plz_sol": plzSol,
        "mnt_sol": mntSol,
        "cod_rtc": codRtc,
        "nom_ref": nomRef,
        "nmc_ref": nmcRef,
        "dir_ref": dirRef,
        "est_ref": estRef,
        "ciu_ref": ciuRef,
        "tlf_ref": tlfRef,
        "ce1_ref": ce1Ref,
        "ce2_ref": ce2Ref,
        "mv1_ref": mv1Ref,
        "nom_per": nomPer,
        "nic_per": nicPer,
        "dir_per": dirPer,
        "ciu_per": ciuPer,
        "tlf_per": tlfPer,
        "tlt_per": tltPer,
        "ce1_per": ce1Per,
        "mv1_per": mv1Per,
        "ecr_per": ecrPer,
        "nom_cyg": nomCyg,
        "nic_cyg": nicCyg,
        "ing_mes": ingMes,
        "gas_mes": gasMes,
        "oia_mes": oiaMes,
        "tip_ref": tipRef,
        "cls_ref": clsRef,
        "loc_ref": locRef,
        "tds_ref": tdsRef,
        "dpn_ccp": dpnCcp,
        "dpn_ccc": dpnCcc,
        "dpn_crp": dpnCrp,
        "dpn_cpf": dpnCpf,
        "dpn_csb": dpnCsb,
        "dpj_cre": dpjCre,
        "dpj_cne": dpjCne,
        "dpj_cge": dpjCge,
        "ct1_nom": ct1Nom,
        "ct1_crg": ct1Crg,
        "ct1_tlf": ct1Tlf,
        "ct1_ext": ct1Ext,
        "ct1_cor": ct1Cor,
        "ct2_nom": ct2Nom,
        "ct2_crg": ct2Crg,
        "ct2_tlf": ct2Tlf,
        "ct2_ext": ct2Ext,
        "ct2_cor": ct2Cor,
        "ct3_nom": ct3Nom,
        "ct3_crg": ct3Crg,
        "ct3_tlf": ct3Tlf,
        "ct3_ext": ct3Ext,
        "ct3_cor": ct3Cor,
        "rb1_bco": rb1Bco,
        "rb1_agn": rb1Agn,
        "rb1_tlf": rb1Tlf,
        "rb1_cta": rb1Cta,
        "rb1_tip": rb1Tip,
        "rb2_bco": rb2Bco,
        "rb2_agn": rb2Agn,
        "rb2_tlf": rb2Tlf,
        "rb2_cta": rb2Cta,
        "rb2_tip": rb2Tip,
        "rb3_bco": rb3Bco,
        "rb3_agn": rb3Agn,
        "rb3_tlf": rb3Tlf,
        "rb3_cta": rb3Cta,
        "rb3_tip": rb3Tip,
        "rc1_emp": rc1Emp,
        "rc1_ciu": rc1Ciu,
        "rc1_tlf": rc1Tlf,
        "rc1_fcr": rc1Fcr,
        "rc1_vcr": rc1Vcr,
        "rc1_dcr": rc1Dcr,
        "rc1_ccr": rc1Ccr,
        "rc1_pcr": rc1Pcr,
        "rc1_fdp": rc1Fdp,
        "rc1_chp": rc1Chp,
        "rc1_mmc": rc1Mmc,
        "rc1_pdp": rc1Pdp,
        "rc2_emp": rc2Emp,
        "rc2_ciu": rc2Ciu,
        "rc2_tlf": rc2Tlf,
        "rc2_fcr": rc2Fcr,
        "rc2_vcr": rc2Vcr,
        "rc2_dcr": rc2Dcr,
        "rc2_ccr": rc2Ccr,
        "rc2_pcr": rc2Pcr,
        "rc2_fdp": rc2Fdp,
        "rc2_chp": rc2Chp,
        "rc2_mmc": rc2Mmc,
        "rc2_pdp": rc2Pdp,
        "rc3_emp": rc3Emp,
        "rc3_ciu": rc3Ciu,
        "rc3_tlf": rc3Tlf,
        "rc3_fcr": rc3Fcr,
        "rc3_vcr": rc3Vcr,
        "rc3_dcr": rc3Dcr,
        "rc3_ccr": rc3Ccr,
        "rc3_pcr": rc3Pcr,
        "rc3_fdp": rc3Fdp,
        "rc3_chp": rc3Chp,
        "rc3_mmc": rc3Mmc,
        "rc3_pdp": rc3Pdp,
        "rd1_nom": rd1Nom,
        "rd1_ubi": rd1Ubi,
        "rd1_val": rd1Val,
        "rd1_hip": rd1Hip,
        "rd2_nom": rd2Nom,
        "rd2_ubi": rd2Ubi,
        "rd2_val": rd2Val,
        "rd2_hip": rd2Hip,
        "rd3_nom": rd3Nom,
        "rd3_ubi": rd3Ubi,
        "rd3_val": rd3Val,
        "rd3_hip": rd3Hip,
        "rf1_nom": rf1Nom,
        "rf1_nex": rf1Nex,
        "rf1_ciu": rf1Ciu,
        "rf1_tlf": rf1Tlf,
        "rf2_nom": rf2Nom,
        "rf2_nex": rf2Nex,
        "rf2_ciu": rf2Ciu,
        "rf2_tlf": rf2Tlf,
        "rf3_nom": rf3Nom,
        "rf3_nex": rf3Nex,
        "rf3_ciu": rf3Ciu,
        "rf3_tlf": rf3Tlf,
        "uap_sdc": uapSdc,
        "cup_sdc": cupSdc,
        "plz_sdc": plzSdc,
        "fdp_sdc": fdpSdc,
        "cls_sdc": clsSdc,
        "ucr_sdc": ucrSdc,
        "dcr_sdc": dcrSdc,
        "uac_sdc": uacSdc,
        "dac_sdc": dacSdc,
        "nts_sdc": ntsSdc,
        "sts_sdc": stsSdc,
      };
}

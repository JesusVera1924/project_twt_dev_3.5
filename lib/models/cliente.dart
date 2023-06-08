import 'dart:convert';

class Cliente {
  Cliente({
    this.codEmp = "",
    this.codRef = "",
    this.nomRef = "",
    this.nomRxf = "",
    this.nomRyf = "",
    this.codPai = "",
    this.codEst = "",
    this.codCiu = "",
    this.codZon = "",
    this.codRut = "",
    this.dirRef = "",
    this.dirRxf = "",
    this.dirRyf = "",
    this.telRef = "",
    this.imgJpg = "",
    this.codAux = "",
    this.nomAux = "",
    this.codIrc = "",
    this.codGdc = "",
    this.codDes = "",
    this.porDes = 0,
    this.cedRuc = "",
    this.exoIva = "",
    this.exoRet = "",
    this.codDiv = "",
    this.persona = "",
    this.calCli = "",
    this.calVoc = "",
    this.calOef = "",
    this.calBco = "",
    this.calObr = "",
    this.calPrv = "",
    this.sitRef = "",
    this.frsRef = "",
    this.mosRef = "",
    this.lugWrk = "",
    this.dirWrk = "",
    this.telWrk = "",
    this.bcoWrk = "",
    this.ctaWrk = "",
    this.rechazo = 0,
    this.cambios = 0,
    this.solVen = "",
    this.swrRef = "",
    this.swsRef = "",
    this.conChp = "",
    this.limChp = 0,
    this.conDoc = "",
    this.limDoc = 0,
    this.conCrd = "",
    this.plzCrd = 0,
    this.limCrd = 0,
    this.comVen = 0,
    this.comCob = 0,
    this.tipOef = "",
    this.turOef = "",
    this.sexOef = "",
    this.estOef = "",
    this.codCar = "",
    this.codDep = "",
    this.codSec = "",
    this.pasOef = "",
    this.iesOef = "",
    this.lbmOef = "",
    this.crdOef = "",
    this.fNOef = "",
    this.fEOef = "",
    this.fIOef = "",
    this.fROef = "",
    this.fSOef = "",
    this.fVOef = "",
    this.fdpOef = "",
    this.btcOef = "",
    this.bcoOef = "",
    this.tipSgr = "",
    this.carFam = 0,
    this.carEsc = 0,
    this.fdrOef = "",
    this.l01Oef = "",
    this.l02Oef = "",
    this.l03Oef = "",
    this.sdoBas = 0,
    this.jorDia = 0,
    this.gasVia = 0,
    this.gasMov = 0,
    this.gasRep = 0,
    this.nomTda = "",
    this.nomTdc = "",
    this.areLug = 0,
    this.areObr = 0,
    this.valObr = 0,
    this.porTec = 0,
    this.porAdm = 0,
    this.numCtc = "",
    this.fecCtc = "",
    this.anoCtc = 0,
    this.periodo = 0,
    this.fIObr = "",
    this.fTObr = "",
    this.fEObr = "",
    this.sumPme = "",
    this.sumCdo = "",
    this.fecRef = "",
    this.fanRef = "",
    this.ucrRef = "",
    this.fcrRef = "",
    this.hraRta = 0,
    this.proAux = "",
    this.nomPai = "",
    this.nomEst = "",
    this.nomCiu = "",
    this.nomZon = "",
    this.nomRut = "",
  });

  String codEmp;
  String codRef;
  String nomRef;
  String nomRxf;
  String nomRyf; //
  String codPai;
  String codEst;
  String codCiu;
  String codZon;
  String codRut;
  String dirRef;
  String dirRxf;
  String dirRyf;
  String telRef;
  String imgJpg;
  String codAux;
  String nomAux;
  String codIrc;
  String codGdc;
  String codDes;
  double porDes;
  String cedRuc;
  String exoIva;
  String exoRet;
  String codDiv;
  String persona;
  String calCli;
  String calVoc;
  String calOef;
  String calBco;
  String calObr;
  String calPrv;
  String sitRef;
  dynamic frsRef;
  String mosRef;
  String lugWrk;
  String dirWrk;
  String telWrk;
  String bcoWrk;
  String ctaWrk;
  int rechazo;
  int cambios;
  String solVen;
  String swrRef;
  String swsRef;
  String conChp;
  double limChp;
  String conDoc;
  double limDoc;
  String conCrd;
  int plzCrd;
  double limCrd;
  double comVen;
  double comCob;
  String tipOef;
  String turOef;
  String sexOef;
  String estOef;
  String codCar;
  String codDep;
  String codSec;
  String pasOef;
  String iesOef;
  String lbmOef;
  String crdOef;
  dynamic fNOef;
  dynamic fEOef;
  dynamic fIOef;
  dynamic fROef;
  dynamic fSOef;
  dynamic fVOef;
  String fdpOef;
  String btcOef;
  String bcoOef;
  String tipSgr;
  int carFam;
  int carEsc;
  String fdrOef;
  String l01Oef;
  String l02Oef;
  String l03Oef;
  double sdoBas;
  double jorDia;
  double gasVia;
  double gasMov;
  double gasRep;
  String nomTda;
  String nomTdc;
  double areLug;
  double areObr;
  double valObr;
  double porTec;
  double porAdm;
  String numCtc;
  dynamic fecCtc;
  int anoCtc;
  int periodo;
  dynamic fIObr;
  dynamic fTObr;
  dynamic fEObr;
  String sumPme;
  String sumCdo;
  String fecRef;
  dynamic fanRef;
  String ucrRef;
  dynamic fcrRef; //
  //
  double hraRta; //
  String proAux; //
  String nomPai; //
  String nomEst; //
  String nomCiu; //
  String nomZon; //
  String nomRut; //

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        codEmp: json["cod_emp"],
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        nomRxf: json["nom_rxf"],
        nomRyf: json["nom_ryf"],
        codPai: json["cod_pai"],
        codEst: json["cod_est"],
        codCiu: json["cod_ciu"],
        codZon: json["cod_zon"],
        codRut: json["cod_rut"],
        dirRef: json["dir_ref"],
        dirRxf: json["dir_rxf"],
        dirRyf: json["dir_ryf"],
        telRef: json["tel_ref"],
        imgJpg: json["img_jpg"],
        codAux: json["cod_aux"],
        nomAux: json["nom_aux"],
        codIrc: json["cod_irc"],
        codGdc: json["cod_gdc"],
        codDes: json["cod_des"],
        porDes: json["por_des"].toDouble(),
        cedRuc: json["ced_ruc"],
        exoIva: json["exo_iva"],
        exoRet: json["exo_ret"],
        codDiv: json["cod_div"],
        persona: json["persona"],
        calCli: json["cal_cli"],
        calVoc: json["cal_voc"],
        calOef: json["cal_oef"],
        calBco: json["cal_bco"],
        calObr: json["cal_obr"],
        calPrv: json["cal_prv"],
        sitRef: json["sit_ref"],
        frsRef: json["frs_ref"],
        mosRef: json["mos_ref"],
        lugWrk: json["lug_wrk"],
        dirWrk: json["dir_wrk"],
        telWrk: json["tel_wrk"],
        bcoWrk: json["bco_wrk"],
        ctaWrk: json["cta_wrk"],
        rechazo: json["rechazo"],
        cambios: json["cambios"],
        solVen: json["sol_ven"],
        swrRef: json["swr_ref"],
        swsRef: json["sws_ref"],
        conChp: json["con_chp"],
        limChp: json["lim_chp"].toDouble(),
        conDoc: json["con_doc"],
        limDoc: json["lim_doc"].toDouble(),
        conCrd: json["con_crd"],
        plzCrd: json["plz_crd"],
        limCrd: json["lim_crd"].toDouble(),
        comVen: json["com_ven"].toDouble(),
        comCob: json["com_cob"].toDouble(),
        tipOef: json["tip_oef"],
        turOef: json["tur_oef"],
        sexOef: json["sex_oef"],
        estOef: json["est_oef"],
        codCar: json["cod_car"],
        codDep: json["cod_dep"],
        codSec: json["cod_sec"],
        pasOef: json["pas_oef"],
        iesOef: json["ies_oef"],
        lbmOef: json["lbm_oef"],
        crdOef: json["crd_oef"],
        fNOef: json["f_n_oef"],
        fEOef: json["f_e_oef"],
        fIOef: json["f_i_oef"],
        fROef: json["f_r_oef"],
        fSOef: json["f_s_oef"],
        fVOef: json["f_v_oef"],
        fdpOef: json["fdp_oef"],
        btcOef: json["btc_oef"],
        bcoOef: json["bco_oef"],
        tipSgr: json["tip_sgr"],
        carFam: json["car_fam"],
        carEsc: json["car_esc"],
        fdrOef: json["fdr_oef"],
        l01Oef: json["l01_oef"],
        l02Oef: json["l02_oef"],
        l03Oef: json["l03_oef"],
        sdoBas: json["sdo_bas"].toDouble(),
        jorDia: json["jor_dia"].toDouble(),
        gasVia: json["gas_via"].toDouble(),
        gasMov: json["gas_mov"].toDouble(),
        gasRep: json["gas_rep"].toDouble(),
        nomTda: json["nom_tda"],
        nomTdc: json["nom_tdc"],
        areLug: json["are_lug"].toDouble(),
        areObr: json["are_obr"].toDouble(),
        valObr: json["val_obr"].toDouble(),
        porTec: json["por_tec"].toDouble(),
        porAdm: json["por_adm"].toDouble(),
        numCtc: json["num_ctc"],
        fecCtc: json["fec_ctc"],
        anoCtc: json["ano_ctc"],
        periodo: json["periodo"],
        fIObr: json["f_i_obr"],
        fTObr: json["f_t_obr"],
        fEObr: json["f_e_obr"],
        sumPme: json["sum_pme"],
        sumCdo: json["sum_cdo"],
        fecRef: json["fec_ref"],
        fanRef: json["fan_ref"],
        ucrRef: json["ucr_ref"],
        fcrRef: json["fcr_ref"],
        hraRta: json["hra_rta"].toDouble(),
        proAux: json["pro_aux"],
        nomPai: json["nom_pai"],
        nomEst: json["nom_est"],
        nomCiu: json["nom_ciu"],
        nomZon: json["nom_zon"],
        nomRut: json["nom_rut"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "nom_rxf": nomRxf,
        "nom_ryf": nomRyf,
        "cod_pai": codPai,
        "cod_est": codEst,
        "cod_ciu": codCiu,
        "cod_zon": codZon,
        "cod_rut": codRut,
        "dir_ref": dirRef,
        "dir_rxf": dirRxf,
        "dir_ryf": dirRyf,
        "tel_ref": telRef,
        "img_jpg": imgJpg,
        "cod_aux": codAux,
        "nom_aux": nomAux,
        "cod_irc": codIrc,
        "cod_gdc": codGdc,
        "cod_des": codDes,
        "por_des": porDes,
        "ced_ruc": cedRuc,
        "exo_iva": exoIva,
        "exo_ret": exoRet,
        "cod_div": codDiv,
        "persona": persona,
        "cal_cli": calCli,
        "cal_voc": calVoc,
        "cal_oef": calOef,
        "cal_bco": calBco,
        "cal_obr": calObr,
        "cal_prv": calPrv,
        "sit_ref": sitRef,
        "frs_ref": frsRef,
        "mos_ref": mosRef,
        "lug_wrk": lugWrk,
        "dir_wrk": dirWrk,
        "tel_wrk": telWrk,
        "bco_wrk": bcoWrk,
        "cta_wrk": ctaWrk,
        "rechazo": rechazo,
        "cambios": cambios,
        "sol_ven": solVen,
        "swr_ref": swrRef,
        "sws_ref": swsRef,
        "con_chp": conChp,
        "lim_chp": limChp,
        "con_doc": conDoc,
        "lim_doc": limDoc,
        "con_crd": conCrd,
        "plz_crd": plzCrd,
        "lim_crd": limCrd,
        "com_ven": comVen,
        "com_cob": comCob,
        "tip_oef": tipOef,
        "tur_oef": turOef,
        "sex_oef": sexOef,
        "est_oef": estOef,
        "cod_car": codCar,
        "cod_dep": codDep,
        "cod_sec": codSec,
        "pas_oef": pasOef,
        "ies_oef": iesOef,
        "lbm_oef": lbmOef,
        "crd_oef": crdOef,
        "f_n_oef": fNOef,
        "f_e_oef": fEOef,
        "f_i_oef": fIOef,
        "f_r_oef": fROef,
        "f_s_oef": fSOef,
        "f_v_oef": fVOef,
        "fdp_oef": fdpOef,
        "btc_oef": btcOef,
        "bco_oef": bcoOef,
        "tip_sgr": tipSgr,
        "car_fam": carFam,
        "car_esc": carEsc,
        "fdr_oef": fdrOef,
        "l01_oef": l01Oef,
        "l02_oef": l02Oef,
        "l03_oef": l03Oef,
        "sdo_bas": sdoBas,
        "jor_dia": jorDia,
        "gas_via": gasVia,
        "gas_mov": gasMov,
        "gas_rep": gasRep,
        "nom_tda": nomTda,
        "nom_tdc": nomTdc,
        "are_lug": areLug,
        "are_obr": areObr,
        "val_obr": valObr,
        "por_tec": porTec,
        "por_adm": porAdm,
        "num_ctc": numCtc,
        "fec_ctc": fecCtc,
        "ano_ctc": anoCtc,
        "periodo": periodo,
        "f_i_obr": fIObr,
        "f_t_obr": fTObr,
        "f_e_obr": fEObr,
        "sum_pme": sumPme,
        "sum_cdo": sumCdo,
        "fec_ref": fecRef,
        "fan_ref": fanRef,
        "ucr_ref": ucrRef,
        "fcr_ref": fcrRef,
        "hra_rta": hraRta,
        "pro_aux": proAux,
        "nom_pai": nomPai,
        "nom_est": nomEst,
        "nom_ciu": nomCiu,
        "nom_zon": nomZon,
        "nom_rut": nomRut,
      };
}

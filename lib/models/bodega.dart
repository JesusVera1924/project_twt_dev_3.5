import 'dart:convert';

class Bodega {
  Bodega({
    required this.codEmp,
    required this.codPro,
    required this.codBod,
    required this.exiInv,
    this.exiCom = 0,
    this.perchas = "",
    this.perchas2 = "",
    this.perchas3 = "",
    this.sIFis = 0,
    required this.fIFis,
    this.iIPer = 0,
    this.iIKar = 0,
  });

  String codEmp;
  String codPro;
  String codBod;
  int exiInv;
  int exiCom;
  String perchas;
  String perchas2;
  String perchas3;
  int sIFis;
  DateTime fIFis;
  int iIPer;
  int iIKar;

  factory Bodega.fromJson(String str) => Bodega.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bodega.fromMap(Map<String, dynamic> json) => Bodega(
        codEmp: json["cod_emp"],
        codPro: json["cod_pro"],
        codBod: json["cod_bod"],
        exiInv: json["exi_inv"],
        exiCom: json["exi_com"],
        perchas: json["perchas"],
        perchas2: json["perchas2"],
        perchas3: json["perchas3"],
        sIFis: json["s_i_fis"],
        fIFis: DateTime.parse(json["f_i_fis"]),
        iIPer: json["i_i_per"],
        iIKar: json["i_i_kar"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pro": codPro,
        "cod_bod": codBod,
        "exi_inv": exiInv,
        "exi_com": exiCom,
        "perchas": perchas,
        "perchas2": perchas2,
        "perchas3": perchas3,
        "s_i_fis": sIFis,
        "f_i_fis":
            "${fIFis.year.toString().padLeft(4, '0')}-${fIFis.month.toString().padLeft(2, '0')}-${fIFis.day.toString().padLeft(2, '0')}T19:30:45.177+00:00",
        "i_i_per": iIPer,
        "i_i_kar": iIKar,
      };
}

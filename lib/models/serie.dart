import 'dart:convert';

class Serie {
  Serie({
    required this.codEmp,
    required this.codPto,
    required this.nomPto,
    required this.datPto,
    required this.dirPto,
    required this.telPto,
    required this.serPto,
    required this.numTlx,
    required this.codRef,
    required this.autPro,
  });

  String codEmp;
  String codPto;
  String nomPto;
  String datPto;
  String dirPto;
  String telPto;
  String serPto;
  String numTlx;
  String codRef;
  String autPro;

  factory Serie.fromJson(String str) => Serie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Serie.fromMap(Map<String, dynamic> json) => Serie(
        codEmp: json["cod_emp"],
        codPto: json["cod_pto"],
        nomPto: json["nom_pto"],
        datPto: json["dat_pto"],
        dirPto: json["dir_pto"],
        telPto: json["tel_pto"],
        serPto: json["ser_pto"],
        numTlx: json["num_tlx"],
        codRef: json["cod_ref"],
        autPro: json["aut_pro"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pto": codPto,
        "nom_pto": nomPto,
        "dat_pto": datPto,
        "dir_pto": dirPto,
        "tel_pto": telPto,
        "ser_pto": serPto,
        "num_tlx": numTlx,
        "cod_ref": codRef,
        "aut_pro": autPro,
      };
}

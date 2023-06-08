import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_banco.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_comerciales.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_familiares.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_personales.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_propiedades.dart';

class DesgloseLista {
  void desglozarLista(List<CardBanco> lista, Mg0031 data) {
    int iterador = 3;
    if (lista.isNotEmpty) {
      for (var element in lista) {
        if (iterador == 1) {
          data.rb1Bco = element.banco.text != "" ? element.banco.text : "";
          data.rb1Agn = element.agencia.text != "" ? element.agencia.text : "";
          data.rb1Tlf = element.telf.text != "" ? element.telf.text : "";
          data.rb1Tip = element.tipo.text != ""
              ? element.tipo.text.toUpperCase().substring(0, 1)
              : ""; //element.tipo.text;
          data.rb1Cta = element.cta.text != "" ? element.cta.text : "";
          iterador++;
        } else if (iterador == 2) {
          data.rb2Bco = element.banco.text != "" ? element.banco.text : "";
          data.rb2Agn = element.agencia.text != "" ? element.agencia.text : "";
          data.rb2Tlf = element.telf.text != "" ? element.telf.text : "";
          data.rb2Tip = element.tipo.text != ""
              ? element.tipo.text.toUpperCase().substring(0, 1)
              : ""; //element.tipo.text;
          data.rb2Cta = element.cta.text != "" ? element.cta.text : "";

          iterador++;
        } else if (iterador == 3) {
          data.rb3Bco = element.banco.text != "" ? element.banco.text : "";
          data.rb3Agn = element.agencia.text != "" ? element.agencia.text : "";
          data.rb3Tlf = element.telf.text != "" ? element.telf.text : "";
          data.rb3Tip = element.tipo.text != ""
              ? element.tipo.text.toUpperCase().substring(0, 1)
              : ""; //element.tipo.text;
          data.rb3Cta = element.cta.text != "" ? element.cta.text : "";
        }
      }
    }
  }

  void desglozarLista1(List<CardRefPropiedades> lista, Mg0031 data) {
    int iterador = 1;
    if (lista.isNotEmpty) {
      for (var element in lista) {
        if (iterador == 1) {
          data.rd1Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.rd1Ubi =
              element.ubicacion.text != "" ? element.ubicacion.text : "";
          data.rd1Val =
              element.valor.text != "" ? double.parse(element.valor.text) : 0.0;
          data.rd1Hip = element.hipoteca.text != ""
              ? element.hipoteca.text.substring(0, 1).toUpperCase()
              : ""; //element.hipoteca.text;
          iterador++;
        } else if (iterador == 2) {
          data.rd2Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.rd2Ubi =
              element.ubicacion.text != "" ? element.ubicacion.text : "";
          data.rd2Val =
              element.valor.text != "" ? double.parse(element.valor.text) : 0.0;
          data.rd2Hip = element.hipoteca.text != ""
              ? element.hipoteca.text.substring(0, 1).toUpperCase()
              : ""; //element.hipoteca.text;
          iterador++;
        } else if (iterador == 3) {
          data.rd3Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.rd3Ubi =
              element.ubicacion.text != "" ? element.ubicacion.text : "";
          data.rd3Val =
              element.valor.text != "" ? double.parse(element.valor.text) : 0.0;
          data.rd3Hip = element.hipoteca.text != ""
              ? element.hipoteca.text.substring(0, 1).toUpperCase()
              : ""; //element.hipoteca.text;
        }
      }
    }
  }

  void desglozarLista2(List<CardRefPersonales> lista, Mg0031 data) {
    int iterador = 1;
    if (lista.isNotEmpty) {
      for (var element in lista) {
        if (iterador == 1) {
          data.rf1Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.rf1Nex =
              element.parentesco.text != "" ? element.parentesco.text : "";
          data.rf1Ciu = element.ciudad.text != "" ? element.ciudad.text : "";
          data.rf1Tlf =
              element.telefono.text != "" ? element.telefono.text : "";
          iterador++;
        } else if (iterador == 2) {
          data.rf2Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.rf2Nex =
              element.parentesco.text != "" ? element.parentesco.text : "";
          data.rf2Ciu = element.ciudad.text != "" ? element.ciudad.text : "";
          data.rf2Tlf =
              element.telefono.text != "" ? element.telefono.text : "";
          iterador++;
        } else if (iterador == 3) {
          data.rf3Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.rf3Nex =
              element.parentesco.text != "" ? element.parentesco.text : "";
          data.rf3Ciu = element.ciudad.text != "" ? element.ciudad.text : "";
          data.rf3Tlf =
              element.telefono.text != "" ? element.telefono.text : "";
        }
      }
    }
  }

  void desglozarLista3(List<CardRefComerciles> lista, Mg0031 data) {
    int iterador = 1;
    if (lista.isNotEmpty) {
      for (var element in lista) {
        if (iterador == 1) {
          data.rc1Emp = element.empresa.text != "" ? element.empresa.text : "";
          data.rc1Ciu = element.ciudad.text != "" ? element.ciudad.text : "";
          data.rc1Tlf =
              element.telefono.text != "" ? element.telefono.text : "";
          data.rc1Fcr = "null"; //element.fechaA.text
          data.rc1Vcr = element.valorC.text != ""
              ? double.parse(element.valorC.text)
              : 0.0;
          data.rc1Dcr =
              element.plazoC.text != "" ? int.parse(element.plazoC.text) : 0;
          data.rc1Ccr =
              element.cupoC.text != "" ? double.parse(element.cupoC.text) : 0.0;
          data.rc1Pcr =
              element.plazoC.text != "" ? int.parse(element.plazoC.text) : 0;
          data.rc1Fdp =
              element.formaPago.text != "" ? element.formaPago.text : "";
          data.rc1Chp = element.protesto.text != ""
              ? int.parse(element.protesto.text)
              : 0;
          data.rc1Mmc = element.montoC.text != ""
              ? double.parse(element.montoC.text)
              : 0.0;
          data.rc1Pdp = element.plazoMc.text != ""
              ? double.parse(element.plazoMc.text)
              : 0.0;
          iterador++;
        } else if (iterador == 2) {
          data.rc2Emp = element.empresa.text != "" ? element.empresa.text : "";
          data.rc2Ciu = element.ciudad.text != "" ? element.ciudad.text : "";
          data.rc2Tlf =
              element.telefono.text != "" ? element.telefono.text : "";
          data.rc2Fcr = "null"; //element.fechaA.text
          data.rc2Vcr = element.valorC.text != ""
              ? double.parse(element.valorC.text)
              : 0.0;
          data.rc2Dcr =
              element.plazoC.text != "" ? int.parse(element.plazoC.text) : 0;
          data.rc2Ccr =
              element.cupoC.text != "" ? double.parse(element.cupoC.text) : 0.0;
          data.rc2Pcr =
              element.plazoC.text != "" ? int.parse(element.plazoC.text) : 0;
          data.rc2Fdp =
              element.formaPago.text != "" ? element.formaPago.text : "";
          data.rc2Chp = element.protesto.text != ""
              ? int.parse(element.protesto.text)
              : 0;
          data.rc2Mmc = element.montoC.text != ""
              ? double.parse(element.montoC.text)
              : 0.0;
          data.rc2Pdp = element.plazoMc.text != ""
              ? double.parse(element.plazoMc.text)
              : 0.0;
          iterador++;
        } else if (iterador == 3) {
          data.rc3Emp = element.empresa.text != "" ? element.empresa.text : "";
          data.rc3Ciu = element.ciudad.text != "" ? element.ciudad.text : "";
          data.rc3Tlf =
              element.telefono.text != "" ? element.telefono.text : "";
          data.rc3Fcr = "null"; //element.fechaA.text
          data.rc3Vcr = element.valorC.text != ""
              ? double.parse(element.valorC.text)
              : 0.0;
          data.rc3Dcr =
              element.plazoC.text != "" ? int.parse(element.plazoC.text) : 0;
          data.rc3Ccr =
              element.cupoC.text != "" ? double.parse(element.cupoC.text) : 0.0;
          data.rc3Pcr =
              element.plazoC.text != "" ? int.parse(element.plazoC.text) : 0;
          data.rc3Fdp =
              element.formaPago.text != "" ? element.formaPago.text : "";
          data.rc3Chp = element.protesto.text != ""
              ? int.parse(element.protesto.text)
              : 0;
          data.rc3Mmc = element.montoC.text != ""
              ? double.parse(element.montoC.text)
              : 0.0;
          data.rc3Pdp = element.plazoMc.text != ""
              ? double.parse(element.plazoMc.text)
              : 0.0;
        }
      }
    }
  }

  void desglozarLista4(List<CardRefFamiliares> lista, Mg0031 data) {
    int iterador = 1;
    if (lista.isNotEmpty) {
      for (var element in lista) {
        if (iterador == 1) {
          data.ct1Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.ct1Crg = element.cargo.text != "" ? element.cargo.text : "";
          data.ct1Tlf = element.telfono.text != "" ? element.telfono.text : "";
          data.ct1Ext =
              element.extencion.text != "" ? element.extencion.text : "";
          data.ct1Cor = element.correo.text != "" ? element.correo.text : "";
          iterador++;
        } else if (iterador == 2) {
          data.ct2Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.ct2Crg = element.cargo.text != "" ? element.cargo.text : "";
          data.ct2Tlf = element.telfono.text != "" ? element.telfono.text : "";
          data.ct2Ext =
              element.extencion.text != "" ? element.extencion.text : "";
          data.ct2Cor = element.correo.text != "" ? element.correo.text : "";
          iterador++;
        } else if (iterador == 3) {
          data.ct3Nom = element.nombre.text != "" ? element.nombre.text : "";
          data.ct3Crg = element.cargo.text != "" ? element.cargo.text : "";
          data.ct3Tlf = element.telfono.text != "" ? element.telfono.text : "";
          data.ct3Ext =
              element.extencion.text != "" ? element.extencion.text : "";
          data.ct3Cor = element.correo.text != "" ? element.correo.text : "";
        }
      }
    }
  }

  List<CardBanco> llenarLista(Mg0031 datos) {
    List<CardBanco> lista = [];
    CardBanco obj;

    for (var i = 0; i <= 3; i++) {
      if (i == 1) {
        if (datos.rb1Cta != "") {
          obj = CardBanco();
          obj.banco.text = datos.rb1Bco;
          obj.agencia.text = datos.rb1Agn;
          obj.telf.text = datos.rb1Tlf;
          obj.tipo.text = datos.rb1Tip;
          lista.add(obj);
        }
      } else if (i == 2) {
        if (datos.rb2Cta != "") {
          obj = CardBanco();
          obj.banco.text = datos.rb2Bco;
          obj.agencia.text = datos.rb2Agn;
          obj.telf.text = datos.rb2Tlf;
          obj.tipo.text = datos.rb2Tip;
          obj.cta.text = datos.rb2Cta;
          lista.add(obj);
        }
      } else if (i == 3) {
        if (datos.rb3Cta != "") {
          obj = CardBanco();
          obj.banco.text = datos.rb3Bco;
          obj.agencia.text = datos.rb3Agn;
          obj.telf.text = datos.rb3Tlf;
          obj.tipo.text = datos.rb3Tip;
          obj.cta.text = datos.rb3Cta;
          lista.add(obj);
        }
      }
    }
    return lista;
  }

  List<CardRefPropiedades> llenarLista1(Mg0031 datos) {
    List<CardRefPropiedades> lista = [];
    CardRefPropiedades obj;

    for (var i = 0; i <= 3; i++) {
      if (i == 1) {
        if (datos.rd1Nom != "") {
          obj = CardRefPropiedades();
          obj.nombre.text = datos.rd1Nom;
          obj.ubicacion.text = datos.rd1Ubi;
          obj.valor.text = datos.rd1Val.toString();
          obj.hipoteca.text = datos.rd1Hip;
          lista.add(obj);
        }
      } else if (i == 2) {
        if (datos.rd2Nom != "") {
          obj = CardRefPropiedades();
          obj.nombre.text = datos.rd2Nom;
          obj.ubicacion.text = datos.rd2Ubi;
          obj.valor.text = datos.rd2Val.toString();
          obj.hipoteca.text = datos.rd2Hip;
          lista.add(obj);
        }
      } else if (i == 3) {
        if (datos.rd3Nom != "") {
          obj = CardRefPropiedades();
          obj.nombre.text = datos.rd3Nom;
          obj.ubicacion.text = datos.rd3Ubi;
          obj.valor.text = datos.rd3Val.toString();
          obj.hipoteca.text = datos.rd3Hip;
          lista.add(obj);
        }
      }
    }
    return lista;
  }

  List<CardRefPersonales> llenarLista2(Mg0031 datos) {
    List<CardRefPersonales> lista = [];
    CardRefPersonales obj;

    for (var i = 0; i <= 3; i++) {
      if (i == 1) {
        if (datos.rf1Nom != "") {
          obj = CardRefPersonales();
          obj.nombre.text = datos.rf1Nom;
          obj.parentesco.text = datos.rf1Nex;
          obj.ciudad.text = datos.rf1Ciu;
          obj.telefono.text = datos.rf1Tlf;
          lista.add(obj);
        }
      } else if (i == 2) {
        if (datos.rf2Nom != "") {
          obj = CardRefPersonales();
          obj.nombre.text = datos.rf2Nom;
          obj.parentesco.text = datos.rf2Nex;
          obj.ciudad.text = datos.rf2Ciu;
          obj.telefono.text = datos.rf2Tlf;
          lista.add(obj);
        }
      } else if (i == 3) {
        if (datos.rf3Nom != "") {
          obj = CardRefPersonales();
          obj.nombre.text = datos.rf3Nom;
          obj.parentesco.text = datos.rf3Nex;
          obj.ciudad.text = datos.rf3Ciu;
          obj.telefono.text = datos.rf3Tlf;
          lista.add(obj);
        }
      }
    }
    return lista;
  }

  List<CardRefComerciles> llenarLista3(Mg0031 datos) {
    List<CardRefComerciles> lista = [];
    CardRefComerciles obj;

    for (var i = 0; i <= 3; i++) {
      if (i == 1) {
        if (datos.rc1Emp != "") {
          obj = CardRefComerciles();
          obj.empresa.text = datos.rc1Emp.toString();
          obj.ciudad.text = datos.rc1Ciu;
          obj.telefono.text = datos.rc1Tlf;

          obj.valorC.text = datos.rc1Vcr.toString();
          obj.plazoC.text = datos.rc1Dcr.toString();
          obj.cupoC.text = datos.rc1Ccr.toString();
          obj.plazoCc.text = datos.rc1Pcr.toString();
          obj.formaPago.text = datos.rc1Fdp.toString();
          obj.protesto.text = datos.rc1Chp.toString();
          obj.montoC.text = datos.rc1Mmc.toString();
          obj.plazoMc.text = datos.rc1Pdp.toString();
          lista.add(obj);
        }
      } else if (i == 2) {
        if (datos.rc2Emp != "") {
          obj = CardRefComerciles();
          obj.empresa.text = datos.rc2Emp.toString();
          obj.ciudad.text = datos.rc2Ciu;
          obj.telefono.text = datos.rc2Tlf;

          obj.valorC.text = datos.rc2Vcr.toString();
          obj.plazoC.text = datos.rc2Dcr.toString();
          obj.cupoC.text = datos.rc2Ccr.toString();
          obj.plazoCc.text = datos.rc2Pcr.toString();
          obj.formaPago.text = datos.rc2Fdp.toString();
          obj.protesto.text = datos.rc2Chp.toString();
          obj.montoC.text = datos.rc2Mmc.toString();
          obj.plazoMc.text = datos.rc2Pdp.toString();
          lista.add(obj);
        }
      } else if (i == 3) {
        if (datos.rc3Emp != "") {
          obj = CardRefComerciles();
          obj.empresa.text = datos.rc3Emp.toString();
          obj.ciudad.text = datos.rc3Ciu;
          obj.telefono.text = datos.rc3Tlf;

          obj.valorC.text = datos.rc3Vcr.toString();
          obj.plazoC.text = datos.rc3Dcr.toString();
          obj.cupoC.text = datos.rc3Ccr.toString();
          obj.plazoCc.text = datos.rc3Pcr.toString();
          obj.formaPago.text = datos.rc3Fdp.toString();
          obj.protesto.text = datos.rc3Chp.toString();
          obj.montoC.text = datos.rc3Mmc.toString();
          obj.plazoMc.text = datos.rc3Pdp.toString();
          lista.add(obj);
        }
      }
    }
    return lista;
  }

  List<CardRefFamiliares> llenarLista4(Mg0031 datos) {
    List<CardRefFamiliares> lista = [];
    CardRefFamiliares obj;

    for (var i = 1; i <= 3; i++) {
      if (i == 1) {
        if (datos.ct1Nom != "") {
          obj = CardRefFamiliares();
          obj.nombre.text = datos.ct1Nom;
          obj.cargo.text = datos.ct1Crg;
          obj.telfono.text = datos.ct1Tlf;
          obj.extencion.text = datos.ct1Ext;
          obj.correo.text = datos.ct1Cor;
          lista.add(obj);
        }
      } else if (i == 2) {
        if (datos.ct2Nom != "") {
          obj = CardRefFamiliares();
          obj.nombre.text = datos.ct2Nom;
          obj.cargo.text = datos.ct2Crg;
          obj.telfono.text = datos.ct2Tlf;
          obj.extencion.text = datos.ct2Ext;
          obj.correo.text = datos.ct2Cor;
          lista.add(obj);
        }
      } else if (i == 3) {
        if (datos.ct3Nom != "") {
          obj = CardRefFamiliares();
          obj.nombre.text = datos.ct3Nom;
          obj.cargo.text = datos.ct3Crg;
          obj.telfono.text = datos.ct3Tlf;
          obj.extencion.text = datos.ct3Ext;
          obj.correo.text = datos.ct3Cor;
          lista.add(obj);
        }
      }
    }
    return lista;
  }
}

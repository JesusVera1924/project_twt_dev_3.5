import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/credit_api.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/cliente.dart';
import 'package:devolucion_modulo/models/mg0030.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/models/motivo.dart';

class CreditsProvider extends ChangeNotifier {
  List<Mg0031> listTemp = [];
  List<Mg0031> listTemp2 = [];
  final CreditApi _creditApi = CreditApi();
  List<Motivo> listFormPago = [];
  final ReturnApi _conexionApi = ReturnApi();
  List<Mg0030> listCiud = [];
  List<Mg0030> listProv = [];
  List<Cliente> listVendedor = [];

  getListVendedor() async {
    listVendedor = await _creditApi.queryVendedor();
    notifyListeners();
  }

  getData() async {
    listTemp = await _creditApi.queryListCredit();
    listTemp2 = listTemp;
    listFormPago = await _conexionApi.querylistMotivos("03", "");
    notifyListeners();
  }

  getFiltro(String val) {
    this.listTemp = this.listTemp2;
    final resp = this.listTemp.where((element) => element.stsSdc == val);
    this.listTemp = [...resp];
    notifyListeners();
  }

  getFill() {
    this.listTemp = this.listTemp2;
    notifyListeners();
  }

  getContinente() async {
    listCiud = await _creditApi.querylist("03");
    listProv = await _creditApi.querylist("02");
  }

  Future<bool> checkCodigo(String code) async {
    var x = await _creditApi.queryCliente(code);
    return x == null ? true : false;
  }

  saveRechazo(Mg0031 obj) async {
    await _creditApi.updateCreditEstado(obj.secNic, obj.numSdc, obj.ntsSdc);
    this.listTemp = this.listTemp.map((solicitud) {
      if (solicitud.numSdc != obj.numSdc) return solicitud;
      solicitud.stsSdc = "R";
      return solicitud;
    }).toList();
    notifyListeners();
  }

  saveObj(Mg0031 obj) async {
    try {
      update(obj);
      this.listTemp = this.listTemp.map((solicitud) {
        if (solicitud.numSdc != obj.numSdc) return solicitud;
        solicitud.fecAdm = obj.fecAdm.split("T")[0];
        solicitud.fecSdc = obj.fecSdc.split("T")[0];
        solicitud.nomRef = obj.nomRef;
        solicitud.nmcRef = obj.nmcRef;
        solicitud.dirRef = obj.dirRef;
        solicitud.estRef = obj.estRef;
        solicitud.ciuRef = obj.ciuRef;
        solicitud.tlfRef = obj.tlfRef;
        solicitud.ce1Ref = obj.ce1Ref;
        solicitud.ce2Ref = obj.ce2Ref;
        solicitud.mv1Ref = obj.mv1Ref;
        return solicitud;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar datos del cliente:  $e';
    }
  }

  saveNegocio(Mg0031 obj) async {
    try {
      update(obj);
      // metodo para guardar en la api
      this.listTemp = this.listTemp.map((solicitud) {
        if (solicitud.numSdc != obj.numSdc) return solicitud;
        solicitud.fecAdm = obj.fecAdm.split("T")[0];
        solicitud.fecSdc = obj.fecSdc.split("T")[0];
        solicitud.nomPer = obj.nomPer;
        solicitud.nicPer = obj.nicPer;
        solicitud.dirPer = obj.dirPer;
        solicitud.ciuPer = obj.ciuPer;
        solicitud.tlfPer = obj.tlfPer;
        solicitud.tltPer = obj.tltPer;
        solicitud.ce1Per = obj.ce1Per;
        solicitud.mv1Per = obj.mv1Per;
        solicitud.ecrPer = obj.ecrPer;
        solicitud.nomCyg = obj.nomCyg;
        solicitud.nicCyg = obj.nicCyg;
        solicitud.mntSol = obj.mntSol;
        solicitud.plzSol = obj.plzSol;
        solicitud.ingMes = obj.ingMes;
        solicitud.gasMes = obj.gasMes;

        return solicitud;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar datos del negocio:  $e';
    }
  }

  saveContacto(Mg0031 obj) async {
    try {
      update(obj);
      // metodo para guardar en la api
      this.listTemp = this.listTemp.map((solicitud) {
        if (solicitud.numSdc != obj.numSdc) return solicitud;
        solicitud.fecAdm = obj.fecAdm.split("T")[0];
        solicitud.fecSdc = obj.fecSdc.split("T")[0];
        solicitud.ct1Nom = obj.ct1Nom;
        solicitud.ct1Crg = obj.ct1Crg;
        solicitud.ct1Tlf = obj.ct1Tlf;
        solicitud.ct1Ext = obj.ct1Ext;
        solicitud.ct1Cor = obj.ct1Cor;
        solicitud.ct2Nom = obj.ct2Nom;
        solicitud.ct2Crg = obj.ct2Crg;
        solicitud.ct2Tlf = obj.ct2Tlf;
        solicitud.ct2Ext = obj.ct2Ext;
        solicitud.ct2Cor = obj.ct2Cor;
        solicitud.ct3Nom = obj.ct3Nom;
        solicitud.ct3Crg = obj.ct3Crg;
        solicitud.ct3Tlf = obj.ct3Tlf;
        solicitud.ct3Ext = obj.ct3Ext;
        solicitud.ct3Cor = obj.ct3Cor;

        return solicitud;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar datos de los contactos:  $e';
    }
  }

  saveBanco(Mg0031 obj) async {
    try {
      update(obj);
      // metodo para guardar en la api
      this.listTemp = this.listTemp.map((solicitud) {
        if (solicitud.numSdc != obj.numSdc) return solicitud;
        solicitud.fecAdm = obj.fecAdm.split("T")[0];
        solicitud.fecSdc = obj.fecSdc.split("T")[0];
        solicitud.rb1Bco = obj.rb1Bco;
        solicitud.rb1Agn = obj.rb1Agn;
        solicitud.rb1Cta = obj.rb1Cta;
        solicitud.rb1Tlf = obj.rb1Tlf;
        solicitud.rb1Tip = obj.rb1Tip;
        solicitud.rb2Bco = obj.rb2Bco;
        solicitud.rb2Agn = obj.rb2Agn;
        solicitud.rb2Cta = obj.rb2Cta;
        solicitud.rb2Tlf = obj.rb2Tlf;
        solicitud.rb2Tip = obj.rb2Tip;
        solicitud.rb3Bco = obj.rb3Bco;
        solicitud.rb3Agn = obj.rb3Agn;
        solicitud.rb3Cta = obj.rb3Cta;
        solicitud.rb3Tlf = obj.rb3Tlf;
        solicitud.rb3Tip = obj.rb3Tip;

        return solicitud;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar datos de los bancos:  $e';
    }
  }

  savePatrimonio(Mg0031 obj) async {
    try {
      update(obj);
      // metodo para guardar en la api
      this.listTemp = this.listTemp.map((solicitud) {
        if (solicitud.numSdc != obj.numSdc) return solicitud;
        solicitud.fecAdm = obj.fecAdm.split("T")[0];
        solicitud.fecSdc = obj.fecSdc.split("T")[0];
        solicitud.rd1Nom = obj.rd1Nom;
        solicitud.rd1Ubi = obj.rd1Ubi;
        solicitud.rd1Val = obj.rd1Val;
        solicitud.rd1Hip = obj.rd1Hip;
        solicitud.rd2Nom = obj.rd2Nom;
        solicitud.rd2Ubi = obj.rd2Ubi;
        solicitud.rd2Val = obj.rd2Val;
        solicitud.rd2Hip = obj.rd2Hip;
        solicitud.rd3Nom = obj.rd3Nom;
        solicitud.rd3Ubi = obj.rd3Ubi;
        solicitud.rd3Val = obj.rd3Val;
        solicitud.rd3Hip = obj.rd3Hip;

        return solicitud;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar datos del propiedades:  $e';
    }
  }

  saveFamiliar(Mg0031 obj) async {
    try {
      update(obj);
      // metodo para guardar en la api
      this.listTemp = this.listTemp.map((solicitud) {
        if (solicitud.numSdc != obj.numSdc) return solicitud;
        solicitud.fecAdm = obj.fecAdm.split("T")[0];
        solicitud.fecSdc = obj.fecSdc.split("T")[0];
        solicitud.rf1Nom = obj.rf1Nom;
        solicitud.rf1Nex = obj.rf1Nex;
        solicitud.rf1Tlf = obj.rf1Tlf;
        solicitud.rf1Ciu = obj.rd1Hip;

        solicitud.rf2Nom = obj.rf2Nom;
        solicitud.rf2Nex = obj.rf2Nex;
        solicitud.rf2Tlf = obj.rf2Tlf;
        solicitud.rf2Ciu = obj.rd2Hip;

        solicitud.rf3Nom = obj.rf3Nom;
        solicitud.rf3Nex = obj.rf3Nex;
        solicitud.rf3Tlf = obj.rf3Tlf;
        solicitud.rf3Ciu = obj.rd3Hip;

        return solicitud;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar datos del familiares:  $e';
    }
  }

  saveApproval(Mg0031 obj) async {
    try {
      update(obj);
      // metodo para guardar en la api
      this.listTemp = this.listTemp.map((solicitud) {
        if (solicitud.numSdc != obj.numSdc) return solicitud;
        solicitud.fecAdm = obj.fecAdm.split("T")[0];
        solicitud.fecSdc = obj.fecSdc.split("T")[0];
        solicitud.uapSdc = obj.uapSdc;
        solicitud.plzSdc = obj.plzSdc;
        solicitud.cupSdc = obj.cupSdc;
        solicitud.fdpSdc = obj.fdpSdc;
        solicitud.clsSdc = obj.clsSdc;
        solicitud.ucrSdc = obj.ucrSdc;
        solicitud.stsSdc = obj.stsSdc;

        return solicitud;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al aprobar la solicitud:  $e';
    }
  }

  update(Mg0031 obj) {
    obj.fecAdm = "${obj.fecAdm}T19:30:45.177+00:00";
    obj.fecSdc = "${obj.fecSdc}T19:30:45.177+00:00";
    _creditApi.updateCredit(obj);
  }

  insertCorreo(Mg0031 obj) {
    List<String> listCorreo = [];
/*     List<String> listTelefono = []; */
    int x = 1;
    /*    int y = 1; */
    listCorreo.add(obj.ce1Ref);
    listCorreo.add(obj.ce2Ref);
    listCorreo.add(obj.ce1Per);

/*     listTelefono.add(obj.tlfRef);
    listTelefono.add(obj.mv1Ref);
    listTelefono.add(obj.tlfPer);
    listTelefono.add(obj.tltPer);
    listTelefono.add(obj.mv1Per);
 */
    for (var element in listCorreo) {
      if (element.isNotEmpty) {
        _creditApi.postCorreo(obj.codRef, element, "$x", "C");
        x++;
      }
    }
/*     listTelefono.forEach((element) {
      if (element.length >= 10 && element != "0000000000") {
        _creditApi.postCorreo(obj.codRef, element, "$y", "T");
        y++;
      }
    }); */
    listCorreo = [];
    /* listTelefono = []; */
  }

  insertCliente(Mg0031 obj) {
    _creditApi.postCliente(obj);
  }
}

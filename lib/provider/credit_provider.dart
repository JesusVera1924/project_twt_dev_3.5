import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/modifyModel/archivo.dart';

class CreditProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController secNic = TextEditingController();
  TextEditingController numSdc = TextEditingController();
  TextEditingController fecSdc = TextEditingController();
  TextEditingController fecAdm = TextEditingController();
  TextEditingController plzSol = TextEditingController();
  TextEditingController mntSol = TextEditingController();
  TextEditingController codRtc = TextEditingController();

  TextEditingController nomRef = TextEditingController();
  TextEditingController nmcRef = TextEditingController();
  TextEditingController dirRef = TextEditingController();
  TextEditingController ciuRef = TextEditingController();
  TextEditingController tlfRef = TextEditingController();
  TextEditingController ce1Ref = TextEditingController();
  TextEditingController ce2Ref = TextEditingController();
  TextEditingController mv1Ref = TextEditingController();

  TextEditingController nomPer = TextEditingController();
  TextEditingController nicPer = TextEditingController();
  TextEditingController dirPer = TextEditingController();
  TextEditingController ciuPer = TextEditingController();
  TextEditingController tlfPer = TextEditingController();
  TextEditingController tltPer = TextEditingController();
  TextEditingController ce1Per = TextEditingController();
  TextEditingController mv1Per = TextEditingController();
  TextEditingController ecrPer = TextEditingController();

  TextEditingController nomCyg = TextEditingController();
  TextEditingController nicCyg = TextEditingController();

  TextEditingController ingMes = TextEditingController();
  TextEditingController gasMes = TextEditingController();
  TextEditingController oiaMes = TextEditingController();

  //CreditApi _creditApi = CreditApi();

//List<Archivo> listDocCarga = [];
  List<Archivo> listDocument = [
    Archivo(
        name: "",
        arrayBs64: "", //base64.encode(file.bytes!.toList())
        estado: false,
        descp: "Copia cedula personal",
        requerido: "Requerido*",
        hide: true,
        sufijo: "CED"),
    Archivo(
        name: "",
        arrayBs64: "", //base64.encode(file.bytes!.toList())
        descp: "Copia ruc personal",
        estado: false,
        hide: true,
        requerido: "Requerido*",
        sufijo: "RCP"),
    Archivo(
        name: "",
        arrayBs64: "", //base64.encode(file.bytes!.toList())
        descp: "Copia servicios basico",
        estado: false,
        hide: true,
        requerido: "Requerido*",
        sufijo: "CSB"),
    Archivo(
        name: "",
        arrayBs64: "", //base64.encode(file.bytes!.toList())
        estado: false,
        descp: "Copia ruc empresa",
        requerido: "",
        hide: false,
        sufijo: "CRE"),
    Archivo(
        name: "",
        arrayBs64: "", //base64.encode(file.bytes!.toList())
        estado: false,
        descp: "Copia cedula Rep.legal",
        requerido: "",
        hide: false,
        sufijo: "CRL"),
    Archivo(
        name: "",
        arrayBs64: "", //base64.encode(file.bytes!.toList())
        descp: "Copia nombramiento Rep.legal",
        requerido: "",
        estado: false,
        hide: false,
        sufijo: "NRL"),
    Archivo(
        name: "",
        arrayBs64: "", //base64.encode(file.bytes!.toList())
        descp: "Copia permiso de funcionamiento",
        requerido: "",
        estado: false,
        hide: false,
        sufijo: "CPF"),
  ];

  void refresForm() async {
    notifyListeners();
  }

  String selectDocumento = 'Ruc';
  String selectSolicitud = 'Contado';
  String selectNegocio = 'Detallista';
  String selectLocal = 'Alquilado';
  String selectPersona = 'Persona Natural';
  String selectCivil = 'Soltero';

  String selectCity = '01';
  String selectProv = '03';

  String selectDocCodigo = "2";
  String numVersion = "1.0";
  bool isOpen = false;
  String estaForm = "0";

  bool get getIsOpen {
    return this.isOpen;
  }

  void setIsOpen(bool isOpen) {
    this.isOpen = isOpen;
    notifyListeners();
  }

  bool validateForm() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void limpiarForm() {
    secNic.text = "";
    numSdc.text = "";
    fecSdc.text = "";
    fecAdm.text = "";
    plzSol.text = "";
    mntSol.text = "";
    codRtc.text = "";

    nomRef.text = "";
    nmcRef.text = "";
    dirRef.text = "";
    ciuRef.text = "";
    tlfRef.text = "";
    ce1Ref.text = "";
    ce2Ref.text = "";
    mv1Ref.text = "";

    nomPer.text = "";
    nicPer.text = "";
    dirPer.text = "";
    ciuPer.text = "";
    tlfPer.text = "";
    tltPer.text = "";
    ce1Per.text = "";
    mv1Per.text = "";
    ecrPer.text = "";

    nomCyg.text = "";
    nicCyg.text = "";

    ingMes.text = "";
    gasMes.text = "";
    oiaMes.text = "";

    for (var element in listDocument) {
      element.arrayBs64 = "";
      element.name = "";
      element.estado = false;
    }

    selectDocumento = 'Cedula';
    selectSolicitud = 'Contado';
    selectNegocio = 'Detallista';
    selectLocal = 'Alquilado';
    selectPersona = 'Persona Natural';
    selectCivil = 'Soltero';
    selectDocCodigo = "1";

    notifyListeners();
  }
}

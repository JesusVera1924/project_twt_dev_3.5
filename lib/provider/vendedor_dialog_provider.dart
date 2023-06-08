import 'package:flutter/material.dart';

import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/modifyModel/archivo.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_vendedor.dart';

class VendedorDialogProvider extends ChangeNotifier {
  ReturnApi returnApi = ReturnApi();

  //Informacion para el usuario de la solicitud

  TextEditingController numMov = TextEditingController();
  TextEditingController nombCli = TextEditingController();
  TextEditingController nombVen = TextEditingController();
  TextEditingController codCli = TextEditingController();
  TextEditingController codVen = TextEditingController();
  TextEditingController codRef = TextEditingController();

  List<Detail> listaDetail = [];
  List<Detail> listaDetailTemp = [];
  String pass = "0";
  String infoProducto = "";
  String selectCombo = "00";
  String codigoTemp = "";
  String valTipo = "Devolución";
  TextEditingController controllerD = TextEditingController();
  TextEditingController controllerG = TextEditingController();
  var imgPdf;
  String btnG = "Aceptar";
  String btnD = "Aceptar";
  int contError = 0;

  bool isTodo = false;

  List<String> tipoValor = ["Devolución", "Garantía"];

  List<Ig0063> listTemp = []; // lista de detalles del usuario
  List<DetailVendedor> listVendedor = []; // lista para el vendedor
  List<Archivo> listArchivo = []; //lista de archivos

  String pdfNomb = "";
  String valVendedor = "";

  get getValVendedor => this.valVendedor;

  set setValVendedor(valVendedor) {
    this.valVendedor = valVendedor;
    notifyListeners();
  }

  get getNombre => this.pdfNomb;

  set setNombre(pdfNomb) {
    this.pdfNomb = pdfNomb;
    notifyListeners();
  }

  void limpiar() {
    valTipo = "Devolución";
    controllerG.text = "";
    infoProducto = "";
    imgPdf = null;
    pass = "0";
    codigoTemp = "";
    selectCombo = "00";
    controllerD.text = "";
  }

  fillProduct() {
    listaDetailTemp.clear();
    for (var detalle in listaDetail) {
      detalle.bloqueo = true;
      detalle.controller.text = '${detalle.item.canMov}';
      detalle.cantidad = '${detalle.item.canMov}';
      listaDetailTemp.add(detalle);
    }
  }

  onSelectedRow(bool selected, Detail detalle) async {
    if (selected) {
      detalle.bloqueo = true;
      detalle.controller.text = '${detalle.item.canMov}';
      detalle.cantidad = '${detalle.item.canMov}';
      listaDetailTemp.add(detalle);
    } else {
      detalle.bloqueo = false;
      detalle.estado = Colors.blueAccent;
      detalle.cantidad = "0";
      detalle.codMotivo = "00";
      detalle.motivo = "";
      detalle.informacion = "";
      detalle.infoAdicional = "";
      detalle.tipo = "Devolución";
      detalle.archivo = "";
      detalle.controller = TextEditingController();
      listaDetailTemp.remove(detalle);
    }

    if (listaDetailTemp.length != listaDetail.length) {
      if (isTodo) {
        listaDetailTemp.forEach((element) {
          element.controller.text = "";
          element.tipo = "";
          element.setInfoAdicional = "";
          element.codMotivo = "00";
          element.setMotivo = "";
          element.estado = Colors.blue;
          element.informacion = "";
        });
        listaDetailTemp.clear();
      }
      isTodo = false;
    }
  }

  gestor(Detail e) {
    onSelectedRow(!listaDetailTemp.contains(e), e);
    if (isTodo) {
      listaDetailTemp.forEach((element) {
        element.tipo = "";
        element.setInfoAdicional = "";
        element.codMotivo = "00";
        element.setMotivo = "";
        element.estado = Colors.blue;
        element.informacion = "";
      });
    }

    if (listaDetailTemp.contains(e)) {
      infoProducto =
          e.item.nomPro + "::" + e.item.mrcPro + "::" + e.item.grpPro;
      pass = "1";
      codigoTemp = e.item.codPro;

      if (e.codMotivo != "00" && e.tipo == "Devolución") {
        valTipo = "Devolución";
        selectCombo = e.codMotivo;
        controllerD.text = e.infoAdicional;
        btnD = "Actualizar Razón";
      } else if (e.tipo == "Garantía" && e.archivo != "") {
        valTipo = "Garantía";
        controllerG.text = e.infoAdicional;
        btnG = "Actualizar Archivo";
      } else {
        valTipo = "Devolución";
        selectCombo = e.codMotivo;
        controllerD.text = "";
        controllerG.text = "";
      }
    }
    notifyListeners();
  }
}

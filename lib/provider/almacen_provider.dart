// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member

import 'dart:convert';

import 'package:devolucion_modulo/models/alterno.dart';
import 'package:devolucion_modulo/models/karmov.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:devolucion_modulo/models/motivo.dart';
import 'package:devolucion_modulo/models/serie.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';

import 'package:devolucion_modulo/models/invoice.dart';
import 'package:devolucion_modulo/models/product.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AlmacenProvider extends ChangeNotifier {
  final ReturnApi _returnApi = ReturnApi();
  //final DataGridController dataGridController = DataGridController();
  // 2. Crea una variable para almacenar la selección actual de filas
  List<DataGridRow>? selectedRows;

  Invoice? factura;
  List<Detail> listDetailInvoiceUser = [];

  //lista de motivos-series

  List<Serie> listSeries = [];
  List<Motivo> listMotivos = [];
  //Valores Iniciales y guardado
  String valTipo = "FC";
  String selectCombo = "01";

  //Informacion para el usuario de la solicitud

  TextEditingController numMov = TextEditingController();
  TextEditingController cliNomb = TextEditingController();
  TextEditingController codCli = TextEditingController();
  TextEditingController cuiCli = TextEditingController();
  TextEditingController tlfCli = TextEditingController();
  TextEditingController cceCli = TextEditingController();
  TextEditingController dirCli = TextEditingController();

  List<Detail> listaTemp = [];
  List<Ig0063> listTemp = []; // lista de detalles del usuario
  //--------------------
  String codigoTemp = "";
  String imgPdf = "";
  String pass = "0";
  String infoProducto = "";
  String btn = "Aceptar";
  String valItemTipo = "Devolución";
  TextEditingController controllerD = TextEditingController();
  TextEditingController controllerG = TextEditingController();
  Motivo obj = Motivo(cICmg: "", codCmg: "", nomCmg: "", numMes: 0);
  String selectComboMotivo = "00";

  String pdfNomb = ""; // nombre del pdf vista para el usuario

  get getNombre => this.pdfNomb;
  String countIntems = "";

  final tokenUser =
      Usuario.fromMap(jsonDecode(LocalStorage.prefs.getString('usuario')!));

  void inizializacion() async {
    listMotivos = await _returnApi.querylistMotivos("10");
    listSeries = await _returnApi.querylistSeries();
    if (listMotivos.isNotEmpty) {
      listMotivos.add(Motivo(
          cICmg: "00",
          codCmg: "00",
          nomCmg: "SELECCIONE UN MOTIVO",
          numMes: 0));
    }
    limpiarComp();
    notifyListeners();
  }

  limpiarComp() {
    numMov.clear();
    cliNomb.clear();
    codCli.clear();
    cuiCli.clear();
    tlfCli.clear();
    cceCli.clear();
    dirCli.clear();
    listaTemp.clear();
    listTemp.clear();
  }

  Future<List<Alterno>> getAlternos(String producto) async {
    var x = await _returnApi.getAlternos("01", producto);
    return x;
  }

  onSelectedRow(List<DataGridRow> x, List<DataGridRow> y) {
    if (x.isNotEmpty) {
      for (var element in x) {
        var detalle = element.getCells()[4].value;
        detalle.bloqueo = true;
        detalle.controller.text = '${detalle.item.canMov}';
        detalle.cantidad = '${detalle.item.canMov}';
        updateListTemp(detalle);
        listaTemp.add(detalle);
      }
    }
    if (y.isNotEmpty) {
      for (var element in y) {
        var detalle = element.getCells()[4].value;
        detalle.bloqueo = false;
        detalle.estado = Colors.blueAccent;
        detalle.cantidad = "0";
        detalle.codMotivo = "00";
        detalle.motivo = "";
        detalle.informacion = "";
        detalle.infoAdicional = "";
        detalle.tipo = "Devolución";
        detalle.archivo = "";
        detalle.controller.clear();
        updateListTemp(detalle);
        listaTemp.remove(detalle);
      }
    }
    //dataGridController.notifyDataSourceListeners();
    //selectedRows = dataGridController.selectedRows;
  }

  updateListTemp(Detail objeto) async {
    this.listDetailInvoiceUser = this.listDetailInvoiceUser.map((e) {
      if (e.item.codPro == objeto.item.codPro) {
        return objeto;
      }
      return e;
    }).toList();
  }

  Future<bool> verificarCantidad(int x, Detail detalle) async {
    countIntems = await _returnApi.verificarCantidad(
        detalle.item.numMov, detalle.item.codPro);

    return x > double.parse(countIntems);
  }

  Future<bool> openFileExplorer(BuildContext context) async {
    bool resp = false;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.extension!.toLowerCase() == "pdf") {
        for (var element in listaTemp) {
          if (element.item.codPro == codigoTemp) {
            element.archivo = base64.encode(file.bytes!.toList());
            setNombre = file.name;
            imgPdf = "1";
            resp = true;
          }
        }
      } else {
        customDialog1(context, "Extension permitida [pdf]");
      }
    }
    return resp;
  }

  void escogerItem(Detail e) {
    infoProducto = "${e.item.nomPro}::${e.item.mrcPro}::${e.item.grpPro}";
    pass = "1";
    codigoTemp = e.item.codPro;
    if (e.codMotivo != "00" && e.tipo == "Devolución") {
      valItemTipo = "Devolución";
      selectComboMotivo = e.codMotivo;
      controllerD.text = e.infoAdicional;
      btn = "Actualizar Razón";
    } else if (e.tipo == "Garantía" && e.archivo != "") {
      valItemTipo = "Garantía";
      controllerG.text = e.infoAdicional;
      btn = "Actualizar Archivo";
    } else {
      valItemTipo = "Devolución";
      selectComboMotivo = e.codMotivo;
      controllerD.text = "";
      controllerG.text = "";
    }
  }

  void limpiar() {
    imgPdf = "";
    pass = "0";
    codigoTemp = "";
    valItemTipo = "Devolución";
    infoProducto = "";
    controllerG.text = "";
    controllerD.text = "";
    selectComboMotivo = "00";
    setNombre = "";
  }

  set setNombre(pdfNomb) {
    this.pdfNomb = pdfNomb;
    notifyListeners();
  }

  bool validateForm() {
    return numMov.text != "";
  }

  Future<List<Invoice>> getFillInvoice(
      String tipo, String tp, String numero) async {
    final resp = await _returnApi.querylistInvoice(tipo, tp, numero);
    return resp;
  }

  Future getInvoice(String tipo, String tp, String numero) async {
    factura = await _returnApi.queryInvoice(tipo, tp, numero);
  }

  Future<List<DetailProductResponse>> getFillDetail(
      String tipo, String numero, String cliente) async {
    final resp = await _returnApi.listDetailProduct(cliente, tipo, numero);
    return resp;
  }

  Future<Product> getFillProduct(String code) async {
    final resp = await _returnApi.queryProducto(code);
    return resp;
  }

  Future<bool> getCliente(String codigo) async {
    bool opt = false;
    final resp = await _returnApi.queryCliente(codigo);
    if (resp != null) {
      final email = await _returnApi.queryCorreo(codigo);
      final city = await _returnApi.fillCity(resp.codCiu);

      cceCli.text = email.isEmpty ? "No tiene correo" : email.first.datCli;
      cliNomb.text = resp.nomRef;
      codCli.text = resp.codRef;
      cuiCli.text = city;
      tlfCli.text = resp.telRef;
      dirCli.text = resp.dirRef;
      opt = true;
    } else {
      opt = false;
    }

    notifyListeners();
    return opt;
  }

  Future convertKarmov(String tic) async {
    List<Karmov> list = [];
    try {
      for (var element in listTemp) {
        list.add(Karmov(
            codEmp: element.codEmp,
            codPto: "01",
            codMov: "NC",
            numMov: tic,
            fecMov: DateTime.now(),
            cx1Mov: element.codMov,
            nx1Mov: element.numMov,
            fx1Mov: element.frmSdv,
            cx2Mov: "",
            nx2Mov: "",
            fx2Mov: "",
            codRef: element.codRef,
            nomRef: "",
            codFb1: "",
            codFb2: "",
            codFb3: "",
            canQx1: 0,
            canQx2: 0,
            canQx3: 0,
            nomDg1: element.obsSdv.split("::")[0],
            nomDg2: element.obsSdv.split("::")[1],
            nomDg3: element.obsSdv.split("::")[2],
            codPro: element.codPro,
            nomPro: element.obsSdv.split("::")[0],
            codAl1: "",
            codAl2: "",
            codAl3: "",
            percha1: "",
            percha2: "",
            percha3: "",
            codBod: "02",
            canMov: element.canB92.toInt(),
            stsMov: "",
            obsMov: "",
            cdsMov: 0,
            sdsMov: "",
            odsMov: "",
            adaMov: "",
            cdaMov: 0,
            sdaMov: "",
            odaMov: "${tokenUser.ctaUsr}-${element.codVen}",
            bodMov: "01",
            auxilia: element.ucrSdv,
            secMov: "${element.secMov}",
            uduMov: "C",
            fytMov: DateTime.now().toIso8601String()));
      }
    } catch (e) {
      print(e);
    }

    await _returnApi.postKarmov(list);
  }
}

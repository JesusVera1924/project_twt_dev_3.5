// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:convert';

import 'package:devolucion_modulo/models/alterno.dart';
import 'package:devolucion_modulo/models/karmov.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:devolucion_modulo/models/serie.dart';
import 'package:devolucion_modulo/models/yk0001.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/util/create_file_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';

import 'package:devolucion_modulo/models/invoice.dart';
import 'package:devolucion_modulo/models/motivo.dart';
import 'package:devolucion_modulo/models/product.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VendedorProvider extends ChangeNotifier {
  final _returnApi = ReturnApi();

  //Informacion para el usuario de la solicitud
  Usuario? tokenUser;
  String permisos = "";

  Invoice? factura;
  List<Detail> listDetailInvoiceUser = [];

  //Valores Iniciales y guardado
  String valTipo = "FC";
  String selectCombo = "01";

  TextEditingController numMov = TextEditingController();
  TextEditingController nombCli = TextEditingController();
  TextEditingController nombVen = TextEditingController();
  TextEditingController codCli = TextEditingController();
  TextEditingController codVen = TextEditingController();
  TextEditingController codRef = TextEditingController();

  //VARIABLES DE TRANSITO
  List<Detail> listaTemp = [];
  List<Ig0063> listTemp = []; // lista de detalles del usuario

  //VARIABLE DE GUARDADO COMPLETO DE FACTURAS
  List<Detail> listArchivos = [];
  List<Ig0063> listSolicitudes = []; // lista de detalles del usuario

  //List<DetailVendedor> listVendedor = []; // lista para el vendedor

  List<Serie> listSeries = [];
  List<Motivo> listMotivos = [];
  List<Yk0001> listVCallCenter = [];

  String pdfNomb = "";
  String valVendedor = "";

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
  bool isBloqueo = false;
  bool isSelectAll = true;
  String countIntems = "";

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

  bool validateForm() {
    if (numMov.text != "" &&
        codCli.text != "" &&
        codVen.text != "" &&
        codVen.text == valVendedor) {
      return true;
    } else {
      return false;
    }
  }

  Future callValueConst() async {
    tokenUser =
        Usuario.fromMap(jsonDecode(LocalStorage.prefs.getString('usuario')!));

    permisos = LocalStorage.prefs.getString('permiss')!;
  }

  Future<List<Invoice>> getFillInvoice(
      String tipo, String tp, String numero) async {
    final resp = await _returnApi.querylistInvoice(tipo, tp, numero);
    return resp;
  }

  Future getInvoice(String tipo, String tp, String numero) async {
    factura = await _returnApi.queryInvoice(tipo, tp, numero);
  }

  Future clearItem(String factura, String producto) async {
    listSolicitudes.removeWhere(
        (element) => element.numMov == factura && element.codPro == producto);
    notifyListeners();
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

  Future<bool> verificarMotivoG() async {
    bool resp = false;
    if (isSelectAll) {
      for (var element in listaTemp) {
        if (element.codMotivo == "00") {
          isSelectAll = true;
          resp = true;
          break;
        }
      }
    }

    return resp;
  }

  bool verificarExistenciaFact(String facture) {
    bool resp = false;

    if (listSolicitudes.isNotEmpty) {
      resp = listSolicitudes.any((e) => e.numMov.contains(facture));
    }

    return resp;
  }

  Future<bool> verificarCantG() async {
    bool resp = false;
    if (isSelectAll) {
      for (var element in listaTemp) {
        resp = await verificarCantidad(int.parse(element.cantidad), element);
        if (resp) {
          resp = true;
          break;
        }
      }
    }

    return resp;
  }

  //hacer metodo de verificacion

  Future<bool> getCliente(String token, String vendcode) async {
    bool opt = false;
    final resp = await _returnApi.queryClienteVen(
        token, vendcode.toUpperCase(), isBloqueo ? "O" : "");
    if (resp!.isNotEmpty) {
      nombCli.text = resp.first.nomRef;
      valVendedor = vendcode;
    } else {
      nombCli.text = "";
      codCli.text = "";
      opt = true;
    }
    return opt;
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

  Future<bool> verificar(String factura) async {
    String resp =
        await _returnApi.checkClientFactura("01", codCli.text, factura);
    return resp == codVen.text;
  }

  Future<String> generarProcesso() async {
    String ticket = await _returnApi.postListIg0063(listSolicitudes);
    for (var element in listArchivos) {
      if (element.tipo == "Garantía") {
        await _returnApi.uploadDocument(
            element.archivo, "InfTec-$ticket-${element.item.codPro}");
      }
    }
    await convertKarmov(ticket);
    return ticket;
  }

  onSelectedRow(List<DataGridRow> x, List<DataGridRow> y) {
    if (x.isNotEmpty) {
      for (var element in x) {
        var detalle = element.getCells()[4].value;
        var isExitencia = listaTemp
            .where((e) => e.item.codPro == detalle.item.codPro)
            .toList();
        if (isExitencia.isEmpty) {
          detalle.bloqueo = true;
          detalle.controller.text = '${detalle.item.canMov}';
          detalle.cantidad = '${detalle.item.canMov}';
          updateListTemp(detalle);
          listaTemp.add(detalle);
        }
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
    isSelectAll = listaTemp.length == listDetailInvoiceUser.length;

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

  Future<List<Alterno>> getAlternos(String producto) async {
    var x = await _returnApi.getAlternos("01", producto);
    return x;
  }

  Future<bool> verificarCantidad(int x, Detail detalle) async {
    countIntems = await _returnApi.verificarCantidad(
        detalle.item.numMov, detalle.item.codPro);

    return x > double.parse(countIntems);
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
      btn = "Ingresar Razón";
      valItemTipo = "Devolución";
      selectComboMotivo = e.codMotivo;
      controllerD.text = "";
      controllerG.text = "";
    }
  }

  Future<bool> getVendedor(String codigo) async {
    bool opt = false;
    final resp = await _returnApi.querySeller(codigo);
    if (resp != null) {
      nombVen.text = resp.nomRef;
      opt = true;
    } else {
      opt = false;
    }

    notifyListeners();
    return opt;
  }

  Future getVendedorInicial() async {
    await callValueConst();
    if (permisos.substring(14) == "V") {
      listVCallCenter =
          await _returnApi.querylistCallCenter("01", tokenUser!.ctaUsr);
      if (listVCallCenter.isNotEmpty) {
        codVen.text = listVCallCenter[0].omision;
        isBloqueo = true;
        await callEventInt();
        await callEventCliente(codVen.text);
      }
    } else {
      final resp = await _returnApi.querySeller(tokenUser!.ctaUsr);
      isBloqueo = false;
      if (resp != null) {
        codVen.text = tokenUser!.ctaUsr;
        nombVen.text = resp.nomRef;
        await callEventInt();
      }
    }
    notifyListeners();
  }

  Future callEventCliente(String usuario) async {
    final resp = await _returnApi.querySeller(usuario);
    if (resp != null) {
      codVen.text = isBloqueo ? resp.codRef : tokenUser!.ctaUsr;
      nombVen.text = resp.nomRef;
    }
  }

  Future callEventInt() async {
    listMotivos = await _returnApi.querylistMotivos("10", "1");
    listSeries = await _returnApi.querylistSeries();
    if (listMotivos.isNotEmpty) {
      listMotivos.add(Motivo(
          cICmg: "00",
          codCmg: "00",
          nomCmg: "SELECCIONE UN MOTIVO",
          numMes: 0));
    }
  }

  Future convertKarmov(String tic) async {
    List<Karmov> list = [];
    List<Alterno> alternos = [];
    int i = 1;
    String correo1 = "";
    String correo2 = "";

    try {
      for (var element in listSolicitudes) {
        alternos = await getAlternos(element.codPro);

        var karmov = Karmov(
            codEmp: element.codEmp,
            codPto: "01",
            codMov: "NC",
            numMov: tic,
            fecMov: DateTime.now(),
            cx1Mov: element.codMov,
            nx1Mov: "",
            fx1Mov: "",
            cx2Mov: element.codMov,
            nx2Mov: element.numMov,
            fx2Mov: element.frmSdv,
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
            sdaMov: element.clsMdm,
            odaMov: element.codVen,
            bodMov: "01",
            auxilia: element.ucrSdv,
            secMov: "${element.secMov}",
            uduMov: "*",
            fytMov: DateTime.now().toIso8601String());

        for (var element in alternos) {
          if (i == 1) {
            karmov.codAl1 = element.codAlt;
          }
          if (i == 2) {
            karmov.codAl2 = element.codAlt;
          }
          if (i == 3) {
            karmov.codAl3 = element.codAlt;
          }
          i++;
        }
        list.add(karmov);
        i = 1;
      }

      correo1 = tokenUser!.codUsr.trim() == "ACEF"
          ? tokenUser!.corUsr
          : await _returnApi.getCorreoUsuario("01", tokenUser!.ctaUsr);

      correo2 = await _returnApi.getCorreoUsuario("01", codCli.text);

      await CreateFilePdf()
          .pdf4(listSolicitudes, factura!.nomRef, "$correo1,$correo2", tic);

      listSolicitudes.clear();
      listArchivos.clear();
      numMov.text = "";
      codCli.text = "";
      nombCli.text = "";
    } catch (e) {
      print(e);
    }

    await _returnApi.postKarmov(list);
  }
}

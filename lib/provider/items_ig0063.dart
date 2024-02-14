import 'dart:convert';

import 'package:devolucion_modulo/models/alterno.dart';
import 'package:devolucion_modulo/models/email.dart';
import 'package:devolucion_modulo/models/menuItem.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_bodega.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/models/yk0001.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:devolucion_modulo/ui/cards/other_details2.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog.dart';
import 'package:devolucion_modulo/util/save_file_web.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/models/kardex.dart';
import 'package:intl/intl.dart';

class ItemsIg0063 extends ChangeNotifier {
  List<Ig0063Response> itemsCliente = [];
  List<Ig0063Response> tempItemsClient = [];
  List<DetailBodega> listBodega = [];
  List<Yk0001> listVCallCenter = [];

  final returnApi = ReturnApi();

  final txtInicio = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final txtFin = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final txtObs = TextEditingController();

  Usuario? tokenUser;
  String permisos = "";

  List<MenuItem> menuResponseItems = const [
    MenuItem(uid: "1", text: "Detalle", icon: Icons.assignment_rounded),
    MenuItem(uid: "2", text: "Transporte", icon: Icons.drive_eta_rounded),
    MenuItem(uid: "3", text: "Historial", icon: Icons.history),
    MenuItem(uid: "4", text: "Anular", icon: Icons.block_outlined)
  ];

  getListItems() async {
    callValueConst();
    this.itemsCliente = [];
    final resp = await returnApi.listIg0063(UtilView.usuario.ctaUsr);
    this.itemsCliente = [...resp];
    notifyListeners();
  }

  Future callValueConst() async {
    tokenUser =
        Usuario.fromMap(jsonDecode(LocalStorage.prefs.getString('usuario')!));
    permisos = LocalStorage.prefs.getString('permiss')!;
  }

  Future<String> createBatchReturn() async {
    return await returnApi.generarLoteNC(
        "01",
        "01",
        UtilView.dateFormatYMD(txtInicio.text),
        UtilView.dateFormatYMD(txtFin.text));
  }

  getListItemsVendedor() async {
    itemsCliente = [];
    callValueConst();
    if (permisos.substring(14) == "V") {
      listVCallCenter =
          await returnApi.querylistCallCenter("01", tokenUser!.ctaUsr);
    }
    final resp = await returnApi.listIg0063Vendedor(listVCallCenter.isNotEmpty
        ? obtenerNombres(listVCallCenter)
        : UtilView.usuario.ctaUsr);

    this.itemsCliente = [...resp];

    notifyListeners();
  }

  String obtenerNombres(List<Yk0001> lista) {
    String nombresConcatenados = "";
    for (Yk0001 objeto in lista) {
      nombresConcatenados += "'${objeto.omision}',";
    }
    nombresConcatenados =
        nombresConcatenados.substring(0, nombresConcatenados.length - 1);
    return nombresConcatenados;
  }

  saveComentario(Ig0063Response objeto) async {
    final resp = await returnApi.updateComentarioIg0063(objeto);
    UtilView.messageAccess(resp == "1" ? "OK-COMENTARIO" : "ERROR");
  }

  Future<List<Alterno>> getAlternos(String producto) async {
    var x = await returnApi.getAlternos("01", producto);
    return x;
  }

  getUpdateTransport(String numero, dynamic mapa) async {
    this.itemsCliente = this.itemsCliente.map((transport) {
      if (transport.numSdv == numero) {
        transport.codCop = mapa["cod_cop"];
        transport.nomCop = mapa["nom_cop"];
        transport.ngrCop = mapa["ngr_cop"];
        transport.fgrCop = mapa["fgr_cop"].toString().split("T")[0];
        transport.bltCop = double.parse(mapa["blt_cop"]);
        transport.destino = mapa["destino"];
        return transport;
      }
      return transport;
    }).toList();
    notifyListeners();
  }

  void proceso1(DetailBodega objeto) {
    this.listBodega = this.listBodega.map((e) {
      if (e.item.codPro == objeto.item.codPro) {
        return e;
      }
      return e;
    }).toList();
  }

  Future getListItemsDetail(
      String numSdv, String factura, String clsSdv) async {
    listBodega.clear();
    tempItemsClient.clear();
    tempItemsClient = await returnApi.listDetailIg0063(numSdv, factura, clsSdv);
  }

  Future<List<Kardex>> getListKardex(
      String nummov, String codpro, String documento, String tipo) async {
    final resp = await returnApi.getKardex66(nummov, codpro, documento, tipo);
    return resp;
  }

  void showDetails(BuildContext c, Ig0063Response data) async =>
      await showDialog<bool>(
        context: c,
        builder: (_) => CustomDialog(
          showPadding: false,
          child: OtherDetails2(data: data),
        ),
      );

  Future<bool> cerrarList(String usuario, Ig0063Response e) async {
    String uid = "";
    bool resp = false;
    if (verificarRevision()) {
      await returnApi.updateEstatusIg0063(
          e.numSdv, e.codRef, e.numMov, e.clsSdv, usuario);
      uid = e.numSdv;
      //for (DetailBodega e in listBodega) {
      //}
      itemsCliente.removeWhere((element) => element.numSdv == uid);
      //CreateFilePdf().pdf5(listBodega);
      notifyListeners();
      resp = true;
    }
    return resp;
  }

  bool verificarRevision() {
    bool resp = false;
    for (DetailBodega e in listBodega) {
      if (e.item.canB93 != 0) {
        if (e.item.canB94 == 0 && e.item.canB95 == 0 && e.item.canB96 == 0) {
          resp = false;
          UtilView.messageWarning(
              "ERROR :: ITEM EN SOLO REVISION TECNICA [${e.item.codPro}]");
          break;
        } else {
          resp = true;
        }
      } else {
        resp = true;
      }
    }

    return resp;
  }

  Future downloadDocument(Ig0063Response element) async {
    String resp = "false";

    if (element.clsMdm == "G") {
      resp = await returnApi
          .downloadBase64Info("InfTec-${element.numSdv}-${element.codPro}.pdf");
      if (resp != "false") {
        FileSaveHelper.createLaunchFile2(
            "${element.numSdv}-${element.codPro}.pdf", resp);
      } else {
        UtilView.messageWarning("Error en la descarga");
      }
    }
  }

  Future<String> updateBodega(
      String uid, String bod1, String value, String bod2) async {
    return await returnApi.updateBodega(uid, bod1, value, bod2);
  }

  void postIg0063Update(Ig0063Response item) async {
    await returnApi.postIg0063Update(item);
  }

  Future clearItem(String code) async {
    itemsCliente.removeWhere((element) => element.numSdv == code);
    notifyListeners();
  }

  void registroKardex(Ig0063Response e, String cantidad, String bodega,
      String signo, double resuido) async {
    await returnApi.postKardex(Kardex(
        codEmp: "01",
        codPto: "01",
        clsSdv: e.clsSdv,
        codMov: "SD",
        numMov: e.numSdv,
        fecMov: DateTime.now(),
        codRel: e.codMov,
        numRel: e.numMov,
        fecRel: DateTime.now(),
        codRef: e.codRef,
        nomRef: "",
        codPro: e.codPro,
        codBod: bodega,
        canMov: double.parse(cantidad),
        pacCos: resuido,
        vacCos: 0,
        codMdm: e.codMdm,
        obsMdm: e.obsMdm,
        obsMov: "",
        ucrMov: "",
        dcrMov: DateTime.now(),
        uacMov: "",
        dacMov: DateTime.now(),
        somMov: signo,
        stsMov: "1"));
  }

  Future<String> anularProceso(Ig0063Response objeto, String error) async {
    String x = await returnApi.anularNC(
        "NC",
        objeto.numSdv.trim(),
        "ANULADO POR $error - USER: ${tokenUser!.ctaUsr}",
        objeto.clsSdv,
        objeto.numMov.trim());

    if (x != "") {
      String correo1 = await returnApi.getCorreoUsuario("01", objeto.codRef);
      String correo2 = await returnApi.getCorreoUsuario("01", objeto.codVen);
      String correo3 = tokenUser!.corUsr;

      await returnApi.sendEmailDev(Email(
          to: correo3.trim(),
          cc: "$correo1,$correo2",
          subject: "Anulación de su Solicitud de Devolución #${objeto.numSdv}",
          body:
              "Estimado usuario, <br/><br/>Hemos revisado cuidadosamente su solicitud y hemos detectado un problema que impide procesarla en este momento.<br/>Este problema puede estar relacionado con [$error].<br/>Lamentamos cualquier inconveniente que esto pueda causarle y agradecemos su comprensión en este asunto. Esperamos poder resolver esta situación satisfactoriamente para usted.<br/><br/> Saludos,<br/>COJAPAN C.LTDA.",
          attachment: []));
    }

    return x;
  }
}

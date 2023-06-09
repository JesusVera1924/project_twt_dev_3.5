import 'package:devolucion_modulo/models/alterno.dart';
import 'package:devolucion_modulo/models/menuItem.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_bodega.dart';
import 'package:devolucion_modulo/ui/cards/other_details2.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/models/kardex.dart';

class ItemsIg0063 extends ChangeNotifier {
  List<Ig0063Response> itemsCliente = [];
  List<Ig0063Response> tempItemsClient = [];
  List<DetailBodega> listBodega = [];
  ReturnApi returnApi = ReturnApi();
  List<MenuItem> menuResponseItems = const [
    MenuItem(uid: "1", text: "Detalle", icon: Icons.assignment_rounded),
    MenuItem(uid: "2", text: "Transporte", icon: Icons.drive_eta_rounded),
    MenuItem(uid: "3", text: "Historial", icon: Icons.history)
  ];

  getListItems() async {
    this.itemsCliente = [];
    final resp = await returnApi.listIg0063(UtilView.usuario.ctaUsr);
    this.itemsCliente = [...resp];
    notifyListeners();
  }

  getListItemsVendedor(String codigo) async {
    this.itemsCliente = [];
    this.tempItemsClient = [];
    final resp = await returnApi.listIg0063Vendedor(codigo);
    this.itemsCliente = [...resp];
    this.tempItemsClient = [...resp];
    notifyListeners();
  }

  getRenew() async {
    final resp = await returnApi.listIg0063(UtilView.usuario.ctaUsr);
    this.itemsCliente = [...resp];
    notifyListeners();
  }

  getListNumero(String numero) async {
    final resp = this.itemsCliente.where((element) => element.numMov == numero);
    this.itemsCliente = [...resp];
    notifyListeners();
  }

  Future<List<Alterno>> getAlternos(String producto) async {
    var x = await returnApi.getAlternos("01", producto);
    return x;
  }

  getListBeteween(DateTime antes, DateTime despues) async {
    if (antes.compareTo(despues) == 0) {
      String fecha = DateFormat('yyyy-MM-dd').format(despues);
      despues = despues.add(const Duration(days: 1));
      final resp =
          this.itemsCliente.where((element) => element.fecSdv == fecha);
      this.itemsCliente = [...resp];
    } else {
      final resp = this.itemsCliente.where((element) =>
          antes.isBefore(DateTime.parse(element.fecSdv)) &&
          despues.isAfter(DateTime.parse(element.fecSdv)));
      this.itemsCliente = [...resp];
    }

    notifyListeners();
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

  Future getListItemsDetail(String numSdv, String clsSdv) async {
    listBodega.clear();
    tempItemsClient.clear();
    tempItemsClient = await returnApi.listDetailIg0063(numSdv, clsSdv);
  }

  Future<List<Kardex>> getListKardex(
      String nummov, String codpro, String documento) async {
    final resp = await returnApi.getKardex66(nummov, codpro, documento);
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

  Future<bool> cerrarList() async {
    String uid = "";
    bool resp = false;
    if (verificarRevision()) {
      for (DetailBodega e in listBodega) {
        await returnApi.updateEstatusIg0063(e.item.numSdv, e.item.codRef);
        uid = e.item.numSdv;
      }
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

  void updateBodega(String uid, String bod1, String value, String bod2) async {
    await returnApi.updateBodega(uid, bod1, value, bod2);
  }

  void postIg0063Update(Ig0063Response item) async {
    await returnApi.postIg0063Update(item);
  }

  void registroKardex(Ig0063Response e, String cantidad, String bodega,
      String signo, double resuido) async {
    await returnApi.postKardex(Kardex(
        codEmp: "01",
        codPto: "01",
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
}

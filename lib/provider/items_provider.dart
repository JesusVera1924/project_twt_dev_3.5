import 'package:devolucion_modulo/models/kardex.dart';
import 'package:devolucion_modulo/models/menuItem.dart';
import 'package:devolucion_modulo/util/save_file_web.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/inner/ig0062Response.dart';
import 'package:devolucion_modulo/services/local_storage.dart';

class ItemsProvider extends ChangeNotifier {
  List<Ig0062Response> itemsCliente = [];
  List<Ig0062Response> itemsDetail = [];
  List<Ig0062Response> listBase = [];

  List<MenuItem> menuResponseItems = const [
    MenuItem(uid: "1", text: "Detalle", icon: Icons.assignment_rounded),
    MenuItem(uid: "2", text: "Transporte", icon: Icons.drive_eta_rounded),
    MenuItem(uid: "3", text: "Autorización", icon: Icons.check_circle)
  ];

  ReturnApi returnApi = ReturnApi();

  getItemsClient() async {
    final token = LocalStorage.prefs.getString('token');
    final resp = await returnApi.listViewCliente(token!);
    this.itemsCliente = [...resp];
    notifyListeners();
  }

  getListItems() async {
    itemsCliente = await returnApi.listIg0062();
    listBase = itemsCliente;
    notifyListeners();
  }

  getRenew() {
    this.itemsCliente = [...listBase];
    notifyListeners();
  }

  getUpdateRegistro(Ig0062Response objeto, double value) {
    this.itemsDetail = this.itemsDetail.map((item) {
      if (item.numSdv == objeto.numSdv && item.codPro == objeto.codPro) {
        item.canSdv = value;
        return item;
      }
      return item;
    }).toList();
    notifyListeners();
  }

  void proceso3(Ig0062Response row) async {
    String resp = "false";

    for (var element in itemsDetail) {
      if (element.clsMdm == "G" && element.codPro == row.codPro) {
        resp = await returnApi
            .downloadBase64("InfTec-${element.numSdv}-${element.codPro}.pdf");
        if (resp != "false") {
          FileSaveHelper.createLaunchFile2(
              "${element.numSdv}-${element.codPro}.pdf", resp);

          if (row.kd1Mdm == "0") {
            resp = await returnApi.updateDoc(
                element.codEmp, element.numSdv, element.codPro);

            if (resp == "0") {
              UtilView.messageWarning("Error en la descarga");
            } else {
              getUpdateListDoc(row.numSdv);
            }
          }
        }
      }
    }
  }

  getUpdateDbRegistro(Ig0062Response e) async {
    var respuesta = await returnApi.updateBodegaCantidad(
        e.codEmp, e.numSdv, e.codPro, e.canSdv);

    if (respuesta != "0") {
      UtilView.messageAccess(respuesta);
    } else {
      UtilView.messageAccess("Error no se completo la tarea");
    }

    notifyListeners();
  }

  getUpdateList(String numero) async {
    await returnApi.uploadEstado("01", numero);
    this.itemsCliente = this.itemsCliente.map((item) {
      if (item.numSdv != numero) return item;
      item.stsSdv = "E";
      return item;
    }).toList();
    notifyListeners();
  }

  deleteObjetoList(String uid) async {
    itemsCliente
        .remove(itemsCliente.singleWhere((element) => element.numSdv == uid));
    notifyListeners();
  }

  getUpdateListDoc(String numero) async {
    this.itemsCliente = this.itemsCliente.map((e) {
      if (e.numSdv != numero) return e;
      e.kd1Mdm = "1";
      return e;
    }).toList();
    notifyListeners();
  }

  getUpdateTransport(String numero, dynamic mapa) async {
    this.itemsCliente = this.itemsCliente.map((category) {
      if (category.numSdv == numero) {
        category.codCop = mapa["cod_cop"];
        category.nomCop = mapa["nom_cop"];
        category.ngrCop = mapa["ngr_cop"];
        category.fgrCop = mapa["frg_cop"];
        category.bltCop = double.parse(mapa["blt_cop"]);
        category.destino = mapa["destino"];
        return category;
      }
      return category;
    }).toList();
    notifyListeners();
  }

  postObject(Ig0062Response obj) async {
    try {
      await returnApi.postIg0063(desglozadoInfo(obj));
    } catch (e) {
      throw ("Error en el POST: $e");
    }
  }

  Ig0063 desglozadoInfo(Ig0062Response val) {
    Ig0063 obj = Ig0063(
        codEmp: val.codEmp,
        clsSdv: 'C',
        codVen: val.codVen,
        numSdv: val.numSdv,
        fecSdv: "${val.fecSdv}T19:30:45.177+00:00",
        nunSdv: val.nunSdv,
        frmSdv: "${val.frmSdv}T19:30:45.177+00:00",
        codRef: val.codRef,
        codPto: val.codPto,
        codMov: val.codMov,
        numMov: val.numMov,
        fecMov: val.fecMov,
        frmMov: "1800-01-01T19:30:45.177+00:00", // no trae el dato
        secMov: val.secMov,
        codPro: val.codPro,
        canB91: val.canSdv,
        canB92: val.canSdv,
        canB93: 0,
        canB94: 0,
        canB95: 0,
        canB96: 0,
        clsMdm: val.clsMdm,
        codMdm: val.codMdm,
        obsMdm: val.obsMdm,
        codMrm: "",
        obsMrm: "",
        ofsSdv: val.ofsSdv,
        obsSdv: val.obsSdv,
        codCop: val.codCop,
        nomCop: val.nomCop,
        ngrCop: val.ngrCop,
        fgrCop: val.fgrCop,
        bltCop: val.bltCop,
        destino: val.destino,
        ptoRel: val.ptoRel,
        codRel: val.codRel,
        numRel: val.numRel,
        fecRel: val.fecRel,
        ptoNex: val.ptoNex,
        codNex: val.codNex,
        numNex: val.numNex,
        fecNex: val.fecNex,
        swsSdv: val.swsSdv,
        ucrSdv: val.ucrSdv,
        fcrSdv: val.fcrSdv,
        uacSdv: val.uacSdv,
        facSdv: val.facSdv,
        uapSdv: val.uapSdv,
        fapSdv: val.fapSdv,
        stsSdv: "P");
    return obj;
  }

//---------

  detailList(String value) async {
    itemsDetail = await returnApi.listDetailIg0062(value);
    notifyListeners();
  }

  cerraLinea(String codigo) async {
    if (itemsDetail.isNotEmpty) {
      for (var e in itemsDetail) {
        if (e.numSdv == codigo) {
          postObject(e);
          final opt =
              await returnApi.updateBodega2(e.codPro, "92", "${e.canSdv}");

          /* final opt = await returnApi.postBodega(Bodega(
            codEmp: "01",
            codPro: e.codPro,
            codBod: "92",
            exiInv: e.canMov as int,
            fIFis: DateTime.now(),
          )); */

          if (opt != "0") {
            returnApi.postKardex(Kardex(
                codEmp: "01",
                codPto: "01",
                clsSdv: "C",
                codMov: e.codMov,
                numMov: e.numMov,
                fecMov: DateTime.now(),
                codRel: e.codMov,
                numRel: e.numMov,
                fecRel: DateTime.now(),
                codRef: e.codRef,
                nomRef: "",
                codPro: e.codPro,
                codBod: "92",
                canMov: e.canSdv,
                pacCos: 0,
                vacCos: 0,
                codMdm: e.codMdm,
                obsMdm: e.obsMdm,
                obsMov: "",
                ucrMov: "",
                dcrMov: DateTime.now(),
                uacMov: "",
                dacMov: DateTime.now(),
                somMov: "+",
                stsMov: "1"));
          }
        }
      }
    }
    deleteObjetoList(codigo);
  }
}

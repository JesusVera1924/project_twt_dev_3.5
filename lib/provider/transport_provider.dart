import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/transport.dart';
import 'package:flutter/material.dart';

class TrasnsportProvider with ChangeNotifier {
  List<Transport> listTransport = [];
  ReturnApi api = ReturnApi();

  TextEditingController controllerCod = TextEditingController();
  TextEditingController controllerNom = TextEditingController();
  TextEditingController controllerNgr = TextEditingController();
  TextEditingController controllerFgr = TextEditingController();
  TextEditingController controllerBlt = TextEditingController();
  String destino = "MATRIZ";

  void setCompleInfo(mapa) {
    controllerCod.text = mapa["cod_cop"] != "" ? mapa["cod_cop"] : "";
    controllerNom.text = mapa["nom_cop"] != "" ? mapa["nom_cop"] : "";
    controllerNgr.text = mapa["ngr_cop"] != "" ? mapa["ngr_cop"] : "";
    controllerFgr.text = !mapa["frg_cop"].toString().contains("T")
        ? formatt(mapa["frg_cop"])
        : "";
    controllerBlt.text = mapa["blt_cop"] != "" ? mapa["blt_cop"] : "";
    destino = mapa["destino"] != "" ? mapa["destino"] : destino;
    notifyListeners();
  }

  String formatt(String fecha) {
    var formtt = fecha.split("-");
    return "${formtt[2]}/${formtt[1]}/${formtt[0]}";
  }

  Future<bool> searchText(String value) async {
    listTransport = await api.queryTransport(value.toUpperCase());
    return listTransport.isNotEmpty;
  }

  limpiar() {
    controllerCod.clear();
    controllerNom.clear();
    controllerNgr.clear();
    controllerFgr.clear();
    controllerBlt.clear();
    destino = "Matriz";
  }

  Future<Map<String, String>> updateTransport(String numero, bool tipo) async {
    dynamic map = await api.uploadTransp(
        numero,
        controllerCod.text,
        controllerNom.text,
        controllerNgr.text,
        controllerFgr.text,
        controllerBlt.text,
        destino,
        tipo);

    return map;
  }
}

/*

2021-10-10
10-10-2021
  */

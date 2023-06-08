import 'package:devolucion_modulo/models/modifyModel/detail_bodega.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UtilView {
  static late Usuario usuario;

  static List<String> list = [
    "MATRIZ",
    "AV.MACHALA",
    "AV.AMERICAS",
    "ENTREGA A DOMICILIO",
    "RETIRO TERMINAL",
    "RETIRO AGENCIA"
  ];

  static List<String> radiusCivil = [
    "Soltero",
    "Casado",
    "Union libre",
    "Divorciado",
    "Viudo"
  ];
  static List<String> radiusPersona = ["Persona Natural", "Persona Juridica"];

  static List<String> radiusLocal = ["Alquilado", "Propio"];

  static List<String> radiusSolicitud = ["Contado", "Crédito"];

  static List<String> comboDocumento = ["Cedula", "Ruc", "Pasaporte"];

  static List<String> radiusNegocio = [
    "Detallista",
    "Recorredor",
    "Mayorista",
    "Importadora"
  ];
  static List<String> listArchivo = [
    "Copia de cedula - Planilla de servicios basicos "
  ];

  static List<String> listTipoCta = ["Ahorro", "Corriente"];

  static List<String> lisDecision = ["Si", "No"];

  static messageDanger(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "red",
    );
  }

  static DateTime convertStringToDate(String cadena) {
    return DateFormat("dd/MM/yyyy").parse(cadena).add(const Duration(hours: 5));
  }

  static String convertDateToString() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }

  static messageAccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: 'rgb(46,64,83)',
    );
  }

  static messageWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "orange",
    );
  }

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static empresa(String cadena) {
    return cadena == '01' ? "Cojapan" : "Marcella";
  }

  //CASOS
  static int selectTipoNegocio(String opt) {
    var mapa = {"R": 0, "D": 1, "M": 2, "I": 3};
    return mapa[opt] ?? 0;
  }

  static String optionEstado(DetailBodega objeto) {
    String resp = "";

    if (objeto.item.canB93 != 0) {
      resp = "EN REVISIÓN";
    } else if (objeto.item.canB91 == objeto.item.canB94) {
      resp = "APROBADO";
    } else if (objeto.item.canB91 == objeto.item.canB95) {
      resp = "RECHAZADO";
    } else if (objeto.item.canB91 == objeto.item.canB96) {
      resp = "APROBADO";
    } else if (objeto.item.canB94 != 0 ||
        objeto.item.canB95 != 0 ||
        objeto.item.canB96 != 0) {
      resp = "PARCIALES";
    } else {
      resp = "-----";
    }

    return resp;
  }

  static Widget buildTrustWorthiness(String value) {
    final String trust = value == "D" ? "Devolución" : "Garantia";
    if (value == 'D') {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: getWidget(Image.asset('assets/Perfect.png'), trust),
      );
    } else if (value == 'G') {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: getWidget(Image.asset('assets/Sufficient.png'), trust),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: getWidget(Image.asset('assets/Insufficient.png'), trust),
      );
    }
  }

  static Widget getWidget(Widget image, String text) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Container(
            child: image,
          ),
          const SizedBox(width: 6),
          Expanded(
              child: Text(
            text,
            style: getStatusTextStyle(text),
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }

  static TextStyle getStatusTextStyle(dynamic value) {
    if (value == 'D') {
      return const TextStyle(color: Colors.green);
    } else {
      return TextStyle(color: Colors.purple[900]);
    }
  }

  static String selectBodega(String value) {
    String respuesta = "";
    switch (value) {
      case "91":
        respuesta = "REFERENCIA";
        break;
      case "92":
        respuesta = "Recepción";
        break;
      case "93":
        respuesta = "Revisión Tecnica";
        break;
      case "94":
        respuesta = "Aprobado";
        break;
      case "95":
        respuesta = "Rechazado";
        break;
      case "96":
        respuesta = "Garantia";
        break;
    }
    return respuesta;
  }

  static String firmaDocumento() {
    DateTime date = DateTime.now();
    return '${date.day.toString().padLeft(2, '0')}${date.month.toString().padLeft(2, '0')}${date.year}_${date.hour}_${date.minute}';
  }

  static Widget checkStatu(String statu) {
    switch (statu) {
      case "P":
        return const Tooltip(
          message: "Pendiente",
          child: Icon(
            Icons.access_time,
            color: Colors.blueAccent,
          ),
        );
      case "E":
        return Tooltip(
          message: "En proceso",
          child: Icon(
            Icons.handyman_rounded,
            color: Colors.amberAccent[700],
          ),
        );
      case "C":
        return const Tooltip(
          message: "Terminado",
          child: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
        );
      case "R":
        return const Tooltip(
          message: "Rechazado",
          child: Icon(
            Icons.cancel_outlined,
            color: Colors.red,
          ),
        );
      default:
        return const Icon(
          Icons.warning_amber_rounded,
          color: Colors.amberAccent,
        );
    }
  }
}

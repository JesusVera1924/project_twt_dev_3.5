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

  static DateTime convertStringToDate(String cadena) {
    return DateFormat("dd/MM/yyyy").parse(cadena).add(const Duration(hours: 5));
  }

  static String convertDateToString() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
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

  static String dateFormatDMY(String cadena) {
    DateTime date = DateTime.parse(cadena);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String dateFormatYMD(String cadena) {
    return '${cadena.toString().substring(6, 10)}-${cadena.toString().substring(3, 5)}-${cadena.toString().substring(0, 2)}';
  }

  static String firmaDocumento() {
    DateTime date = DateTime.now();
    return '${date.day.toString().padLeft(2, '0')}${date.month.toString().padLeft(2, '0')}${date.year}_${date.hour}_${date.minute}';
  }

  static Widget checkStatu(String statu) {
    switch (statu) {
      case "P":
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time, color: Colors.black),
            Text("Pendiente",
                style: TextStyle(color: Colors.black, fontSize: 12))
          ],
        );
      case "E":
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time, color: Colors.amberAccent[700]),
            Text("Generado",
                style: TextStyle(color: Colors.amberAccent[700], fontSize: 12))
          ],
        );
      case "G":
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time, color: Colors.amberAccent[700]),
            Text("Generado",
                style: TextStyle(color: Colors.amberAccent[700], fontSize: 12))
          ],
        );

      case "C":
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green),
            Text("Terminado",
                style: TextStyle(color: Colors.green, fontSize: 12))
          ],
        );
      case "A":
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.playlist_add_check_circle_rounded,
                color: Colors.amber[900]),
            Text("Autorizado",
                style: TextStyle(color: Colors.amber[900], fontSize: 12))
          ],
        );

      case "R":
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cancel_outlined, color: Colors.red),
            Text("Rechazado", style: TextStyle(color: Colors.red, fontSize: 12))
          ],
        );

      case "X":
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_rounded, color: Colors.red),
            Text("Anulado", style: TextStyle(color: Colors.red, fontSize: 12))
          ],
        );
      default:
        return const Icon(
          Icons.warning_amber_rounded,
          color: Colors.amberAccent,
        );
    }
  }

  static messageDanger(String _message) {
    Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 12,
      webPosition: "center",
      webBgColor: "red",
    );
  }

  static messageAccess(String _message) {
    Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
      fontSize: 12,
      webPosition: "center",
      webBgColor: 'rgb(46,64,83)',
    );
  }

  static messageWarning(String _message) {
    Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.yellowAccent,
      textColor: Colors.white,
      fontSize: 12,
      webPosition: "center",
      webBgColor: "orange",
    );
  }

  static Future launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devolucion_modulo/models/cliente.dart';
import 'package:devolucion_modulo/models/mg0030.dart';
import 'package:devolucion_modulo/models/mg0031.dart';

class CreditApi {
  //static String baseUrl = "http://192.168.100.4:8084/desarrollosolicitud";
  static String baseUrl = "http://192.168.3.56:8084/desarrollosolicitud";
  //static String baseUrl = "http://181.39.96.138:8081/apisolicitud";

  Future<Mg0031> queryId(String identificacion) async {
    Mg0031 dato;
    var url = Uri.parse("$baseUrl/getsolicitud?cedula=$identificacion");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = Mg0031.fromJson(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<String> solicitudMax() async {
    var dato;
    var url = Uri.parse("$baseUrl/getmaxsoli?empresa=01");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future sendEmail(Mg0031 datos) async {
    var url = Uri.parse("$baseUrl/enviarCorreo");
    var bod = datos.toJson();
    final resquet = await http.post(url, body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

  Future uploadDocument(String base64, String titulo) async {
    var url = Uri.parse("$baseUrl/uploadpdf");
    try {
      final resquet = await http.post(
        url,
        headers: {"Content-type": "application/x-www-form-urlencoded"},
        body: {"image": base64, "data": titulo},
      );
      if (resquet.statusCode != 200) {
        throw Exception('Error: ${resquet.statusCode}');
      }
    } catch (e) {
      throw ('error el en POST: $e');
    }
  }

  Future postFormCredit(Mg0031 datos) async {
    var url = Uri.parse("$baseUrl/saveFormulario");
    var data = datos.toJson();
    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    });

    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    }
  }

  Future<List<Mg0030>> querylist(codigo) async {
    var url = Uri.parse("$baseUrl/getciudades?codigo=$codigo");

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseListPaises(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Mg0030> parseListPaises(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Mg0030>((json) => Mg0030.fromMap(json)).toList();
  }

  Future<List<Mg0031>> queryListCredit() async {
    var url = Uri.parse("$baseUrl/getsolicitud2?empresa=01");

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseListCredit(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Mg0031> parseListCredit(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Mg0031>((json) => Mg0031.fromMap(json)).toList();
  }

  Future updateCredit(Mg0031 obj) async {
    //var data = obj.toMap();
    var bod = json.encode(obj.toMap());

    final resquet = await http
        .post(Uri.parse("$baseUrl/updateFormulario"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de actualización : ${resquet.statusCode}');
    }
  }

  Future updateCreditEstado(String dni, String numero, String version) async {
    final data = {
      "cod_emp": "01",
      "sec_nic": dni,
      "num_sdc": numero,
      "nts_sdc": version,
      "sts_sdc": "R"
    };

    var bod = json.encode(data);
    final resquet = await http
        .post(Uri.parse("$baseUrl/updateFormulario2"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de actualización : ${resquet.statusCode}');
    }
  }

  Future<Cliente?> queryCliente(String code) async {
    dynamic resul;
    var url = Uri.parse("$baseUrl/getcliente?empresa=01&codigo=$code");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = Cliente.fromJson(utf8.decode(respuesta.bodyBytes));
        }
        return resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future postCorreo(
      String codRef, String datCli, String ordena, String tipo) async {
    final data = {
      "cod_emp": "01",
      "cod_ref": codRef,
      "dat_cli": datCli,
      "ordena": ordena,
      "cor_tel": tipo,
      "activo": "S"
    };

    var bod = json.encode(data);

    final resquet = await http
        .post(Uri.parse("$baseUrl/insertCorreo"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

  Future postCliente(Mg0031 datos) async {
    final data = {
      "cod_emp": "01",
      "cod_ref": datos.codRef,
      "cod_pai": "EC",
      "cod_zon": "ZG",
      "cod_div": "D",
      "persona": datos.secNic.length == 13 ? "1" : "0",
      "cal_cli": "1",
      "cal_voc": "0",
      "cal_oef": "0",
      "cal_bco": "0",
      "cal_obr": "0",
      "cal_prv": "0",
      "vol_ven": "P",
      "nom_ref": datos.nomRef,
      "cod_est": datos.estRef,
      "cod_ciu": datos.ciuRef,
      "dir_ref": datos.dirRef,
      "tel_ref": "${datos.mv1Per} ${datos.tlfPer} ${datos.tlfRef}",
      "cod_aux": datos.codRtc,
      "nom_aux": datos.nmcRef,
      "ced_ruc": datos.secNic,
      "plz_crd": datos.plzSdc,
      "lim_crd": datos.cupSdc,
      "sit_ref": datos.clsSdc
    };
    var bod = json.encode(data);
    final resquet = await http
        .post(Uri.parse("$baseUrl/insertReferencia"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

  Future<List<Cliente>> queryVendedor() async {
    dynamic resul;
    var url = Uri.parse("$baseUrl/getvendedor?empresa=01");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          return respuesta.body.toString() != "[]"
              ? parseVen(utf8.decode(respuesta.bodyBytes))
              : resul;
        }
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Cliente> parseVen(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cliente>((json) => Cliente.fromMap(json)).toList();
  }

  Future<String> downloadBase64(String data) async {
    String dato = "";
    var url = Uri.parse(
        "$baseUrl/downloaddoc?data=/u/TwTmicrolight/apptwo/cojapan/clientes/$data");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = utf8.decode(respuesta.bodyBytes) == "false"
            ? ""
            : utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:devolucion_modulo/models/karmov.dart';
import 'package:devolucion_modulo/models/repuesta.dart';
import 'package:devolucion_modulo/models/yk0001.dart';
import 'package:http/http.dart' as http;
import 'package:devolucion_modulo/models/alterno.dart';
import 'package:devolucion_modulo/models/bodega.dart';
import 'package:devolucion_modulo/models/cliente.dart';
import 'package:devolucion_modulo/models/correo.dart';
import 'package:devolucion_modulo/models/email.dart';
import 'package:devolucion_modulo/models/ig0062.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';
import 'package:devolucion_modulo/models/inner/ig0062Response.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/models/invoice.dart';
import 'package:devolucion_modulo/models/invoiceDetail.dart';
import 'package:devolucion_modulo/models/kardex.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/models/motivo.dart';
import 'package:devolucion_modulo/models/permisos.dart';
import 'package:devolucion_modulo/models/product.dart';
import 'package:devolucion_modulo/models/serie.dart';
import 'package:devolucion_modulo/models/transport.dart';
import 'package:devolucion_modulo/models/usuario.dart';

class ReturnApi {
  //static String baseUrl = "http://181.39.96.138:8081/desarrollosolicitud";
  static String baseUrl = "http://192.168.3.56:8084/desarrollosolicitud";
  //static String baseUrl = "http://192.168.100.4:8084/desarrollosolicitud";

  //Listado de motivos
  Future<List<Motivo>> querylistMotivos(String codigo, String estado) async {
    var url = Uri.parse("$baseUrl/getopciones?codigo=$codigo&estado=$estado");

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseListMotivos(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Motivo> parseListMotivos(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Motivo>((json) => Motivo.fromMap(json)).toList();
  }

  //Lista de series
  Future<List<Serie>> querylistSeries() async {
    var url = Uri.parse("$baseUrl/getseries");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseListSeries(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Serie> parseListSeries(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Serie>((json) => Serie.fromMap(json)).toList();
  }

  Future<List<Ig0062Response>> listViewCliente(String cliente) async {
    List<Ig0062Response> resul = [];
    var url =
        Uri.parse("$baseUrl/getdevolucionlist?empresa=01&cliente=$cliente");
    /*  print(url); */
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInnerIg0062(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Ig0062Response>> listDetailIg0062(String numero) async {
    List<Ig0062Response> resul = [];
    var url = Uri.parse("$baseUrl/getdevoluciondet?empresa=01&numero=$numero");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInnerIg0062(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw (' x error el en GET: $e');
    }
  }

  Future<List<Ig0062Response>> listIg0062() async {
    List<Ig0062Response> resul = [];
    var url = Uri.parse("$baseUrl/getdevolucion?empresa=01");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInnerIg0062(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Ig0062Response> parseInnerIg0062(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<Ig0062Response>((json) => Ig0062Response.fromMap(json))
        .toList();
  }

  Future<List<Ig0063Response>> listIg0063(String usuario) async {
    List<Ig0063Response> resul = [];
    var url = Uri.parse("$baseUrl/getdevolucion2?empresa=01&usuario=$usuario");

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInnerIg0063(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Ig0063Response>> listIg0063Vendedor(String ven) async {
    List<Ig0063Response> resul = [];
    var url = Uri.parse("$baseUrl/getdevolucionven?empresa=01&vendedor=$ven");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInnerIg0063(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Ig0063Response>> listDetailIg0063(
      String numero, String fac, String tipo) async {
    var url = Uri.parse(
        "$baseUrl/getdevolucionlist2?empresa=01&numero=$numero&factura=$fac&clase=$tipo");

    /* print(url.toString()); */

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInnerIg0063(utf8.decode(respuesta.bodyBytes))
            : [];
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Cliente>?> queryClienteVen(
      String codigo, String vendcode, String tipo) async {
    List<Cliente>? resul = [];
    var url = Uri.parse(
        "$baseUrl/getvenclientes?empresa=01&codigo=$codigo&vendedor=$vendcode&tipo=$tipo");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = respuesta.body.toString() != "[]"
              ? parseClientVen(utf8.decode(respuesta.bodyBytes))
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

  List<Cliente> parseClientVen(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cliente>((json) => Cliente.fromMap(json)).toList();
  }

  List<Ig0063Response> parseInnerIg0063(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<Ig0063Response>((json) => Ig0063Response.fromMap(json))
        .toList();
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

  Future<Cliente?> querySeller(String code) async {
    dynamic resul;
    var url = Uri.parse("$baseUrl/getseller?empresa=01&codigo=$code");

    print(url.toString());

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

  Future<List<Cliente>> queryClienteDni(String cedula) async {
    List<Cliente> resul = [];
    var url = Uri.parse("$baseUrl/getcedula?empresa=01&cedula=$cedula");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? resul = parseClient(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Cliente> parseClient(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cliente>((json) => Cliente.fromMap(json)).toList();
  }

  Future<List<Correo>> queryCorreo(String cliente) async {
    List<Correo> resul = [];
    var url = Uri.parse("$baseUrl/getcorreo?empresa=01&codigo=$cliente");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? resul = parseEmail(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Correo> parseEmail(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Correo>((json) => Correo.fromMap(json)).toList();
  }

  Future<String> fillCity(String code) async {
    var url = Uri.parse("$baseUrl/getciudad?codigo=$code");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  //obtener factura del cliente
  Future<Invoice?> queryInvoice(String punto, String tp, String numero) async {
    Invoice? resul;
    var url = Uri.parse(
        "$baseUrl/getfacturaNew?empresa=01&punto=$tp&codigo=$punto&numero=$numero");
    /* print(url); */
    try {
      http.Response respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        resul = utf8.decode(respuesta.bodyBytes) != ""
            ? Invoice.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  Future<List<Invoice>> querylistInvoice(
      String punto, String tp, String numero) async {
    dynamic resul;
    var url = Uri.parse(
        "$baseUrl/getfactura?empresa=01&punto=$tp&codigo=$punto&numero=$numero");
    /*  print(url); */
    try {
      http.Response respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInvoice(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Invoice> parseInvoice(String request) {
    final parseo = jsonDecode(request);
    return parseo.map<Invoice>((json) => Invoice.fromMap(json)).toList();
  }

  //Obtener el detalle de la factura por numero de factura
  Future<List<InvoiceDetail>> querylistInvoiceDetail(
      String tp, String numero, String codigo) async {
    //  print(tp + " --- " + numero + " --- " + codigo);
    var url = Uri.parse(
        "$baseUrl/getdetallefac?empresa=01&cliente=$codigo&codigo=$tp&numero=$numero");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseInvoiceDetail(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<InvoiceDetail> parseInvoiceDetail(String request) {
    final parseo = jsonDecode(request);
    return parseo
        .map<InvoiceDetail>((json) => InvoiceDetail.fromMap(json))
        .toList();
  }

  Future<List<DetailProductResponse>> listDetailProduct(
      String cliente, String punto, String numero) async {
    List<DetailProductResponse> resul = [];
    var url = Uri.parse(
        "$baseUrl/getdetallefac?empresa=01&cliente=$cliente&codigo=$punto&numero=$numero");

    /*  print(url.toString()); */

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseInnerResponseProduct(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<DetailProductResponse> parseInnerResponseProduct(String request) {
    final parseo = jsonDecode(request);
    return parseo
        .map<DetailProductResponse>(
            (json) => DetailProductResponse.fromMap(json))
        .toList();
  }

  Future<Product> queryProducto(String code) async {
    Product resul = Product();
    var url = Uri.parse("$baseUrl/getdetallepro?codigo=$code");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = Product.fromJson(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  Future<String> lastValue() async {
    String resul = "0";
    var url = Uri.parse("$baseUrl/getmaxdev?empresa=01");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "0"
            ? resul = respuesta.body.toString()
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<String> lastValueClase(String clase) async {
    String resul = "0";
    var url = Uri.parse("$baseUrl/getmaxdevolucion?empresa=01&clase=$clase");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "0"
            ? resul = respuesta.body.toString()
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Transport>> queryTransport(String codigo) async {
    List<Transport> obj = [];
    var url = Uri.parse("$baseUrl/gettransporte?empresa=01&codigo=$codigo");
    try {
      http.Response respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? parseTransport(utf8.decode(respuesta.bodyBytes))
            : obj;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Transport> parseTransport(String request) {
    final parseo = jsonDecode(request);
    return parseo.map<Transport>((json) => Transport.fromMap(json)).toList();
  }

  Future postFormReturn(Ig0062 datos) async {
    var bod = datos.toJson();
    //print(bod);
    var url = Uri.parse("$baseUrl/saveDevolucion");
    final resquet = await http.post(url, body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      //print('Formulario registrado con exito'); //
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

  Future<String> postKarmov(List<Karmov> datos) async {
    String resp = "";
    List<Map> bod = [];
    for (var element in datos) {
      bod.add(element.toMap());
    }
    var data = json.encode(bod);
    //print(data);
    var url = Uri.parse("$baseUrl/insertKarmov");
    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    });

    if (resquet.statusCode == 200) {
      resp = resquet.body;
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
    return resp;
  }

/* Cargar archivos al repositorio */
  Future uploadDocument(String base64, String titulo) async {
    var url = Uri.parse("$baseUrl/uploadDocVen");
    // print(url);
    final respuesta = await http.post(
      url,
      headers: {"Content-type": "application/x-www-form-urlencoded"},
      body: {
        "image": base64,
        "data": titulo,
      },
    );

    if (respuesta.statusCode == 200) {
      //   print("correcto-----" + respuesta.body);
    } else {
      print("fallo al subir el Archivo${respuesta.statusCode}");
    }
  }

/* Solicitud estado de leida del documento*/
  Future<String> updateDoc(String empresa, String nummov, String codpro) async {
    String resul = "0";
    var url = Uri.parse(
        "$baseUrl/updateDoc?empresa=$empresa&nummov=$nummov&codpro=$codpro");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "0"
            ? resul = respuesta.body.toString()
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  /* Recuperacion de archivo */
  Future<String> downloadBase64Info(String data) async {
    String dato = "";
    var url = Uri.parse("$baseUrl/downloaddoc2?data=$data");
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

/* Estado de solicitud actualizacion*/
  Future uploadEstado(String empresa, String code) async {
    final data = {"cod_emp": empresa, "num_sdv": code};
    var bod = json.encode(data);
    final resquet = await http.post(
        Uri.parse("$baseUrl/updateDevolucionEstado"),
        body: bod,
        headers: {
          "Content-type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
        });
    if (resquet.statusCode == 200) {
      /*   print(resquet.body); */
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

/* Actualizar transporte de solicitud de devolucion */
  Future<Map<String, String>> uploadTransp(
      String code,
      String codCop,
      String nomCop,
      String nrgCop,
      String frgCop,
      String bltCop,
      String destino,
      bool tipo) async {
    final data = {
      "cod_emp": "01",
      "num_sdv": code,
      "cod_cop": codCop,
      "ngr_cop": nrgCop,
      "frg_cop": frgCop,
      "blt_cop": bltCop,
      "destino": destino
    };
    String urlBase = tipo ? "updateDevolucionTrans" : "updateDevolucionTrans2";
    var bod = json.encode(data);
    final resquet =
        await http.post(Uri.parse("$baseUrl/$urlBase"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      /*  print(resquet.body); */
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
    return data;
  }

/* Actualizar transporte de solicitud de devolucion */
/*   Future<Map<String, String>> updateTransport(
      String code,
      String codCop,
      String nomCop,
      String nrgCop,
      String frgCop,
      String bltCop,
      String destino) async {
    var url = Uri.parse("$baseUrl/");
    final data = {
      "cod_emp": "01",
      "num_sdv": code,
      "cod_cop": codCop,
      "nom_cop": nomCop,
      "ngr_cop": nrgCop,
      "fgr_cop": "${frgCop}T19:30:45.177+00:00",
      "blt_cop": bltCop,
      "destino": destino
    };

    var bod = json.encode(data);

    final resquet = await http.post(url, body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      /*  print(resquet.body); */
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
    return data;
  }
 */
/* Crear registro en la tabla ig0063 */
  Future postIg0063(Ig0063 datos) async {
    var bod = json.encode(datos.toMap());
    print(bod);
    final resquet = await http
        .post(Uri.parse("$baseUrl/saveDevolucion2"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      //print(resquet.body);
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

  Future<String> postListIg0063(List<Ig0063> datos) async {
    String resp = "";
    List<Map> bod = [];
    for (var element in datos) {
      bod.add(element.toMap());
    }
    var data = json.encode(bod);
    //print(data);
    final resquet = await http
        .post(Uri.parse("$baseUrl/saveDevolucion3"), body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      resp = resquet.body;
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
    return resp;
  }

/* Actualizar registro en la tabla ig0063 */
  Future postIg0063Update(Ig0063Response datos) async {
    var bod = json.encode(datos.toMap());
    // print(bod);
    final resquet = await http.post(
        Uri.parse("$baseUrl/updateDevolucionBodega"),
        body: bod,
        headers: {
          "Content-type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
        });
    if (resquet.statusCode == 200) {
      /* print(resquet.body); */
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

/* Actualizar bodega con dos origen de datos */
  Future<String> updateBodega(
      String codPro, String codBod, String cant, String destino) async {
    var resp = "";
    final data = {
      "cod_emp": "01",
      "cod_pro": codPro,
      "cod_bod": codBod,
      "exi_inv": int.parse(cant),
      "destino": destino
    };

    var bod = json.encode(data);
    //print(bod);
    final resquet = await http
        .post(Uri.parse("$baseUrl/updateExistencias"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      resp = resquet.body;
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
    return resp;
  }

/* Actualizar bodega con un origen de datos */
  Future<String> updateBodega2(
      String codPro, String codBod, String cant) async {
    var resp = "";
    final data = {
      "cod_emp": "01",
      "cod_pro": codPro,
      "cod_bod": codBod,
      "exi_inv": int.parse(cant)
    };

    var bod = json.encode(data);

    final resquet = await http
        .post(Uri.parse("$baseUrl/updateExistencias2"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      resp = resquet.body;
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
    return resp;
  }

/* Actualizar cantidad de la 62 */
  Future<String> updateBodegaCantidad(
      String empresa, String numero, String producto, double cant) async {
    String resul = "0";
    var url = Uri.parse(
        "$baseUrl/updateCanSdv?empresa=$empresa&numero=$numero&codigo=$producto&cantidad=$cant");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "0"
            ? resul = respuesta.body.toString()
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

/* Crear registro en bodega */
  Future<String> postBodega(Bodega datos) async {
    var resp = "0";
    var bod = json.encode(datos.toMap());
    final resquet = await http
        .post(Uri.parse("$baseUrl/insertExistencias"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode == 200) {
      resp = resquet.body;
    } else {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }

    return resp;
  }

/* Crear regisatro en el kardex */
  Future postKardex(Kardex datos) async {
    var bod = json.encode(datos.toMap());
    final resquet = await http
        .post(Uri.parse("$baseUrl/insertKarbod"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

/* Retornar lista de usuarios que coincidan con la identificacion */
  Future<List<Usuario>> queryDni(String dni) async {
    List<Usuario> resul = [];
    var url = Uri.parse("$baseUrl/getusersnic?empresa=01&cedula=$dni");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          return respuesta.body.toString() != "[]"
              ? parseUsers(utf8.decode(respuesta.bodyBytes))
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

/* Retornar lista de usuarios que coincidan con el usuario y contraseña */
/* Recomendacion hacer que retorne un objeto no mas es lo mas conveniente a que retorne una lista */
  Future<List<Usuario>> queryUsers(String code, String pass) async {
    List<Usuario> resul = [];
    var url =
        Uri.parse("$baseUrl/getusers?empresa=01&usuario=$code&password=$pass");
    /* print(url.toString()); */
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          return respuesta.body.toString() != "[]"
              ? parseUsers(utf8.decode(respuesta.bodyBytes))
              : resul;
        }
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw ('Tiempo de expera expirado');
    } catch (e) {
      throw ('error el en GET: $e');
    }

    return resul;
  }

/* Parseo de objetos de tipo usuario y llenarlos en una lista */
  List<Usuario> parseUsers(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Usuario>((json) => Usuario.fromMap(json)).toList();
  }

/* Crear usuario en la tabla ag0054 */
  Future postUsuario(Usuario datos) async {
    var bod = json.encode(datos.toMap());
    final resquet =
        await http.post(Uri.parse("$baseUrl/insertUser"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

/* Busqueda de usuario por medio del correo ingresado*/
  Future<Usuario> queryUserCor(String correo) async {
    dynamic resul;
    var url = Uri.parse("$baseUrl/getuserscor?empresa=01&correo=$correo");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = Usuario.fromJson(utf8.decode(respuesta.bodyBytes));
        }

        return resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

/* Busqueda de usuario por medio de la cuenta ingresada*/
  Future<Usuario> queryUserCta(String cuenta) async {
    dynamic resul;
    var url = Uri.parse("$baseUrl/getuserscta?empresa=01&cuenta=$cuenta");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = Usuario.fromJson(utf8.decode(respuesta.bodyBytes));
        }

        return resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

/* Actualizacion de datos del usuario de la tabla ag0054 */
  Future updateUser(Usuario datos) async {
    var bod = json.encode(datos.toMap());
    // print(bod);
    final resquet =
        await http.post(Uri.parse("$baseUrl/updateUser"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
  }

/* Buscar clientes que coincidan con el numero de identificacion a buscar */
  Future<List<Cliente>> queryUserDni(String dni) async {
    List<Cliente> resul = [];
    var url = Uri.parse("$baseUrl/getpersonas?empresa=01&cedula=$dni");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          return respuesta.body.toString() != "[]"
              ? parseClient(utf8.decode(respuesta.bodyBytes))
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

/* Crear nuevo cliente en la tabla mg0032 */
  Future postCliente(Mg0031 datos) async {
    final data = {
      "cod_emp": "01",
      "cod_ref": datos.codRef,
      "nom_ref": datos.nomRef,
      "cod_est": datos.estRef,
      "cod_ciu": datos.ciuRef,
      "dir_ref": datos.dirRef,
      "tel_ref": datos.mv1Per,
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

  /* Envio de correo electronico y reseteo de contraseña del usuario con la clave enviada al correo */
  Future postCorreo(Usuario datos) async {
    var bod = json.encode(datos.toMap());

    final resquet =
        await http.post(Uri.parse("$baseUrl/setPassword"), body: bod, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });
    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario: ${resquet.statusCode}');
    }
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

  /* Permisos para la representacion de modulos de la tarjetas del menu*/
  Future<List<Permisos>> queryPermisos(String usuario) async {
    List<Permisos> resul = [];
    var url =
        Uri.parse("$baseUrl/getpermisos?empresa=01&usuario=$usuario&modulo=8");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? resul = parsePermisos(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Permisos> parsePermisos(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Permisos>((json) => Permisos.fromMap(json)).toList();
  }

  /* Actualizar bodega con un origen de datos */

  Future<String> updateEstatusIg0063(String nummov, String codigo,
      String factura, String tp, String user) async {
    String resul = "";
    var url = Uri.parse(
        "$baseUrl/updateCierre?nummov=$nummov&codref=$codigo&factura=$factura&tp=$tp&usuario=$user");
    /* print(url.toString()); */
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  Future<String> updateComentarioIg0063(Ig0063Response objeto) async {
    String resul = "";
    var url = Uri.parse(
        "$baseUrl/updateComentario?numsdv=${objeto.numSdv}&nummov=${objeto.numMov}&codpro=${objeto.codPro}&obsmrm=${objeto.obsMrm}");
    /* print(url.toString()); */
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  /* Permisos para la representacion de modulos de la tarjetas del menu*/
  Future<List<Kardex>> getKardex66(
      String nummov, String codpro, String documento, String tipo) async {
    List<Kardex> resul = [];

    var url = Uri.parse(
        "$baseUrl/getkardex66?nummov=$nummov&codpro=$codpro&numero=$documento&tipo=$tipo");

    /* print(url.toString()); */

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "[]"
            ? resul = parseKardex(utf8.decode(respuesta.bodyBytes))
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Kardex> parseKardex(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Kardex>((json) => Kardex.fromMap(json)).toList();
  }

  Future<List<Alterno>> getAlternos(String empresa, String producto) async {
    List<Alterno> _list = [];

    var url = Uri.parse("$baseUrl/consultv2alterno?emp=$empresa&pro=$producto");
    /*   print(url.toString()); */
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _list = parseJsonToListAlterno(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      throw 'Error en obtener los alternos: $e';
    }
    return _list;
  }

  /* obtiene el correo del usuario */
  Future<String> getCorreoUsuario(String empresa, String codref) async {
    String resul = "0";
    var url =
        Uri.parse("$baseUrl/obtenerCorreo?codEmp=$empresa&codRef=$codref");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString() != "0"
            ? resul = respuesta.body.toString().trim()
            : resul;
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Alterno> parseJsonToListAlterno(String body) {
    var parse = jsonDecode(body);
    return parse.map<Alterno>((json) => Alterno.fromMap(json)).toList();
  }

  Future sendEmailReport(Email email) async {
    var url = Uri.parse("$baseUrl/sendReporte");

    var data = email.toJson();
    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    });

    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    } else {
      print(resquet.body);
    }
  }

  Future<String> verificarCantidad(String numMov, String codPro) async {
    String dato = "";
    String newPro = Uri.encodeComponent(codPro);

    var url =
        Uri.parse("$baseUrl/verificarFactura?numMov=$numMov&codPro=$newPro");
    print(url);
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

  Future<List<Yk0001>> querylistCallCenter(
      String empresa, String usuario) async {
    var url = Uri.parse(
        "$baseUrl/getUserYk001?empresa=$empresa&grupo=USEV&usuario=$usuario");

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseListYk0001(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Yk0001> parseListYk0001(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Yk0001>((json) => Yk0001.fromMap(json)).toList();
  }

  Future<String> generarLoteNC(
      String codEmp, String codPto, String fechaI, String fechaF) async {
    String dato = ""; //181.39.96.138
    var url = Uri.parse(
        "http://192.168.3.54:8080/ebs_wms/bodega/createReturnTasks?cod_emp=$codEmp&cod_pto=$codPto&fechaI=$fechaI&fechaF=$fechaF");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        final dao = Respuesta.fromJson(utf8.decode(respuesta.bodyBytes));
        if (dao.code == 200 || dao.code == 204) {
          dato = dao.data;
        }
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<String> anularNC(String codMov, String numMov, String usuario,
      String clase, String factura) async {
    var url = Uri.parse(
        "$baseUrl/annulmentProcess?codMov=$codMov&numMov=$numMov&usuario=$usuario&clase=$clase&factura=$factura");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future sendEmailDev(Email email) async {
    var url = Uri.parse("$baseUrl/sendEmailU");

    var data = email.toJson();
    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true"
    });

    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    } else {
      print(resquet.body);
    }
  }

  Future<String> checkClientFactura(
      String empresa, String codRef, String numMov) async {
    var url = Uri.parse(
        "$baseUrl/vldcliente2?empresa=$empresa&cod_ref=$codRef&num_mov=$numMov");
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return respuesta.body.toString();
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }
}

///Dart imports
import 'dart:async';
import 'dart:convert';
import 'package:devolucion_modulo/api/credit_api.dart';
import 'package:pdf/widgets.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

///To save the pdf file in the device
class FileSaveHelper {
  ///To save the pdf file in the device
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', fileName)
      ..click();
  }

  static Future<String> createLaunchFile(String nombre) async {
    try {
      final api = CreditApi();
      String base64 = await api.downloadBase64(nombre);
      if (base64 != "") {
        List<int> bytes = dataFromBase64String(base64);
        final rawData = bytes;
        final content = base64Encode(rawData);
        AnchorElement(
            href:
                "data:application/octet-stream;charset=utf-16le;base64,$content")
          ..setAttribute("download", nombre)
          ..click();
        return '1';
      } else {
        return '0';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> createLaunchFile2(String name, String base64) async {
    try {
      if (base64 != "") {
        List<int> bytes = dataFromBase64String(base64);
        final rawData = bytes;
        final content = base64Encode(rawData);
        AnchorElement(
            href:
                "data:application/octet-stream;charset=utf-16le;base64,$content")
          ..setAttribute("download", name)
          ..click();
        return '1';
      } else {
        return '0';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static Future saveDocument({
    required String name,
    required Document pdf,
  }) async {
    try {
      final bytes = await pdf.save();
      AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
        ..setAttribute("download", name)
        ..click();
    } catch (e) {
      print('Error al imprimir[ $e]');
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';

import 'package:devolucion_modulo/models/invoice.dart';
import 'package:devolucion_modulo/models/modifyModel/archivo.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_vendedor.dart';
import 'package:devolucion_modulo/models/motivo.dart';
import 'package:devolucion_modulo/models/product.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/services/local_storage.dart';

class VendedorProvider extends ChangeNotifier {
  ReturnApi _returnApi = ReturnApi();

  //Informacion para el usuario de la solicitud

  TextEditingController numMov = TextEditingController();
  TextEditingController nombCli = TextEditingController();
  TextEditingController nombVen = TextEditingController();
  TextEditingController codCli = TextEditingController();
  TextEditingController codVen = TextEditingController();
  TextEditingController codRef = TextEditingController();

  List<Ig0063> listTemp = []; // lista de detalles del usuario
  List<DetailVendedor> listVendedor = []; // lista para el vendedor
  List<Archivo> listArchivo = []; //lista de archivos

  List<Motivo> listMotivos = [];
  final tokenUser =
      Usuario.fromMap(jsonDecode(LocalStorage.prefs.getString('usuario')!));

  String pdfNomb = "";
  String valVendedor = "";

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

  Future getFillMotivo() async {
    final resp = await _returnApi.querylistMotivos("10");
    listMotivos = resp;
  }

  Future<List<Invoice>> getFillInvoice(
      String tipo, String tp, String numero) async {
    final resp = await _returnApi.querylistInvoice(tipo, tp, numero);

    return resp;
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

  clearItem(String code) async {
    listVendedor.removeWhere((element) => element.codigo == code);
    notifyListeners();
  }

  Future<bool> getCliente(String token, String vendcode) async {
    bool opt = false;
    final resp =
        await _returnApi.queryClienteVen(token, vendcode.toUpperCase());
    if (resp != null) {
      nombCli.text = resp.first.nomRef;
      valVendedor = vendcode;
      opt = true;
    } else {
      opt = false;
    }

    notifyListeners();
    return opt;
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

  Future<bool> getVendedorInicial() async {
    bool opt = false;
    final resp = await _returnApi.querySeller(tokenUser.ctaUsr);
    if (resp != null) {
      codVen.text = tokenUser.ctaUsr;
      nombVen.text = resp.nomRef;
      opt = true;
    } else {
      opt = false;
    }

    notifyListeners();
    return opt;
  }
}

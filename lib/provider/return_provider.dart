import 'package:flutter/material.dart';

import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/cliente.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';

import 'package:devolucion_modulo/services/local_storage.dart';

import 'package:devolucion_modulo/models/ig0062.dart';
import 'package:devolucion_modulo/models/invoice.dart';
import 'package:devolucion_modulo/models/product.dart';

class ReturnProvider extends ChangeNotifier {
  final _returnApi = ReturnApi();
  Cliente cliente = Cliente();

  //Informacion para el usuario de la solicitud

  TextEditingController numMov = TextEditingController();
  TextEditingController cliNomb = TextEditingController();
  TextEditingController codCli = TextEditingController();
  TextEditingController cuiCli = TextEditingController();
  TextEditingController tlfCli = TextEditingController();
  TextEditingController cceCli = TextEditingController();
  TextEditingController dirCli = TextEditingController();

  List<Ig0062> listTemp = []; // lista de detalles del usuario

  String pdfNomb = "";

  get getNombre => this.pdfNomb;

  set setNombre(pdfNomb) {
    this.pdfNomb = pdfNomb;
    notifyListeners();
  }

  bool validateForm() {
    if (numMov.text != "") {
      return true;
    } else {
      return false;
    }
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

  void getCliente() async {
    final token = LocalStorage.prefs.getString('token');
    final resp = await _returnApi.queryCliente(token!);
    if (resp != null) {
      final email = await _returnApi.queryCorreo(token);
      final city = await _returnApi.fillCity(resp.codCiu);
      cceCli.text = email.isEmpty ? "null" : email.first.datCli;
      cliNomb.text = resp.nomRef;
      codCli.text = resp.codRef;
      cuiCli.text = city;
      tlfCli.text = resp.telRef;
      dirCli.text = resp.dirRef;
    }
  }

  Future<Cliente> getClienteId(String uid) async {
    final resp = await _returnApi.queryCliente(uid);
    if (resp != null) {
      final email = await _returnApi.queryCorreo(uid);
      final city = await _returnApi.fillCity(resp.codCiu);
      cceCli.text = email.isEmpty ? "null" : email.first.datCli;
      cliNomb.text = resp.nomRef;
      codCli.text = resp.codRef;
      cuiCli.text = city;
      tlfCli.text = resp.telRef;
      dirCli.text = resp.dirRef;
      return resp;
    } else {
      throw "Codigo no encontrado";
    }
  }
}

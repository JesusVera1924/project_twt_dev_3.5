import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/credit_api.dart';

class Mg0031Provider extends ChangeNotifier {
  String estado = "1";
  final _creditApi = CreditApi();

  checkObj(value) async {
    final data = await _creditApi.queryId(value);
    if (data.secNic != "") {
      estado = data.clsRef;
    }
    notifyListeners();
  }
}

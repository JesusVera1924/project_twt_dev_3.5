import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';

class DetailBodega {
  Ig0063Response item;
  //caja de texto
  TextEditingController controller93;
  TextEditingController controller94;
  TextEditingController controller95;
  TextEditingController controller96;
  //bloquear cajas de texto
  bool diseable93;
  bool diseable94;
  bool diseable95;
  bool diseable96;
  //check verificacion de datos de bodega
  bool check93;
  bool check94;
  bool check95;
  bool check96;
  //variables temporal de datos anteriores
  String tempVal93;
  String tempVal94;
  String tempVal95;
  String tempVal96;

  DetailBodega(
      {required this.item,
      required this.controller93,
      required this.controller94,
      required this.controller95,
      required this.controller96,
      required this.diseable93,
      required this.diseable94,
      required this.diseable95,
      required this.diseable96,
      required this.check93,
      required this.check94,
      required this.check95,
      required this.check96,
      required this.tempVal93,
      required this.tempVal94,
      required this.tempVal95,
      required this.tempVal96});

  get getItem => this.item;

  set setItem(item) => this.item = item;

  get getDevolucion => this.controller93;

  set setDevolucion(controller93) => this.controller93 = controller93;

  get getAceptados => this.controller94;

  set setAceptados(controller94) => this.controller94 = controller94;

  get getNoAceptados => this.controller95;

  set setNoAceptados(controller95) => this.controller95 = controller95;

  get getGarantia => this.controller96;

  set setGarantia(controller96) => this.controller96 = controller96;

  @override
  String toString() {
    return item.codPro;
  }
}

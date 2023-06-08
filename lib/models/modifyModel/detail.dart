import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';

class Detail {
  DetailProductResponse item;
  String cantidad;
  String codMotivo;
  String motivo;
  String informacion;
  String infoAdicional;
  String tipo;
  String archivo;
  bool bloqueo;
  Color estado;
  TextEditingController controller;

  Detail({
    required this.item,
    this.cantidad = "0",
    this.codMotivo = "00",
    this.motivo = "",
    this.informacion = "",
    this.infoAdicional = "",
    this.tipo = "Devolución",
    this.archivo = "",
    this.bloqueo = false,
    this.estado = Colors.blue,
    required this.controller,
  });

  get getItem => this.item;

  set setItem(item) => this.item = item;

  get getCantidad => this.cantidad;

  set setCantidad(cantidad) => this.cantidad = cantidad;

  get getCodMotivo => this.codMotivo;

  set setCodMotivo(codMotivo) => this.codMotivo = codMotivo;

  get getMotivo => this.motivo;

  set setMotivo(motivo) => this.motivo = motivo;

  get getInfrmacion => this.informacion;

  set setInformacion(informacion) => this.informacion = informacion;

  get getInfoAdicional => this.infoAdicional;

  set setInfoAdicional(infoAdicional) => this.infoAdicional = infoAdicional;

  get getTipo => this.tipo;

  set setTipo(tipo) => this.tipo = tipo;

  get getEstado => this.estado;

  get getArchivo => this.archivo;

  set setArchivo(archivo) => this.archivo = archivo;

  set setEstado(estado) => this.estado = estado;

  get getBloqueo => this.bloqueo;

  set setBloqueo(estado) => this.bloqueo = bloqueo;

  get getControler => this.controller;

  set setControler(controller) => this.controller = controller;

  @override
  String toString() {
    return item.codPro;
  }
}

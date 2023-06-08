import 'package:devolucion_modulo/models/ig0063.dart';

class DetailVendedor {
  String codigo;
  String codClie;
  String codVen;
  String nombCli;
  String nombVen;
  List<Ig0063> listDetail;
  int cantidad;

  DetailVendedor(
      {required this.codigo,
      required this.codClie,
      required this.codVen,
      required this.nombCli,
      required this.nombVen,
      required this.listDetail,
      required this.cantidad});
}

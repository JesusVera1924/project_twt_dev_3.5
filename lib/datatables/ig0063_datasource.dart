import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/cards/other_details2.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog.dart';

class Ig0063DTS extends DataTableSource {
  final List<Ig0063Response> listCliente;
  final BuildContext context;
  final ItemsIg0063 provider;

  Ig0063DTS(this.listCliente, this.context, this.provider);

  @override
  DataRow getRow(int index) {
    final item = this.listCliente[index];

    return DataRow.byIndex(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (item.stsSdv == "E") return Colors.green.withOpacity(0.08);
          if (states.contains(MaterialState.hovered))
            return Colors.black26.withOpacity(0.08);

          return Colors.white12;
        }),
        index: index,
        cells: [
          DataCell(Text(item.numSdv)),
          DataCell(Text(item.fecSdv)),
          DataCell(
              Align(alignment: Alignment.centerLeft, child: Text(item.clsSdv))),
          DataCell(Text(item.codPto)),
          DataCell(Text(item.codMov)),
          DataCell(Text(item.numMov)),
          DataCell(Text("${item.codVen}-${item.vendedor}")),
          DataCell(Text("${item.contar}")),
          DataCell(InkWell(
            onTap: () async {
              _showDetails(context, item);
            },
            child: const Tooltip(
                message: "Datos del transporte",
                child: Icon(Icons.assignment, color: Colors.blue)),
          )),
          DataCell(InkWell(
            onTap: () async {
              buildShowDialog(context);

              final listDetail =
                  await provider.getListItemsDetail(item.numSdv, item.clsSdv);

              if (listDetail.isNotEmpty) {
                print("Valor a tratar :: ${listDetail.length}");
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            },
            child: const Tooltip(
                message: "Detalle de ítems",
                child: Icon(Icons.find_in_page_outlined, color: Colors.blue)),
          )),
          DataCell(checkStatu(item.stsSdv)),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listCliente.length;

  @override
  int get selectedRowCount => 0;
}

Widget checkStatu(String statu) {
  switch (statu) {
    case "P":
      return Tooltip(
        message: "Pendiente",
        child: Icon(
          Icons.access_time,
          color: Colors.blueAccent,
        ),
      );
    case "E":
      return Tooltip(
        message: "En proceso",
        child: Icon(
          Icons.handyman_rounded,
          color: Colors.amberAccent[700],
        ),
      );
    case "C":
      return Tooltip(
        message: "Terminado",
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),
      );
    case "R":
      return Tooltip(
        message: "Rechazado",
        child: Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        ),
      );
    default:
      return Icon(
        Icons.warning_amber_rounded,
        color: Colors.amberAccent,
      );
  }
}

void _showDetails(BuildContext c, Ig0063Response data) async =>
    await showDialog<bool>(
      context: c,
      builder: (_) => CustomDialog(
        showPadding: false,
        child: OtherDetails2(data: data),
      ),
    );

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}

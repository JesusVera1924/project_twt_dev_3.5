import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/cards/other_details.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog.dart';

import 'package:devolucion_modulo/api/return_api.dart';

import 'package:devolucion_modulo/models/inner/ig0062Response.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_client_item.dart';
import 'package:provider/provider.dart';

class FollowDTS extends DataTableSource {
  final List<Ig0062Response> listCliente;
  final BuildContext context;
  final ReturnApi returnapi = ReturnApi();

  FollowDTS(this.listCliente, this.context);

  @override
  DataRow getRow(int index) {
    final myprovider = Provider.of<ItemsProvider>(context, listen: false);
    final item = listCliente[index];

    return DataRow.byIndex(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.black26.withOpacity(0.08);
          }
          return Colors.white12;
        }),
        index: index,
        cells: [
          DataCell(Text(item.numSdv)),
          DataCell(Text(item.fecSdv)),
          DataCell(Text(item.codPto)),
          DataCell(Text(item.codMov)),
          DataCell(Text(item.numMov)),
          DataCell(Text(item.codVen)),
          DataCell(Text(item.vendedor)),
          DataCell(Text("${item.contar}")),
          DataCell(checkStatu(item.stsSdv)),
          DataCell(GestureDetector(
            onTap: () async {
              myprovider.detailList(item.numSdv);
              await dialogListClientItem(context, myprovider);
            },
            child: const Tooltip(
                message: "Detalle de ítems",
                child: Icon(Icons.find_in_page_outlined, color: Colors.blue)),
          )),
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
      return const Tooltip(
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
    case "A":
      return const Tooltip(
        message: "Terminado",
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),
      );
    case "R":
      return const Tooltip(
        message: "Rechazado",
        child: Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        ),
      );
    default:
      return const Icon(
        Icons.warning_amber_rounded,
        color: Colors.amberAccent,
      );
  }
}

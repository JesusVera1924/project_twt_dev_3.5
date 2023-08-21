// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/ui/dialog/vendedor/show_dialog_detail_item.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Follow3DTS extends DataGridSource {
  final BuildContext context;
  final ItemsIg0063 provider;
  List<DataGridRow> _dataGridRows = [];

  Follow3DTS(this.context, this.provider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows =
        provider.itemsCliente.map<DataGridRow>((Ig0063Response team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-solicitud', value: team.numSdv),
        DataGridCell<String>(columnName: '2-fechaemision', value: team.fecSdv),
        DataGridCell<String>(columnName: '3-clase', value: team.clsSdv),
        DataGridCell<String>(columnName: '4-pv', value: team.codPto),
        DataGridCell<String>(columnName: '5-tp', value: team.codMov),
        DataGridCell<String>(columnName: '6-documento', value: team.numMov),
        DataGridCell<String>(
            columnName: '8-cliente', value: team.cliente.trim()),
        DataGridCell<String>(columnName: '9-items', value: "${team.contar}"),
        DataGridCell<String>(columnName: '10-estado', value: team.stsSdv),
        DataGridCell<Ig0063Response>(columnName: '11-detalle', value: team),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: _buildDataGridForDts(row));
  }

  List<Widget> _buildDataGridForDts(DataGridRow row) {
    List<Widget> list = [];

    if (Responsive.isTablet(context) || Responsive.isMobile(context)) {
      list = [
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[0].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[1].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Tooltip(
                message:
                    "PV: ${row.getCells()[3].value}\nTP: ${row.getCells()[4].value}\nCliente: ${row.getCells()[6].value.toString().trim()}",
                child: Text(row.getCells()[5].value.toString()))),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[7].value.toString())),
        UtilView.checkStatu(row.getCells()[8].value.toString()),
        InkWell(
            onTap: () async {
              await provider.getListItemsDetail(
                  row.getCells()[0].value.toString(), "V");
              await showDialogDetailItem(
                  context,
                  "Registro #${row.getCells()[0].value}\nCliente: ${row.getCells()[6].value}",
                  provider.tempItemsClient);
            },
            child: const Icon(Icons.assignment)),
      ];
    } else {
      list = [
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[0].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[1].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[3].value.toString().toUpperCase())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[4].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[5].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[6].value)),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[7].value.toString())),
        UtilView.checkStatu(row.getCells()[8].value.toString()),
        InkWell(
            onTap: () async {
              await provider.getListItemsDetail(
                  row.getCells()[0].value.toString(), "V");
              await showDialogDetailItem(
                  context,
                  "Registro #${row.getCells()[0].value}\nCliente: ${row.getCells()[6].value}",
                  provider.tempItemsClient);
            },
            child: const Icon(Icons.assignment)),
      ];
    }

    return list;
  }
}

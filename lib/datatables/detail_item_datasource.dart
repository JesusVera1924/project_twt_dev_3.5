// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/ui/inputs/input_dialog.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/inner/ig0062Response.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DetailItemDataSource extends DataGridSource {
  ItemsProvider myprovider;
  final BuildContext context;
  List<DataGridRow> _dataGridRows = [];
  final ReturnApi returnapi = ReturnApi();

  DetailItemDataSource(this.context, this.myprovider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows =
        myprovider.itemsDetail.map<DataGridRow>((Ig0062Response team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-Codigo', value: team.codPro),
        DataGridCell<String>(
            columnName: '2-Producto', value: team.obsSdv.split('::')[0]),
        DataGridCell<String>(
            columnName: '3-Marca', value: team.obsSdv.split('::')[1]),
        DataGridCell<String>(
            columnName: '4-Grupo', value: team.obsSdv.split('::')[2]),
        DataGridCell<double>(columnName: '5-Cantidad', value: team.canMov),
        DataGridCell<double>(columnName: '6-ItmsAceptar', value: team.canSdv),
        DataGridCell<String>(columnName: '7-Solicitud', value: team.clsMdm),
        DataGridCell<Ig0062Response>(columnName: '8', value: team)
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

    if (Responsive.isTablet(context)) {
      list = [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[0].value.toString())),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            constraints: const BoxConstraints(maxWidth: 100),
            alignment: Alignment.centerLeft,
            child: Tooltip(
                message:
                    "Producto: ${row.getCells()[1].value}\nMarca: ${row.getCells()[2].value}\nGrupo: ${row.getCells()[3].value}\nTipo: ${row.getCells()[6].value == 'D' ? 'DEVOLUCION' : 'GARANTIA'}",
                child: Text(row.getCells()[1].value.toString(),
                    maxLines: 3, overflow: TextOverflow.ellipsis))),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text("${row.getCells()[4].value}")),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: 45,
          child: InputDialog(
              hint: "",
              controller: TextEditingController(
                  text: row.getCells()[5].value == 0
                      ? "${row.getCells()[4].value}"
                      : "${row.getCells()[5].value}"),
              regx: r'(^[0-9]*$)',
              length: 6,
              onChanged: (value) {
                myprovider.getUpdateRegistro(row.getCells()[7].value,
                    double.parse(value == "" ? "0.0" : value));
              },
              onEditingComplete: () async {
                if (row.getCells()[7].value.canMov >=
                    row.getCells()[7].value.canSdv) {
                  myprovider.getUpdateDbRegistro(row.getCells()[7].value);
                } else {
                  UtilView.messageDanger("Cantidad superada");
                }
              }),
        ),
        row.getCells()[6].value == "G"
            ? InkWell(
                onTap: () {
                  myprovider.proceso3(row.getCells()[7].value);
                },
                child: const Icon(Icons.download_rounded))
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text('D', style: CustomLabels.h12))
      ];
    } else {
      list = [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[0].value.toString())),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[1].value.toString(), maxLines: 2)),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text(row.getCells()[2].value.toString())),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[3].value.toString().toUpperCase())),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text(row.getCells()[4].value.toString())),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 45,
          child: InputDialog(
              hint: "",
              controller: TextEditingController(
                  text: row.getCells()[5].value == 0
                      ? "${row.getCells()[4].value}"
                      : "${row.getCells()[5].value}"),
              regx: r'(^[0-9]*$)',
              length: 6,
              onChanged: (value) {
                myprovider.getUpdateRegistro(row.getCells()[7].value,
                    double.parse(value == "" ? "0.0" : value));
              },
              onEditingComplete: () async {
                if (row.getCells()[7].value.canMov >=
                    row.getCells()[7].value.canSdv) {
                  myprovider.getUpdateDbRegistro(row.getCells()[7].value);
                } else {
                  UtilView.messageDanger("Cantidad superada");
                }
              }),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.centerLeft,
            child: UtilView.buildTrustWorthiness(
                row.getCells()[6].value.toString())),
        row.getCells()[6].value == "G"
            ? InkWell(
                onTap: () {
                  myprovider.proceso3(row.getCells()[7].value);
                },
                child: const Icon(Icons.download_rounded))
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text('D', style: CustomLabels.h12))
      ];
    }

    return list;
  }
}

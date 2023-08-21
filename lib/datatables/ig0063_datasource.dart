// ignore_for_file: use_build_context_synchronously
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Ig0063DTS extends DataGridSource {
  final BuildContext context;
  List<Ig0063Response> list;
  List<DataGridRow> _dataGridRows = [];

  Ig0063DTS(this.context, this.list) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = list.map<DataGridRow>((Ig0063Response e) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-codigo', value: e.codPro),
        DataGridCell<String>(
            columnName: '2-producto', value: e.obsSdv.split("::")[0]),
        DataGridCell<String>(
            columnName: '3-marca', value: e.obsSdv.split("::")[1]),
        DataGridCell<String>(
            columnName: '4-cantidad', value: e.canB91.toString()),
        DataGridCell<String>(columnName: '5-motivo', value: e.obsMdm),
        DataGridCell<String>(columnName: '6-solicitud', value: e.clsMdm),
        DataGridCell<String>(columnName: '7-estado', value: e.stsSdv),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    Color? selectColor = row.getCells()[5].value.toString() == "D"
        ? Colors.green[800]
        : Colors.purple;

    return DataGridRowAdapter(
        cells: Responsive.isDesktop(context)
            ? [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    row.getCells()[0].value.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                    maxLines: 3,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Tooltip(
                    message: row.getCells()[1].value.toString(),
                    child: Text(
                      row.getCells()[1].value.toString(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: selectColor),
                      maxLines: 3,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    row.getCells()[2].value.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    row.getCells()[3].value.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    row.getCells()[4].value.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    row.getCells()[5].value.toString() == "D"
                        ? "DEVOLUCIÓN"
                        : "GARANTÍA",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    row.getCells()[6].value.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                    maxLines: 2,
                  ),
                ),
              ]
            : [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Tooltip(
                    message:
                        "${row.getCells()[1].value}\n${row.getCells()[2].value}",
                    child: Text(
                      row.getCells()[0].value.toString(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: selectColor),
                      maxLines: 2,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    row.getCells()[3].value.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    row.getCells()[4].value.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    row.getCells()[5].value.toString() == "D" ? "DEV" : "GAR",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectColor),
                    maxLines: 2,
                  ),
                ),
              ]);
  }
}

import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RequestVendedorViewGridSource extends DataGridSource {
  RequestVendedorViewGridSource(this.listDetail, this.context) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  final List<Detail> listDetail;
  final BuildContext context;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = listDetail.map<DataGridRow>((Detail e) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'codigo', value: e.item.codPro),
        DataGridCell<String>(columnName: 'marca', value: e.item.mrcPro),
        DataGridCell<String>(
            columnName: 'devolver', value: e.cantidad.toString()),
        DataGridCell<String>(columnName: 'motivo', value: e.motivo),
        DataGridCell<String>(columnName: 'solicitud', value: e.tipo),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getRowBackgroundColor() {
      if (row.getCells()[4].value == "Devolución") {
        return Colors.green[100]!;
      } else if (row.getCells()[4].value == "Garantía") {
        return Colors.blueGrey[200]!;
      }

      return Colors.transparent;
    }

    return DataGridRowAdapter(color: getRowBackgroundColor(), cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[0].value.toString(),
          child: Text(row.getCells()[0].value.toString(),
              textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
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
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[2].value.toString(),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[3].value.toString(),
          child: Text(
            row.getCells()[3].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[4].value.toString(),
          child: Text(
            row.getCells()[4].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
    ]);
  }
}

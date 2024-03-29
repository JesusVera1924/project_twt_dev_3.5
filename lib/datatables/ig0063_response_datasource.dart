import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Ig0063ResponseDTS extends DataGridSource {
  final BuildContext context;
  List<Detail> list;
  List<DataGridRow> _dataGridRows = [];

  Ig0063ResponseDTS(this.context, this.list) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = list.map<DataGridRow>((Detail e) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-codigo', value: e.item.codPro),
        DataGridCell<String>(columnName: '2-marca', value: e.item.mrcPro),
        DataGridCell<String>(columnName: '3-devolver', value: e.cantidad),
        DataGridCell<String>(columnName: '4-motivo', value: e.motivo),
        DataGridCell<String>(columnName: '5-solicitud', value: e.tipo),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    Color getRowBackgroundColor() {
      if (row.getCells()[4].value == "Devolución") {
        return Colors.green[100]!;
      } else if (row.getCells()[4].value == "Garantía") {
        return Colors.blueGrey[200]!;
      }

      return Colors.transparent;
    }

    return DataGridRowAdapter(color: getRowBackgroundColor(), cells: [
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[0].value.toString(),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          maxLines: 2,
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
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          row.getCells()[2].value.toString(),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[4].value.toString(),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: row.getCells()[4].value.toString() == "Devolución"
                  ? Colors.green
                  : Colors.purple),
        ),
      ),
    ]);
  }
}

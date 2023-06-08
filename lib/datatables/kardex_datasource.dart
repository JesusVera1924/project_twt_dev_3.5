import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:devolucion_modulo/models/kardex.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class KardexDTS extends DataGridSource {
  final List<Kardex> movimientos;
  final BuildContext context;
  List<DataGridRow> _dataGridRows = [];

  KardexDTS(this.movimientos, this.context) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = movimientos.map<DataGridRow>((Kardex team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<DateTime>(columnName: 'fecha', value: team.dacMov),
        DataGridCell<String>(columnName: 'tipo', value: team.codRel),
        DataGridCell<String>(
            columnName: 'bodega',
            value: "${team.codBod} - ${UtilView.selectBodega(team.codBod)}"),
        DataGridCell<double>(
            columnName: 'ingreso', value: team.somMov == "+" ? team.canMov : 0),
        DataGridCell<double>(
            columnName: 'egreso', value: team.somMov == "-" ? team.canMov : 0),
        DataGridCell<double>(columnName: 'saldo', value: team.pacCos),
        DataGridCell<String>(columnName: 'opera', value: team.somMov),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
              DateFormat('dd/MM/yyyy HH:mm:ss').format(row.getCells()[0].value),
              maxLines: 2)),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[4].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[5].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: row.getCells()[6].value.toString() == "+"
            ? const Icon(Icons.add, color: Colors.green)
            : const Icon(Icons.linear_scale, color: Colors.red),
      ),
    ]);
  }
}

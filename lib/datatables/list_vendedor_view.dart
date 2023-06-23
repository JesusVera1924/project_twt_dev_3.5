import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_vendedor.dart';
import 'package:devolucion_modulo/provider/vendedor_provider.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListVendedorViewGridSource extends DataGridSource {
  ListVendedorViewGridSource(this.vendedorProvider, this.context) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  final VendedorProvider vendedorProvider;
  final BuildContext context;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows =
        vendedorProvider.listVendedor.map<DataGridRow>((DetailVendedor e) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(
            columnName: 'Cliente', value: "${e.codClie}-${e.nombCli}"),
        DataGridCell<String>(
            columnName: 'vendedor',
            value: "${e.codVen.toUpperCase()}-${e.nombVen}"),
        DataGridCell<String>(columnName: 'items', value: "${e.cantidad}"),
        DataGridCell<String>(columnName: 'Acciones', value: e.codigo),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[0].value.toString(),
          child: Text(row.getCells()[0].value.toString(),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[1].value.toString(),
          child: Text(row.getCells()[1].value.toString(),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
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
        child: Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                final opt = await customDialog2(
                    context,
                    'Adevertencia',
                    'Estas seguro que deseas eliminarlo?',
                    Icons.delete_outlined,
                    Colors.red);
                if (opt) {
                  vendedorProvider
                      .clearItem(row.getCells()[3].value.toString());
                }
              },
              child: Icon(Icons.delete_outline_outlined, color: Colors.red),
            )),
      ),
    ]);
  }
}

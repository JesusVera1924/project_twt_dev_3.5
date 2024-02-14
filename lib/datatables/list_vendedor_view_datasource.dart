import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:flutter/material.dart';
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
        vendedorProvider.listSolicitudes.map<DataGridRow>((Ig0063 e) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-factura', value: e.numMov),
        DataGridCell<String>(columnName: '2-cliente', value: e.codRef),
        DataGridCell<String>(columnName: '3-codigo', value: e.codPro),
        DataGridCell<String>(
            columnName: '4-producto', value: e.obsSdv.split("::")[2]),
        DataGridCell<String>(columnName: '5-cantidad', value: "${e.canB92}"),
        DataGridCell<String>(columnName: '6-tipo', value: e.clsMdm),
        DataGridCell<String>(columnName: '7-acciones', value: e.codPro),
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
        child: Text(
          row.getCells()[0].value.toString(),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[1].value.toString(),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[3].value.toString(),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[4].value.toString(),
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[5].value.toString() == "D" ? "Devolución" : "Garantía",
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                final opt = await customDialog2(
                    context,
                    'Adevertencia',
                    'Estas seguro que deseas eliminarlo?',
                    Icons.delete_outlined,
                    Colors.red);
                if (opt) {
                  vendedorProvider.clearItem(row.getCells()[0].value.toString(),
                      row.getCells()[2].value.toString());
                }
              },
              child:
                  const Icon(Icons.delete_outline_outlined, color: Colors.red),
            )),
      ),
    ]);
  }
}

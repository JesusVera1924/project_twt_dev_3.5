import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:devolucion_modulo/provider/vendedor_dialog_provider.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/inputs/input_dialog.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RequestVendedorGridSource extends DataGridSource {
  RequestVendedorGridSource(this.provider, this.context, this.controller) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  final VendedorDialogProvider provider;
  final BuildContext context;
  final DataGridController controller;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = provider.listaDetail.map<DataGridRow>((Detail e) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'codigo', value: e.item.codPro),
        DataGridCell<String>(
            columnName: 'producto',
            value: "${e.item.nomPro}::${e.item.mrcPro}::${e.item.grpPro}"),
        DataGridCell<String>(
            columnName: 'cantidad', value: e.item.canMov.toString()),
        DataGridCell<Widget>(
            columnName: 'devolver',
            value: InputDialog(
                hint: '',
                validator: (value) {},
                controller: e.controller,
                regx: r'(^[0-9]*$)',
                length: 5,
                enable: e.bloqueo,
                onChanged: (value) {
                  if (value != "") {
                    if (int.parse(value) > e.item.canMov) {
                      e.controller.text = "${e.item.canMov}";
                      customDialog1(context, 'Has Superado la cantidad máxima',
                          Icons.warning_rounded, Colors.amberAccent);
                    } else {
                      e.cantidad = value;
                    }
                  }
                },
                onEditingComplete: () {})),
        DataGridCell<Detail>(columnName: 'motivo', value: e),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getRowBackgroundColor() {
      if (row.getCells()[4].value.bloqueo) {
        return Colors.green[200]!;
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
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[2].value.toString(),
          child: Text(
            row.getCells()[2].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: SizedBox(width: 55, child: row.getCells()[3].value),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () async {
            provider.gestor(row.getCells()[4].value);
            // notifyDataSourceListeners();
          },
          child: Icon(
            Icons.description,
            color: row.getCells()[4].value.estado,
          ),
        ),
      ),
    ]);
  }
}

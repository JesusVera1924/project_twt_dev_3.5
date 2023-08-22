// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:devolucion_modulo/provider/vendedor_provider.dart';
import 'package:devolucion_modulo/ui/dialog/devolucion/custom_dev_dialog_ven.dart';
import 'package:devolucion_modulo/ui/dialog/devolucion/show_dialog_alterno.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/inputs/input_dialog.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RequestVDTS extends DataGridSource {
  final BuildContext context;
  final VendedorProvider provider;
  List<DataGridRow> _dataGridRows = [];
  final DataGridController dataGridController;

  RequestVDTS(this.context, this.provider, this.dataGridController) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows =
        provider.listDetailInvoiceUser.map<DataGridRow>((Detail team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-codigo', value: team.item.codPro),
        DataGridCell<String>(columnName: '2-marca', value: team.item.mrcPro),
        DataGridCell<String>(
            columnName: '3-producto',
            value: "${team.item.nomPro}::${team.item.grpPro}"),
        DataGridCell<String>(
            columnName: '4-cant', value: "${team.item.canMov}"),
        DataGridCell<Detail>(columnName: '5-devolver', value: team),
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
    TextStyle? getSelectionTextStyle() {
      return dataGridController.selectedRows.contains(row)
          ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)
          : const TextStyle(fontSize: 11);
    }

    List<Widget> list = Responsive.isDesktop(context)
        ? [
            InkWell(
              onTap: () async {
                var list = await provider
                    .getAlternos(row.getCells()[0].value.toString());
                showDialogAlternos(context, list);
              },
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    row.getCells()[0].value.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getSelectionTextStyle(),
                  )),
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  row.getCells()[1].value.toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: getSelectionTextStyle(),
                )),
            Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Tooltip(
                  message: row.getCells()[2].value.toString(),
                  child: Text(
                    row.getCells()[2].value.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: getSelectionTextStyle(),
                  ),
                )),
            Container(
                margin: const EdgeInsets.all(5.0),
                width: 55,
                child: InputDialog(
                    hint: '',
                    validator: (value) {},
                    controller: row.getCells()[4].value.controller,
                    regx: r'(^[0-9]*$)',
                    length: 5,
                    enable: row.getCells()[4].value.bloqueo,
                    onChanged: (value) {
                      if (value != "") {
                        if (int.parse(value) >
                            row.getCells()[4].value.item.canMov) {
                          row.getCells()[4].value.controller.text =
                              "${row.getCells()[4].value.item.canMov}";
                          customDialog1(
                              context, 'Has Superado la cantidad máxima');
                        } else {
                          row.getCells()[4].value.cantidad = value;
                        }
                      }
                    },
                    onEditingComplete: () {})),
            Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  row.getCells()[3].value.toString(),
                  style: getSelectionTextStyle(),
                )),
            InkWell(
                onTap: () async {
                  var e = row.getCells()[4].value;
                  var op = await provider.verificarCantidad(
                      int.parse(row.getCells()[4].value.controller.text), e);
                  if (op) {
                    String x =
                        double.parse(provider.countIntems).toStringAsFixed(0);
                    customDialog1(context,
                        'Se a alcanzado el numero\nmaximo de items a devolver\nRestantes: $x');
                  } else {
                    provider.escogerItem(e);
                    if (provider.listDetailInvoiceUser.length == 1) {
                      provider.isSelectAll = false;
                    }

                    var respuesta = await showDialogDevDialogVen(
                        context, provider, "Ingresar Motivo");
                    if (respuesta) {
                      notifyDataSourceListeners();
                    }
                  }
                },
                child: Icon(
                  Icons.assignment_add,
                  color: row.getCells()[4].value.estado,
                ))
          ]
        : [
            InkWell(
              onTap: () async {
                var list = await provider
                    .getAlternos(row.getCells()[0].value.toString());
                showDialogAlternos(context, list);
              },
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Tooltip(
                    message:
                        "Marca: ${row.getCells()[1].value.toString().trim()}\nProducto: ${row.getCells()[2].value.toString().trim()}",
                    child: Text(
                      row.getCells()[0].value.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getSelectionTextStyle(),
                    ),
                  )),
            ),
            Container(
                margin: const EdgeInsets.all(5.0),
                width: 55,
                child: InputDialog(
                    hint: '',
                    validator: (value) {},
                    controller: row.getCells()[4].value.controller,
                    regx: r'(^[0-9]*$)',
                    length: 5,
                    enable: row.getCells()[4].value.bloqueo,
                    onChanged: (value) {
                      if (value != "") {
                        if (int.parse(value) >
                            row.getCells()[4].value.item.canMov) {
                          row.getCells()[4].value.controller.text =
                              "${row.getCells()[4].value.item.canMov}";
                          customDialog1(
                              context, 'Has Superado la cantidad máxima');
                        } else {
                          row.getCells()[4].value.cantidad = value;
                        }
                      }
                    },
                    onEditingComplete: () {})),
            Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  row.getCells()[3].value.toString(),
                  style: getSelectionTextStyle(),
                )),
            InkWell(
                onTap: () async {
                  var e = row.getCells()[4].value;
                  var op = await provider.verificarCantidad(
                      int.parse(row.getCells()[4].value.controller.text), e);
                  if (op) {
                    String x =
                        double.parse(provider.countIntems).toStringAsFixed(0);
                    customDialog1(context,
                        'Se a alcanzado el numero\nmaximo de items a devolver\nRestantes: $x');
                  } else {
                    provider.escogerItem(e);
                    if (provider.listDetailInvoiceUser.length == 1) {
                      provider.isSelectAll = false;
                    }

                    var respuesta = await showDialogDevDialogVen(
                        context, provider, "Ingresar Motivo");
                    if (respuesta) {
                      notifyDataSourceListeners();
                    }
                  }
                },
                child: Icon(
                  Icons.assignment_add,
                  color: row.getCells()[4].value.estado,
                ))
          ];

    return list;
  }

  void actualizarColumnas() {
    notifyDataSourceListeners();
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/models/menuItem.dart';
import 'package:devolucion_modulo/util/menus_items.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/cards/other_details.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog.dart';
import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/inner/ig0062Response.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_client_item.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ApprovalAdminDataSource extends DataGridSource {
  ItemsProvider myprovider;
  final BuildContext context;
  List<DataGridRow> _dataGridRows = [];
  final ReturnApi returnapi = ReturnApi();

  ApprovalAdminDataSource(this.context, this.myprovider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows =
        myprovider.itemsCliente.map<DataGridRow>((Ig0062Response team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-solicitud', value: team.numSdv),
        DataGridCell<String>(columnName: '2-fechaemision', value: team.fecSdv),
        DataGridCell<String>(columnName: '3-pv', value: team.codPto),
        DataGridCell<String>(columnName: '4-tp', value: team.codMov),
        DataGridCell<String>(columnName: '5-documento', value: team.numMov),
        DataGridCell<String>(columnName: '6-cliente', value: team.codRef),
        DataGridCell<String>(columnName: '7-vendedor', value: team.vendedor),
        DataGridCell<String>(columnName: '8-items', value: "${team.contar}"),
        DataGridCell<Ig0062Response>(columnName: '9', value: team),
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
            child: Tooltip(
                message:
                    "PV: ${row.getCells()[2].value}\nTP: ${row.getCells()[3].value}\nCliente: ${row.getCells()[5].value}",
                child: Text(row.getCells()[4].value.toString()))),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[6].value.toString().toUpperCase())),
        Container(
          alignment: Alignment.center,
          child: DropdownButtonHideUnderline(
              child: DropdownButton2(
            customButton:
                const Icon(Icons.list, size: 25, color: Colors.blueGrey),
            items: [
              ...myprovider.menuResponseItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                    value: item, child: MenusItems(item: item)),
              )
            ],
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.only(left: 16, right: 16),
            ),
            onChanged: (value) async {
              switch (value!.uid) {
                case "1":
                  await myprovider
                      .detailList(row.getCells()[0].value.toString());
                  await dialogListClientItem(context, myprovider);
                  break;
                case "2":
                  _showDetails(context, row.getCells()[8].value, myprovider);
                  break;
                case "3":
                  proceso4(row);
                  break;
              }
            },
            dropdownStyleData: DropdownStyleData(
              width: 150,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blueGrey),
              elevation: 8,
              offset: const Offset(0, 8),
            ),
          )),
        )
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
            child: Text(row.getCells()[2].value.toString())),
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
            alignment: Alignment.center,
            child: Text(row.getCells()[5].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[6].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[7].value.toString(),
                style: const TextStyle(fontSize: 16))),
        InkWell(
            onTap: () async {
              await myprovider.detailList(row.getCells()[0].value.toString());
              await dialogListClientItem(context, myprovider);
            },
            child: const Icon(Icons.assignment_rounded)),
        InkWell(
            onTap: () {
              _showDetails(context, row.getCells()[8].value, myprovider);
            },
            child: const Icon(Icons.call_split_rounded)),
        InkWell(
            onTap: () async => proceso4(row),
            child: const Icon(Icons.send_rounded)),
      ];
    }

    return list;
  }

  void proceso4(DataGridRow row) async {
    if (row.getCells()[8].value.stsSdv == "P") {
      final op = await customDialog2(context, 'Actualizar estado',
          'Cerrar proceso', Icons.info_outline_rounded, Colors.blueGrey);

      if (op) {
        //ACTUALIZA LA LISTA TEMPORAL
        myprovider.getUpdateList(row.getCells()[0].value.toString());
        await myprovider.detailList(row.getCells()[0].value.toString());
        await myprovider.cerraLinea(row.getCells()[0].value.toString());
      }
    }
  }

  void _showDetails(
          BuildContext c, Ig0062Response data, ItemsProvider provider) async =>
      await showDialog<bool>(
        context: c,
        builder: (_) => CustomDialog(
          showPadding: false,
          child: OtherDetails(data: data, provider: provider),
        ),
      );
}

// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/models/menuItem.dart';
import 'package:devolucion_modulo/ui/dialog/kardex/show_dialog_kardex.dart';
import 'package:devolucion_modulo/util/menus_items.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_bodega.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_store.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Follow2DTS extends DataGridSource {
  final BuildContext context;
  final ItemsIg0063 provider;
  List<DataGridRow> _dataGridRows = [];

  Follow2DTS(this.context, this.provider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows =
        provider.itemsCliente.map<DataGridRow>((Ig0063Response team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-solicitud', value: team.numSdv),
        DataGridCell<String>(columnName: '2-fechaemision', value: team.fecSdv),
        DataGridCell<String>(columnName: '3-clase', value: team.clsSdv),
        DataGridCell<String>(columnName: '4-pv', value: team.codPto),
        DataGridCell<String>(columnName: '5-tp', value: team.codMov),
        DataGridCell<String>(columnName: '6-documento', value: team.numMov),
        DataGridCell<String>(columnName: '7-cliente', value: team.codRef),
        DataGridCell<String>(
            columnName: '8-vendedor',
            value: "${team.codVen} - ${team.vendedor}"),
        DataGridCell<String>(columnName: '9-items', value: "${team.contar}"),
        DataGridCell<String>(columnName: '10-estado', value: team.stsSdv),
        DataGridCell<Ig0063Response>(columnName: '11-detalle', value: team),
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
                    "Clase: ${row.getCells()[2].value}\nPV: ${row.getCells()[3].value}\nTP: ${row.getCells()[4].value}",
                child: Text(row.getCells()[5].value.toString()))),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[7].value.toString().toUpperCase())),
        UtilView.checkStatu(row.getCells()[9].value.toString()),
        Container(
          alignment: Alignment.center,
          child: DropdownButtonHideUnderline(
              child: DropdownButton2(
            customButton:
                const Icon(Icons.list, size: 25, color: Colors.blueGrey),
            items: [
              ...provider.menuResponseItems.map(
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
                  proceso1(row);
                  break;
                case "2":
                  provider.showDetails(context, row.getCells()[10].value);
                  break;
                case "3":
                  proceso2(row);
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
        ),
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
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[5].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[6].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[7].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(row.getCells()[8].value.toString())),
        UtilView.checkStatu(row.getCells()[9].value.toString()),
        InkWell(
            onTap: () async => proceso1(row),
            child: const Icon(Icons.assignment)),
        InkWell(
            onTap: () =>
                provider.showDetails(context, row.getCells()[10].value),
            child: const Icon(Icons.find_in_page_outlined)),
        InkWell(
            onTap: () async => proceso2(row),
            child: const Icon(Icons.move_up_rounded)),
      ];
    }

    return list;
  }

  void proceso1(DataGridRow row) async {
    UtilView.buildShowDialog(context);
    await provider.getListItemsDetail(
        row.getCells()[0].value.toString(), row.getCells()[2].value.toString());

    if (provider.tempItemsClient.isNotEmpty) {
      for (var element in provider.tempItemsClient) {
        var obj = DetailBodega(
            item: element,
            controller93: TextEditingController(
                text: element.canB93 != 0 ? "${element.canB93}" : ""),
            controller94: TextEditingController(
                text: element.canB94 != 0 ? "${element.canB94}" : ""),
            controller95: TextEditingController(
                text: element.canB95 != 0 ? "${element.canB95}" : ""),
            controller96: TextEditingController(
                text: element.canB96 != 0 ? "${element.canB96}" : ""),
            tempVal93: element.canB93 != 0 ? "${element.canB93}" : "0",
            tempVal94: element.canB94 != 0 ? "${element.canB94}" : "0",
            tempVal95: element.canB95 != 0 ? "${element.canB95}" : "0",
            tempVal96: element.canB96 != 0 ? "${element.canB96}" : "0",
            diseable93: true,
            diseable94: true,
            diseable95: true,
            diseable96: true,
            check93: false,
            check94: false,
            check95: false,
            check96: false);

        if (obj.item.canB92 == 0) {
          if (obj.controller93.text == "") obj.diseable93 = false;
          if (obj.controller94.text == "") obj.diseable94 = false;
          if (obj.controller95.text == "") obj.diseable95 = false;
          if (obj.controller96.text == "") obj.diseable96 = false;
        }

        provider.listBodega.add(obj);
      }
      Navigator.of(context).pop();
      await showDialogStore(context, provider,
          'Detalle Items: #${row.getCells()[10].value.numSdv}\nFecha: ${UtilView.convertDateToString()} - Vendedor: ${row.getCells()[10].value.codVen}');
    } else {
      Navigator.of(context).pop();
    }
  }

  void proceso2(DataGridRow row) async {
    Ig0063Response x = row.getCells()[10].value;
    var lista = await provider.getListKardex(x.numSdv, x.codPro, x.numMov);
    await showDialogKardex(
        context, 'kardex :: ${x.numSdv} :: ${x.codPro} ', lista);
  }
}

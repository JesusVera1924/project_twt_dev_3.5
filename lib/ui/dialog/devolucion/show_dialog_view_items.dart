// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/datatables/ig0063_response_datasource.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';

import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future<String> showDialogViewItems(
    BuildContext context, String title, List<Detail> listDetail) async {
  String resp = "0";
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title.toUpperCase()),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            width: Responsive.isDesktop(context) ? 800 : 400,
            height: 310,
            child: Card(
              elevation: 10,
              child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: Colors.blueGrey,
                      selectionColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      filterIconColor: Colors.black,
                      filterIconHoverColor: Colors.white),
                  child: SfDataGrid(
                      columnWidthMode: ColumnWidthMode.none,
                      headerRowHeight: 37,
                      rowHeight: 37,
                      source: Ig0063DTS(context, listDetail),
                      columns: _buildDataGridForSize(context))),
            ),
          ),
          actions: [
            CustomFormButton(
                color: Colors.green,
                onPressed: () {
                  resp = "1";
                  Navigator.of(context).pop();
                },
                text: 'Siguiente'),
            CustomFormButton(
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cerrar'),
          ],
        );
      });

  return resp;
}

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = [
    GridColumn(
      columnName: '1-codigo',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('CODIGO',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '2-marca',
      allowFiltering: false,
      width: 100,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('MARCA',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '3-devolver',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.centerLeft,
        child: Text('DEVOLVER',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '4-motivo',
      columnWidthMode: ColumnWidthMode.fill,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('MOTIVO',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '5-solicitud',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('SOLICITUD',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
  ];

  return list;
}

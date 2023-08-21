// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/datatables/ig0063_datasource.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future showDialogDetailItem(
    BuildContext context, String title, List<Ig0063Response> listDetail) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          contentPadding: const EdgeInsets.all(5),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            width: Responsive.isDesktop(context) ? 800 : 400,
            height: 350,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 13),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 2.0)),
                  child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                          headerColor: Colors.blueGrey,
                          selectionColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          filterIconColor: Colors.black,
                          filterIconHoverColor: Colors.white),
                      child: SfDataGrid(
                          columnWidthMode: ColumnWidthMode.none,
                          headerRowHeight: 35,
                          rowHeight: 42,
                          source: Ig0063DTS(context, listDetail),
                          columns: _buildDataGridForSize(context))),
                ),
              ],
            ),
          ),
        );
      });
}

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = Responsive.isDesktop(context)
      ? [
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
            columnName: '2-producto',
            columnWidthMode: ColumnWidthMode.fill,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              //width: Responsive.isDesktop(context) ? 100 : 80,
              alignment: Alignment.center,
              child: Text('PRODUCTO',
                  style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: '3-marca',
            columnWidthMode: ColumnWidthMode.fill,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              //width: Responsive.isDesktop(context) ? 100 : 80,
              alignment: Alignment.center,
              child: Text('MARCA',
                  style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: '4-cantidad',
            width: 60,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              //width: Responsive.isDesktop(context) ? 100 : 80,
              alignment: Alignment.centerLeft,
              child: Text('CANT',
                  style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: '5-motivo',
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
            columnName: '6-solicitud',
            columnWidthMode: ColumnWidthMode.fitByColumnName,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              //width: Responsive.isDesktop(context) ? 100 : 80,
              alignment: Alignment.center,
              child: Text('SOLICITUD',
                  style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: '7-estado',
            width: 50,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              //width: Responsive.isDesktop(context) ? 100 : 80,
              alignment: Alignment.center,
              child: Text('EST',
                  style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
            ),
          ),
        ]
      : [
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
            columnName: '4-cantidad',
            width: 60,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              //width: Responsive.isDesktop(context) ? 100 : 80,
              alignment: Alignment.center,
              child: Text('CANT',
                  style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: '5-motivo',
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
            columnName: '6-solicitud',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              //width: Responsive.isDesktop(context) ? 100 : 80,
              alignment: Alignment.center,
              child: Text('TP',
                  style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
            ),
          ),
        ];

  return list;
}

import 'package:devolucion_modulo/datatables/detail_item_datasource.dart';
import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future dialogListClientItem(
    BuildContext context, ItemsProvider provider) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0x00ffffff),
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Vista de Items".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
                const SizedBox(height: 5.0),
                const Divider(color: Colors.grey, height: 4.0),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    constraints:
                        const BoxConstraints(maxHeight: 300, minHeight: 200),
                    child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.05)),
                        child: SfDataGrid(
                            columnWidthMode: ColumnWidthMode.none,
                            headerRowHeight: 35,
                            rowHeight: 35,
                            source: DetailItemDataSource(context, provider),
                            columns: _buildDataGridForSize(context)))),
              ],
            ),
          ),
        );
      });
}

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = [];

  if (Responsive.isTablet(context)) {
    list = [
      GridColumn(
        columnName: '1-Codigo',
        width: 100,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('CODIGO',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '2-Producto',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('PRODUCTO',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '5-Cantidad',
        width: 80,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('CANT.',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '6-ItmsAceptar',
        width: 80,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ACEPTADA',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '8-Documento',
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('Doc',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  } else {
    list = [
      GridColumn(
        columnName: '1-Codigo',
        width: 110,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('CODIGO',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '2-Producto',
        width: 500,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text('PRODUCTO',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '3-Marca',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('MARCA',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '4-Grupo',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('GRUPO',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '5-Cantidad',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('CANTIDAD',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '6-ItmsAceptar',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ITMS.ACEPTAR',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '7-Solicitud',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('SOLICITUD',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '8-Documento',
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('Doc',
              style: CustomLabels.h12, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  }

  return list;
}

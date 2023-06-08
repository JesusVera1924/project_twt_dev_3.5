// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/datatables/store_datasource.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';

import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/models/kardex.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future showDialogStore(
    BuildContext context, ItemsIg0063 provider, String titulo) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                titulo,
                style: CustomLabels.h12.copyWith(fontSize: 13),
              ),
              actions: [
                CustomFormButton(
                  onPressed: () async {
                    if (await provider.cerrarList()) {
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.green,
                  text: 'Generar',
                ),
                const SizedBox(width: 2),
                CustomFormButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: 'Salir'),
                const SizedBox(width: 8),
              ],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: SfDataGridTheme(
                          data: SfDataGridThemeData(
                              headerColor: Colors.blueGrey,
                              filterIconColor: Colors.black,
                              filterIconHoverColor: Colors.white),
                          child: SfDataGrid(
                              columnWidthMode: ColumnWidthMode.none,
                              headerRowHeight: 35,
                              rowHeight: 35,
                              // allowFiltering: true,
                              source: StoreDataSource(context, provider),
                              columns: _buildDataGridForSize(context))),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
}

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = [];

  if (Responsive.isTablet(context)) {
    list = [
      GridColumn(
        columnName: '1-codigo',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('PRODUCTO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '2-recibido',
        width: 80,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('REF.',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '3-revision',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('REVISION',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '4-aprobado',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('APROBADO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '5-rechazado',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('RECHAZADO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '6-garantia',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('GARANTIA',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '11-kardex',
        width: 80,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('HIST.',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  } else {
    list = [
      GridColumn(
        columnName: '1-codigo',
        width: 130,
        //columnWidthMode: ColumnWidthMode.fill,
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
        width: Responsive.isTablet(context) ? 100 : 80,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('MARCA',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '3-grupo',
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('GRUPO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '4-recibido',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('RECIBIDO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '5-revision',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('REVISION.T',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '6.aprobado',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('APROBADOS',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '7-rechazado',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('RECHAZADOS',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '8-garantia',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('GARANTIA',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '9-solicitud',
        width: 90,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('TIPO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '10-resuido',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        //width: Responsive.isDesktop(context) ? 110 : 80,

        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('SOBRANTE',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '11-kardex',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('KARDEX',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  }

  return list;
}

void registroKardex(
    Ig0063Response e, String cantidad, String bodega, String signo) {
  ReturnApi returnapi = ReturnApi();
  returnapi.postKardex(Kardex(
      codEmp: "01",
      codPto: "01",
      codMov: e.codMov,
      numMov: e.numSdv,
      fecMov: DateTime.now(),
      codRel: e.codMov,
      numRel: e.numMov,
      fecRel: DateTime.now(),
      codRef: e.codRef,
      nomRef: "",
      codPro: e.codPro,
      codBod: bodega,
      canMov: double.parse(cantidad),
      pacCos: 0,
      vacCos: 0,
      codMdm: e.codMdm,
      obsMdm: e.obsMdm,
      obsMov: "",
      ucrMov: "",
      dcrMov: DateTime.now(),
      uacMov: "",
      dacMov: DateTime.now(),
      somMov: signo,
      stsMov: "1"));
}

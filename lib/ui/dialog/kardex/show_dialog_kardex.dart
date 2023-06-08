import 'package:flutter/material.dart';
import 'package:devolucion_modulo/datatables/kardex_datasource.dart';
import 'package:devolucion_modulo/models/kardex.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future showDialogKardex(
    BuildContext context, String title, List<Kardex> lista) async {
  await showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 300,
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                  headerColor: Colors.blueGrey,
                  filterIconColor: Colors.black,
                  filterIconHoverColor: Colors.white),
              child: SfDataGrid(
                  columnWidthMode: ColumnWidthMode.none,
                  headerRowHeight: 35,
                  rowHeight: 35,
                  allowFiltering: true,
                  source: KardexDTS(lista, context),
                  columns: [
                    GridColumn(
                        columnName: 'fecha',
                        columnWidthMode: ColumnWidthMode.fitByCellValue,
                        allowFiltering: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'FECHA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'tipo',
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        allowFiltering: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'TIPO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'bodega',
                        columnWidthMode: ColumnWidthMode.fill,
                        allowFiltering: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'BODEGA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'ingreso',
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        allowFiltering: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'INGRESO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'egreso',
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        allowFiltering: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'EGRESO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'saldo',
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        allowFiltering: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'SALDO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                    GridColumn(
                        columnName: 'opera',
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        allowFiltering: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'OP',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ]),
            ),
          ),
        );
      });
}

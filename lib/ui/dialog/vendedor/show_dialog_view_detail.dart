import 'package:flutter/material.dart';
import 'package:devolucion_modulo/datatables/request_vendedor_view.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';

import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future<String> showDialogViewDetail(
    BuildContext context, String title, List<Detail> listDetail) async {
  String resp = "0";
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title.toUpperCase()),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 10,
              child: SfDataGrid(
                source: RequestVendedorViewGridSource(listDetail, context),
                allowSorting: true,
                columnWidthMode: ColumnWidthMode.fill,
                columns: [
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'codigo',
                    label: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Codigo',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'marca',
                    label: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Marca',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'devolver',
                    label: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Devolver',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'motivo',
                    label: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Motivo',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GridColumn(
                    columnWidthMode: ColumnWidthMode.fill,
                    columnName: 'solicitud',
                    label: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Solicitud',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
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

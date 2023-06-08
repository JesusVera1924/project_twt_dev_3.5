// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/dialog/devolucion/dialog_alterno.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';

import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:provider/provider.dart';

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
          content: Card(
            elevation: 10,
            child: SingleChildScrollView(
              child: DataTable(
                  dividerThickness: 2,
                  columnSpacing: 30,
                  columns: [
                    DataColumn(
                        label: Expanded(
                          child: Text(
                            'Codigo'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        numeric: false,
                        tooltip: "Codigo producto"),
                    DataColumn(
                        label: Expanded(
                          child: Text(
                            'Marca'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        numeric: false,
                        tooltip: "producto"),
                    DataColumn(
                        label: Expanded(
                          child: Text(
                            'Devolver'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        numeric: false,
                        tooltip: "Cantidad a devolver"),
                    DataColumn(
                        label: Expanded(
                          child: Text(
                            'Motivo'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        numeric: false,
                        tooltip: "Motivo a devolver"),
                    DataColumn(
                        label: Expanded(
                          child: Text(
                            'Solicitud'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        numeric: false,
                        tooltip: "Tipo de solicitud"),
                  ],
                  rows: listDetail
                      .map((e) => DataRow(cells: [
                            DataCell(
                              InkWell(
                                onTap: () async {
                                  var list = await Provider.of<ItemsIg0063>(
                                          context,
                                          listen: false)
                                      .getAlternos(e.item.codPro);
                                  dialogAlternos(context, list);
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    e.item.codPro,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(e.item.mrcPro)),
                            ),
                            DataCell(
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(e.cantidad)),
                            ),
                            DataCell(
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(e.motivo)),
                            ),
                            DataCell(
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(e.tipo == "Devolución"
                                      ? "Devolución"
                                      : "Garantia")),
                            ),
                          ]))
                      .toList()),
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

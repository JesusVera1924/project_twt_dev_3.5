import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/ig0063.dart';

import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';

Future showDialogViewVendedor(
    BuildContext context, String title, List<Ig0063> listDetail) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  backgroundColor: Color(0xFF8793B2),
          title: Text(title.toUpperCase()),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Card(
            elevation: 10,
            child: DataTable(
                dividerThickness: 2,
                columns: [
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'Codigo'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      numeric: false,
                      tooltip: "Codigo producto"),
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'Producto'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      numeric: false,
                      tooltip: "nombre producto"),
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'Devolver'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      numeric: true,
                      tooltip: "cantidad a devolver"),
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'Motivo'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      numeric: false,
                      tooltip: "Motivo a devolver"),
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'solicitud'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      numeric: false,
                      tooltip: "Tipo de solicitud"),
                ],
                rows: listDetail
                    .map((e) => DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e.codPro,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  e.obsSdv,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                          DataCell(
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("${e.canB91}")),
                          ),
                          DataCell(
                            Align(
                                alignment: Alignment.center,
                                child: Text(e.ofsSdv)),
                          ),
                          DataCell(
                            Align(
                                alignment: Alignment.center,
                                child: Text(e.clsMdm)),
                          ),
                        ]))
                    .toList()),
          ),
          actions: [
            CustomFormButton(
                color: Colors.greenAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Regresar'),
          ],
        );
      });
}

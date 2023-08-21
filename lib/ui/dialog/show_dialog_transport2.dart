// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:devolucion_modulo/provider/transport_provider.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels_form.dart';
import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:provider/provider.dart';

Future<Map<String, String>?> showDialogTransport2(
    BuildContext context, String numero, dynamic data, bool isMetodo) async {
  final transportProvider =
      Provider.of<TrasnsportProvider>(context, listen: false);
  bool viewContainer = false;
  Map<String, String>? respuesta;

  transportProvider.setCompleInfo(data);

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              //  backgroundColor: Color(0xFF8793B2),
              title: CustomLabelsForm(
                text: 'Datos del Envio'.toUpperCase(),
                size: 20,
                fontWeight: FontWeight.w400,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InputForm(
                            hint: 'Codigo',
                            enable: false,
                            onChanged: (value) {},
                            icon: Icons.contact_page_rounded,
                            validator: (value) {},
                            controller: transportProvider.controllerCod,
                            regx: r'(^[A-Za-z0-9 ]*$)',
                            length: 4,
                            onEditingComplete: () {}),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: InputForm(
                            hint: 'Nombre',
                            icon: Icons.contact_page_rounded,
                            mayuscula: true,
                            validator: (value) {},
                            controller: transportProvider.controllerNom,
                            regx: r'(^[a-zA-Z ]*$)',
                            length: 40,
                            onChanged: (String value) async {
                              if (value.length >= 2) {
                                viewContainer =
                                    await transportProvider.searchText(value);
                              } else if (value.length <= 2) {
                                viewContainer = false;
                              }
                              setState(() {});
                            },
                            onEditingComplete: () {}),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: InputForm(
                            hint: 'Guía remisión',
                            icon: Icons.room_outlined,
                            validator: (value) {},
                            controller: transportProvider.controllerNgr,
                            regx: r'(^[0-9]*$)',
                            length: 9,
                            onChanged: (value) {},
                            onEditingComplete: () {}),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: InputForm(
                              formatt: true,
                              hint: 'dia/mes/año',
                              icon: Icons.date_range_outlined,
                              validator: (value) {},
                              controller: transportProvider.controllerFgr,
                              regx: r'\d+|-|/',
                              length: 30,
                              onChanged: (value) {},
                              onEditingComplete: () {}),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InputForm(
                            hint: 'Cantidad Bulto',
                            onChanged: (value) {},
                            icon: Icons.confirmation_number_rounded,
                            validator: (value) {},
                            controller: transportProvider.controllerBlt,
                            regx: r'^(\d+)?\.?\d{0,3}',
                            length: 6,
                            onEditingComplete: () {}),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          value: transportProvider.destino,
                          items: UtilView.list.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(item, style: CustomLabels.h4),
                                  )),
                            );
                          }).toList(),
                          onChanged: (selectedItem) {
                            setState(() {
                              transportProvider.destino =
                                  selectedItem as String;
                            });
                          },
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (viewContainer)
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5)),
                      height: 250,
                      width: 400,
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.05);
                              }),
                              showCheckboxColumn: false,
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
                                    tooltip: "Tipo de Factura"),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Nombre'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false,
                                    tooltip: "Tipo de Factura")
                              ],
                              rows: transportProvider.listTransport
                                  .map((e) => DataRow(
                                          onSelectChanged: (value) {
                                            transportProvider.controllerCod
                                                .text = e.codRef.toString();
                                            transportProvider.controllerNom
                                                .text = e.nomRef.toString();
                                            viewContainer = false;
                                            setState(() {});
                                          },
                                          cells: [
                                            DataCell(
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Text(e.codRef)),
                                            ),
                                            DataCell(
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(e.nomRef)),
                                            ),
                                          ]))
                                  .toList()),
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                CustomFormButton(
                  onPressed: () async {
                    if (transportProvider.controllerCod.text != "" &&
                        transportProvider.controllerBlt.text != "" &&
                        transportProvider.controllerNgr.text != "" &&
                        transportProvider.controllerNom.text != "" &&
                        transportProvider.controllerFgr.text != "" &&
                        transportProvider.destino != "") {
                      transportProvider.controllerFgr.text =
                          formatFecha(transportProvider.controllerFgr.text);

                      respuesta = await transportProvider.updateTransport(
                          numero, isMetodo);

                      Navigator.of(context).pop();
                    } else {
                      customDialog1(
                          context,
                          'Debe de completar todo los campos',
                          Icons.warning,
                          Colors.amberAccent);
                    }
                  },
                  text: 'Aceptar',
                  color: Colors.green,
                ),
                CustomFormButton(
                  onPressed: () {
                    transportProvider.limpiar();
                    respuesta = null;
                    Navigator.of(context).pop();
                  },
                  text: 'Cancelar',
                  color: Colors.red,
                )
              ],
            );
          },
        );
      });
  return respuesta;
}

String formatFecha(String tx) {
  //10/10/2021
  if (tx.contains('-') && tx.length == 10) {
    return tx;
  } else {
    if (tx.length == 10) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateTime dateTime = formatter.parse(
          tx.split("/")[2] + "-" + tx.split("/")[1] + "-" + tx.split("/")[0]);
      return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    } else {
      return "0000-00-00";
    }
  }
}

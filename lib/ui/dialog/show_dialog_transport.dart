import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:devolucion_modulo/provider/almacen_provider.dart';
import 'package:devolucion_modulo/provider/vendedor_provider.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/util_view.dart';

import 'package:provider/provider.dart';
import 'package:devolucion_modulo/provider/return_provider.dart';

import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/transport.dart';

import 'package:devolucion_modulo/ui/labels/custom_labels_form.dart';
import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';

Future<String> showDialogTransport(BuildContext context, String val) async {
  TextEditingController controllerCod = TextEditingController();
  TextEditingController controllerNom = TextEditingController();
  TextEditingController controllerNgr = TextEditingController();
  TextEditingController controllerFgr = TextEditingController();
  TextEditingController controllerBlt = TextEditingController();
  String destino = "MATRIZ";
  ReturnApi returnApi = ReturnApi();
  List<Transport> listTransport = [];
  String viewContainer = "0";
  String resp = "0";
  final returnProvider = Provider.of<ReturnProvider>(context, listen: false);

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              //  backgroundColor: Color(0xFF8793B2),
              title: CustomLabelsForm(
                text: 'Datos del Envio 1'.toUpperCase(),
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
                            controller: controllerCod,
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
                            validator: (value) {},
                            controller: controllerNom,
                            mayuscula: true,
                            regx: r'(^[a-zA-Z ]*$)',
                            length: 40,
                            onChanged: (String value) async {
                              if (value.length >= 1) {
                                viewContainer = "1";
                                listTransport = await returnApi
                                    .queryTransport(value.toUpperCase());
                                if (listTransport.isEmpty) {
                                  viewContainer = "0";
                                  listTransport = [];
                                }
                                setState(() {});
                              }
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
                            controller: controllerNgr,
                            regx: r'(^[0-9]*$)',
                            length: 9,
                            onChanged: (value) {},
                            onEditingComplete: () {}),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InputForm(
                            formatt: true,
                            hint: 'dia/mes/año',
                            icon: Icons.date_range_outlined,
                            validator: (value) {},
                            controller: controllerFgr,
                            regx: r'\d+|-|/',
                            length: 20,
                            onChanged: (value) {},
                            onEditingComplete: () {}),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InputForm(
                            hint: 'Cantidad Bulto',
                            onChanged: (value) {},
                            icon: Icons.confirmation_number_rounded,
                            validator: (value) {},
                            controller: controllerBlt,
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
                        width: 150,
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          value: destino,
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
                              destino = selectedItem as String;
                            });
                          },
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  (viewContainer == "1")
                      ? Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          height: 250,
                          width: 400,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: DataTable(
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
                                  rows: listTransport
                                      .map((e) => DataRow(
                                              onSelectChanged: (value) {
                                                viewContainer = "0";
                                                controllerCod.text =
                                                    e.codRef.toString();
                                                controllerNom.text =
                                                    e.nomRef.toString();
                                                setState(() {});
                                              },
                                              cells: [
                                                DataCell(
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
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
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(''),
                        ),
                ],
              ),
              actions: [
                CustomFormButton(
                  onPressed: () {
                    if (controllerCod.text != "" &&
                        controllerBlt.text != "" &&
                        controllerNgr.text != "" &&
                        controllerNom.text != "" &&
                        controllerFgr.text != "" &&
                        destino != "") {
                      controllerFgr.text = formatFecha(controllerFgr.text);
                      if (val == "C") {
                        if (returnProvider.listTemp.length >= 1) {
                          for (var element in returnProvider.listTemp) {
                            element.codCop = controllerCod.text;
                            element.nomCop = controllerNom.text;
                            element.ngrCop = controllerNgr.text;
                            element.fgrCop = controllerFgr.text;
                            element.bltCop = double.parse(controllerBlt.text);
                            element.destino = destino;
                          }
                          resp = "1";
                          Navigator.of(context).pop();
                        }
                      } else if (val == "V") {
                        final vendedorProvider = Provider.of<VendedorProvider>(
                            context,
                            listen: false);
                        if (vendedorProvider.listTemp.isNotEmpty) {
                          for (var element in vendedorProvider.listTemp) {
                            element.codCop = controllerCod.text;
                            element.nomCop = controllerNom.text;
                            element.ngrCop = controllerNgr.text;
                            element.fgrCop = controllerFgr.text;
                            element.bltCop = double.parse(controllerBlt.text);
                            element.destino = destino;
                          }
                          resp = "1";
                          Navigator.of(context).pop();
                        }
                      } else {
                        final alamacenProvider = Provider.of<AlmacenProvider>(
                            context,
                            listen: false);
                        if (alamacenProvider.listTemp.length >= 1) {
                          for (var element in alamacenProvider.listTemp) {
                            element.codCop = controllerCod.text;
                            element.nomCop = controllerNom.text;
                            element.ngrCop = controllerNgr.text;
                            element.fgrCop = controllerFgr.text;
                            element.bltCop = double.parse(controllerBlt.text);
                            element.destino = destino;
                          }
                          resp = "1";
                          Navigator.of(context).pop();
                        }
                      }
                    } else {
                      customDialog1(
                          context,
                          'Advertencia',
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
                    controllerCod.text = "";
                    controllerNom.text = "";
                    controllerNgr.text = "";
                    controllerFgr.text = "";
                    controllerBlt.text = "";
                    destino = "Matriz";
                    resp = "0";
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
  return resp;
}

String formatFecha(String tx) {
  //10/10/2021
  if (tx.length == 10) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime dateTime = formatter
        .parse("${tx.split("/")[2]}-${tx.split("/")[1]}-${tx.split("/")[0]}");
    return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  } else {
    return "0000-00-00";
  }
}

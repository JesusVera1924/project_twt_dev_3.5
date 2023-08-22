// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/provider/almacen_provider.dart';
import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:group_radio_button/group_radio_button.dart';

Future<bool> showDialogDevDialog(
    BuildContext context, AlmacenProvider provider) async {
  List<String> _tipoValor = ["Devolución", "Garantía"];
  bool op = false;
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Row(
                children: [
                  const Icon(Icons.assignment_add, size: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("Ingresar Motivo", style: CustomLabels.h5),
                  ),
                ],
              ),
              content: Container(
                margin: const EdgeInsets.only(left: 0.8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black26, width: 2)),
                width: 320,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Motivo de devolucion',
                        style: CustomLabels.h2,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          provider.infoProducto,
                          textAlign: TextAlign.start,
                          style: CustomLabels.h7,
                        ),
                      ),
                    ),
                    const Divider(thickness: 1),
                    Container(
                      alignment: Alignment.center,
                      child: RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          horizontalAlignment: MainAxisAlignment.center,
                          groupValue: provider.valItemTipo,
                          onChanged: (value) => setState(() {
                                provider.valItemTipo = value.toString();
                              }),
                          items: _tipoValor,
                          itemBuilder: (item) => RadioButtonBuilder(item)),
                    ),
                    provider.valItemTipo == "Garantía"
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 6),
                                child: InputForm(
                                    hint: 'Info.Adicional',
                                    icon: Icons.assignment,
                                    validator: (value) {},
                                    controller: provider.controllerG,
                                    regx: '.*',
                                    length: 200,
                                    onChanged: (value) {},
                                    onEditingComplete: () {}),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(provider.getNombre,
                                    style: CustomLabels.h7),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomFormButton(
                                    onPressed: () async {
                                      final resp = await provider
                                          .openFileExplorer(context);
                                      if (!resp) {
                                        customDialog1(
                                            context, 'Formato Invalido');
                                      }
                                    },
                                    color: Colors.blueGrey,
                                    text: 'Subir Documento '),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomFormButton(
                                      onPressed: () {
                                        if (provider.imgPdf == "1") {
                                          for (var element
                                              in provider.listaTemp) {
                                            if (element.item.codPro ==
                                                provider.codigoTemp) {
                                              element.informacion =
                                                  provider.infoProducto;
                                              element.estado = Colors.green;
                                              element.tipo =
                                                  provider.valItemTipo;
                                              element.setInfoAdicional =
                                                  provider.controllerG.text
                                                      .toUpperCase();
                                            }
                                          }
                                          provider.limpiar();
                                          op = true;
                                          Navigator.of(context).pop();
                                        } else {
                                          customDialog1(context,
                                              'Error cargar el pdf en el ítem correspondiente');
                                        }
                                      },
                                      color: Colors.green[800]!,
                                      text: provider.btn),
                                  const SizedBox(width: 5),
                                  CustomFormButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      text: "Cancelar",
                                      color: Colors.redAccent),
                                  const SizedBox(height: 5),
                                ],
                              )
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                  isExpanded: true,
                                  isDense: true,
                                  icon: const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  value: provider.selectComboMotivo,
                                  items: provider.listMotivos.map((item) {
                                    return DropdownMenuItem(
                                      value: item.codCmg,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(item.nomCmg,
                                                style: CustomLabels.h4),
                                          )),
                                    );
                                  }).toList(),
                                  onChanged: (selectedItem) {
                                    setState(() {
                                      provider.selectComboMotivo =
                                          selectedItem.toString();
                                      provider.obj = provider.listMotivos
                                          .singleWhere((element) =>
                                              element.codCmg ==
                                              provider.selectComboMotivo);
                                    });
                                  },
                                )),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 6),
                                child: InputForm(
                                    hint: 'Info.Adicional',
                                    icon: Icons.assignment,
                                    validator: (value) {},
                                    controller: provider.controllerD,
                                    regx: '.*',
                                    length: 200,
                                    onChanged: (value) {},
                                    onEditingComplete: () {}),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomFormButton(
                                      onPressed: () {
                                        if (provider.selectComboMotivo !=
                                            "00") {
                                          for (var element
                                              in provider.listaTemp) {
                                            if (element.item.codPro ==
                                                provider.codigoTemp) {
                                              element.tipo =
                                                  provider.valItemTipo;
                                              element.setInfoAdicional =
                                                  provider.controllerD.text
                                                      .toUpperCase();
                                              element.codMotivo =
                                                  provider.obj.codCmg;
                                              element.setMotivo =
                                                  provider.obj.nomCmg;
                                              element.estado = Colors.green;
                                              element.informacion =
                                                  provider.infoProducto;
                                            }
                                          }
                                          op = true;
                                          provider.limpiar();
                                          Navigator.of(context).pop();
                                        } else {
                                          customDialog1(context,
                                              'Seleccione el tipo de razón a devolver');
                                        }
                                      },
                                      color: Colors.green[800]!,
                                      text: provider.btn),
                                  const SizedBox(width: 5),
                                  CustomFormButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      text: "Cancelar",
                                      color: Colors.redAccent)
                                ],
                              ),
                              const SizedBox(height: 5),
                            ],
                          )
                  ],
                ),
              ),
            );
          },
        );
      });
  return op;
}

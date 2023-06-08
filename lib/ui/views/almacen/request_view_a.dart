// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';
import 'package:devolucion_modulo/provider/almacen_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:devolucion_modulo/ui/dialog/almacen/show_dialog_request.dart';

import 'package:provider/provider.dart';

import 'package:devolucion_modulo/models/modifyModel/detail.dart';

import 'package:devolucion_modulo/ui/buttons/custom_outlined_button.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';

import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels_form.dart';

import 'package:devolucion_modulo/util/validation.dart';

import 'package:responsive_grid/responsive_grid.dart';

class AlmacenView extends StatefulWidget {
  const AlmacenView({Key? key}) : super(key: key);

  @override
  _AlmacenViewState createState() => _AlmacenViewState();
}

class _AlmacenViewState extends State<AlmacenView> {
  Validation inspector = Validation();
  //nodos de enfocado
  late FocusNode focusNodeFactura;

  @override
  void initState() {
    llenar();
    focusNodeFactura = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void llenar() async =>
      Provider.of<AlmacenProvider>(context, listen: false).inizializacion();

  @override
  Widget build(BuildContext context) {
    final almacenProvider = Provider.of<AlmacenProvider>(context);
    bool isNoSearch = true;
    bool isError = false;

    void _methodPressed() async {
      if (almacenProvider.validateForm()) {
        //INIZIALIZAR LISTAS
        List<DetailProductResponse> listDetailInvoice;
        almacenProvider.listDetailInvoiceUser = [];
        almacenProvider.listaTemp = [];
        //APARECER EL DIALOGO DE CARGA
        UtilView.buildShowDialog(context);
        //RELLENAR NUMEROS EN CASO DE NO AGREGAR LOS CEROS DE LA # FACTURA
        almacenProvider.numMov.text =
            inspector.relleno(almacenProvider.numMov.text, 9);

//-----------------------------------------------------

        await almacenProvider.getInvoice(
            almacenProvider.valTipo,
            almacenProvider.selectCombo == "02"
                ? "01"
                : almacenProvider.selectCombo,
            almacenProvider.numMov.text);

        if (almacenProvider.factura != null) {
          listDetailInvoice = await almacenProvider.getFillDetail(
              almacenProvider.valTipo,
              almacenProvider.numMov.text,
              almacenProvider.codCli.text);

          if (listDetailInvoice.isNotEmpty) {
            for (var element in listDetailInvoice) {
              Detail detail =
                  Detail(item: element, controller: TextEditingController());
              almacenProvider.listDetailInvoiceUser.add(detail);
            }

            if (isNoSearch) {
              if (almacenProvider.codCli.text == "") {
                almacenProvider.codCli.text = almacenProvider.factura!.codRef;
              }

              final opt =
                  await almacenProvider.getCliente(almacenProvider.codCli.text);

              if (!opt) {
                isError = await customDialog1(
                    context,
                    'Informacion',
                    'No se encontro ningun cliente',
                    Icons.info_outline,
                    Colors.blue);
              }
            }

            Navigator.of(context).pop();

            if (!isError) {
              final resp = await showDialogRequestA(
                  context, almacenProvider, UtilView.usuario);
              if (resp == "1") {
                final respuesta = await customDialog2(
                    context,
                    'Enhorabuena',
                    'Solicitud realizada con exito\nDeseas seguir ingresando?',
                    Icons.check_circle_outline_outlined,
                    Colors.green);

                if (respuesta) {
                  almacenProvider.numMov.text = "";
                  isNoSearch = false;
                } else {
                  almacenProvider.numMov.text = "";
                  almacenProvider.codCli.text = "";
                  almacenProvider.cuiCli.text = "";
                  almacenProvider.dirCli.text = "";
                  almacenProvider.tlfCli.text = "";
                  almacenProvider.cliNomb.text = "";
                  almacenProvider.cceCli.text = "";
                }
              }
            }
          } else {
            Navigator.of(context).pop();
            almacenProvider.numMov.text = "";
            almacenProvider.codCli.text = "";
            almacenProvider.cuiCli.text = "";
            almacenProvider.dirCli.text = "";
            almacenProvider.tlfCli.text = "";
            almacenProvider.cliNomb.text = "";
            almacenProvider.cceCli.text = "";
            UtilView.messageWarning("Cliente no coincide");
          }
        } else {
          await customDialog1(context, 'Informacion', 'No se encontro factura',
              Icons.error, Colors.redAccent);
          Navigator.of(context).pop();
        }
      } else {
        customDialog1(context, 'Advertencia', 'Campos Vacios',
            Icons.warning_amber_rounded, Colors.amberAccent);
      }
    }

    return ResponsiveGridRow(children: [
      ResponsiveGridCol(
        xl: 3,
        lg: 3,
        md: 6,
        sm: 12,
        xs: 12,
        child: Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Row(
            children: [
              const CustomLabelsForm(text: 'Codigo: '),
              Expanded(
                child: InputForm(
                    hint: '',
                    icon: Icons.contacts_outlined,
                    validator: (value) {
                      return null;
                    },
                    enable: true,
                    controller: almacenProvider.codCli,
                    regx: r'(^[a-zA-Z 0-9]*$)',
                    length: 4,
                    mayuscula: true,
                    onEditingComplete: () async {
                      if (almacenProvider.codCli.text != "") {
                        final opt = await almacenProvider
                            .getCliente(almacenProvider.codCli.text);

                        if (!opt) {
                          customDialog1(
                              context,
                              'Informacion',
                              'No se encontro ningun cliente',
                              Icons.info_outline,
                              Colors.blue);
                        } else {
                          focusNodeFactura.requestFocus();
                        }
                      }
                    },
                    onChanged: (value) {}),
              )
            ],
          ),
        ),
      ),
      ResponsiveGridCol(
        xl: 3,
        lg: 3,
        md: 6,
        sm: 12,
        xs: 12,
        child: Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Row(
            children: [
              const CustomLabelsForm(text: 'Serie: '),
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          value: almacenProvider.selectCombo,
                          items: almacenProvider.listSeries.map((item) {
                            return DropdownMenuItem(
                              value: item.codPto,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      item.serPto,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            );
                          }).toList(),
                          onChanged: (selectedItem) {
                            setState(() {
                              almacenProvider.selectCombo =
                                  selectedItem.toString();
                              almacenProvider.valTipo = "FC";
                              if (almacenProvider.selectCombo == "02") {
                                almacenProvider.valTipo = "FV";
                              }
                            });
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ResponsiveGridCol(
        xl: 3,
        lg: 3,
        md: 6,
        sm: 12,
        xs: 12,
        child: Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Row(
              children: [
                const CustomLabelsForm(text: 'Factura:    '),
                Expanded(
                  child: InputForm(
                      node: focusNodeFactura,
                      hint: '',
                      icon: Icons.assignment,
                      validator: (String value) {
                        if (value.isEmpty) return "campo requerido";
                        return null;
                      },
                      controller: almacenProvider.numMov,
                      regx: r'^(?:\+|-)?\d+$',
                      length: 20,
                      onEditingComplete: () {
                        _methodPressed();
                      },
                      onChanged: (value) {}),
                ),
              ],
            )),
      ),
      ResponsiveGridCol(
        xl: 3,
        lg: 3,
        md: 6,
        sm: 12,
        xs: 12,
        child: Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomOutlinedButton(
                    onPressed: () async => _methodPressed(),
                    color: Colors.red,
                    text: 'Buscar Factura'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomIconBtn(
                      onPressed: () {
                        almacenProvider.codCli.text = "";
                        almacenProvider.cuiCli.text = "";
                        almacenProvider.dirCli.text = "";
                        almacenProvider.tlfCli.text = "";
                        almacenProvider.cliNomb.text = "";
                        almacenProvider.cceCli.text = "";
                        almacenProvider.numMov.text = "";
                        NavigationService.replaceTo(Flurorouter.menuRoute);
                      },
                      color: Colors.blueGrey,
                      msj: "Atras",
                      icon: Icons.exit_to_app_outlined),
                ),
              ],
            )),
      ),
      ResponsiveGridCol(
        xl: 6,
        lg: 6,
        md: 6,
        sm: 12,
        xs: 12,
        child: Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Row(
              children: [
                const CustomLabelsForm(text: 'Cliente: '),
                Expanded(
                  child: InputForm(
                      hint: '',
                      enable: false,
                      icon: Icons.person_outline_outlined,
                      validator: (value) {
                        return null;
                      },
                      controller: almacenProvider.cliNomb,
                      regx: r'^(?:\+|-)?\d+$',
                      length: 40,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                )
              ],
            )),
      ),
      ResponsiveGridCol(
        xl: 3, // no sale en bootstrap (extra largo) > 120 px
        lg: 3, //  > 120 px
        md: 6, //  > 992 px
        sm: 12, // > 768 px
        xs: 12, // < 768 px
        child: Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Row(
            children: [
              const CustomLabelsForm(text: 'Ciudad:     '),
              Expanded(
                child: InputForm(
                    hint: '',
                    enable: false,
                    icon: Icons.location_city_outlined,
                    validator: (value) {
                      return null;
                    },
                    controller: almacenProvider.cuiCli,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 40,
                    onEditingComplete: () {},
                    onChanged: (value) {}),
              ),
            ],
          ),
        ),
      ),
      ResponsiveGridCol(
        xl: 3, // no sale en bootstrap (extra largo) > 120 px
        lg: 3, //  > 120 px
        md: 6, //  > 992 px
        sm: 12, // > 768 px
        xs: 12, // < 768 px
        child: Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Row(
            children: [
              const CustomLabelsForm(text: 'Telefono: '),
              Expanded(
                child: InputForm(
                    hint: '',
                    icon: Icons.phone_android_outlined,
                    validator: (value) {
                      return null;
                    },
                    controller: almacenProvider.tlfCli,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 40,
                    enable: false,
                    onEditingComplete: () {},
                    onChanged: (value) {}),
              )
            ],
          ),
        ),
      ),
      ResponsiveGridCol(
        xl: 6,
        lg: 6,
        md: 6,
        sm: 12,
        xs: 12,
        child: Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Row(
            children: [
              const CustomLabelsForm(text: 'Correo: '),
              Expanded(
                child: InputForm(
                    hint: '',
                    icon: Icons.email_outlined,
                    validator: (value) {
                      return null;
                    },
                    enable: false,
                    controller: almacenProvider.cceCli,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 40,
                    onEditingComplete: () {},
                    onChanged: (value) {}),
              )
            ],
          ),
        ),
      ),
      ResponsiveGridCol(
        lg: 6,
        md: 6,
        sm: 12,
        xs: 12,
        xl: 6,
        child: Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Row(
            children: [
              const CustomLabelsForm(text: 'Direccion: '),
              Expanded(
                child: InputForm(
                    hint: '',
                    enable: false,
                    icon: Icons.directions,
                    validator: (value) {
                      return null;
                    },
                    controller: almacenProvider.dirCli,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 40,
                    onEditingComplete: () {},
                    onChanged: (value) {}),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';

import 'package:provider/provider.dart';
import 'package:devolucion_modulo/api/return_api.dart';

import 'package:devolucion_modulo/models/serie.dart';
import 'package:devolucion_modulo/models/motivo.dart';

import 'package:devolucion_modulo/models/modifyModel/detail.dart';

import 'package:devolucion_modulo/provider/return_provider.dart';

import 'package:devolucion_modulo/ui/buttons/custom_outlined_button.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_request.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels_form.dart';

import 'package:devolucion_modulo/util/validation.dart';

import 'package:responsive_grid/responsive_grid.dart';

class RequestView extends StatefulWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  _RequestViewState createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  //lista de motivos-series
  List<Serie> listSeries = [];
  List<Motivo> listMotivos = [];
  ReturnApi conexionApi = ReturnApi();

  //Valores Iniciales y guardado
  String valTipo = "FC";
  String _selectCombo = "01";

  Validation inspector = Validation();

  @override
  void initState() {
    llenar();
    super.initState();
    Provider.of<ReturnProvider>(context, listen: false).getCliente();
  }

  void llenar() async {
    listMotivos = await conexionApi.querylistMotivos("10", "");
    listSeries = await conexionApi.querylistSeries();
    listMotivos.add(
        Motivo(cICmg: '00', codCmg: '00', nomCmg: 'SELECCIONAR', numMes: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final returnProvider = Provider.of<ReturnProvider>(context);
    void methodPressed() async {
      if (returnProvider.validateForm()) {
        List<Detail> listDetailInvoiceUser = [];
        List<DetailProductResponse> listDetailInvoice;
        returnProvider.listTemp.clear();

        buildShowDialog(context);

        returnProvider.numMov.text =
            inspector.relleno(returnProvider.numMov.text, 9);

        listDetailInvoice = await returnProvider.getFillDetail(
            valTipo, returnProvider.numMov.text, returnProvider.codCli.text);

        if (listDetailInvoice.isNotEmpty) {
          final invoice = await returnProvider.getFillInvoice(
              valTipo, _selectCombo, returnProvider.numMov.text);

          for (var element in listDetailInvoice) {
            Detail detail = Detail(
              item: element,
              controller: TextEditingController(),
            );

            listDetailInvoiceUser.add(detail);
          }

          returnProvider.numMov.text = "";
          Navigator.of(context).pop();

          final resp = await showDialogRequest(
              context, listDetailInvoiceUser, invoice.first, listMotivos);

          if (resp == "1") {
            await customDialog1(
                context, 'Su solicitud se a realizado con exito');

            //Mensaje de enviarlo a la pantalla de seguimiento si desea
          }
        } else {
          await customDialog1(context, 'No se encontro factura');
          Navigator.of(context).pop();
        }
      } else {
        customDialog1(context, 'Campos Vacios');
        Navigator.of(context).pop();
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
                    enable: false,
                    controller: returnProvider.codCli,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 20,
                    onEditingComplete: () {},
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
                          value: _selectCombo,
                          items: listSeries.map((item) {
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
                              _selectCombo = selectedItem.toString();
                              valTipo = "FC";
                              if (_selectCombo == "02") valTipo = "FV";
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
                      hint: '',
                      icon: Icons.assignment,
                      validator: (String value) {
                        if (value.isEmpty) return "campo requerido";
                        return null;
                      },
                      controller: returnProvider.numMov,
                      regx: r'^(?:\+|-)?\d+$',
                      length: 20,
                      onEditingComplete: () async {
                        methodPressed();
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
                    onPressed: () async {
                      methodPressed();
                    },
                    color: Colors.red,
                    text: 'Buscar Factura'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomIconBtn(
                      onPressed: () {
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
                      controller: returnProvider.cliNomb,
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
                    controller: returnProvider.cuiCli,
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
                    controller: returnProvider.tlfCli,
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
              const CustomLabelsForm(
                text: 'Correo: ',
              ),
              Expanded(
                child: InputForm(
                    hint: '',
                    icon: Icons.email_outlined,
                    validator: (value) {
                      return null;
                    },
                    enable: false,
                    controller: returnProvider.cceCli,
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
              const CustomLabelsForm(
                text: 'Direccion: ',
              ),
              Expanded(
                child: InputForm(
                    hint: '',
                    enable: false,
                    icon: Icons.directions,
                    validator: (value) {
                      return null;
                    },
                    controller: returnProvider.dirCli,
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

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}

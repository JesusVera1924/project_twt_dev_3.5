import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/provider/vendedor_provider.dart';

import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/invoice.dart';
import 'package:devolucion_modulo/models/modifyModel/archivo.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_vendedor.dart';
import 'package:devolucion_modulo/models/motivo.dart';

import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';

import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_transport.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_view_items.dart';
import 'package:devolucion_modulo/ui/inputs/input_dialog.dart';

import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

import 'package:devolucion_modulo/util/validation.dart';

Future<String> showDialogRequestV(BuildContext context, List<Detail> lista,
    Invoice factura, List<Motivo> listMotivos) async {
  //lista temporal para guardar el carrito de items
  List<Detail> listaTemp = [];

  List<String> _tipoValor = ["Devolución", "Garantía"];
  String pass = "0";
  String infoProducto = "";
  String _selectCombo = "00";
  String codigoTemp = "";
  Motivo obj = Motivo(cICmg: "", codCmg: "", nomCmg: "", numMes: 0);
  String _valTipo = "Devolución";
  TextEditingController controllerD = TextEditingController();
  TextEditingController controllerG = TextEditingController();
  Validation validation = Validation();
  ReturnApi returnApi = ReturnApi();
  var imgPdf;
  String btnG = "Aceptar";
  String btnD = "Aceptar";
  int contError = 0;
  String resp = "0";
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  bool isTodo = false;

  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final vendedorProvider = Provider.of<VendedorProvider>(context);

            onSelectedRow(bool selected, Detail detalle) async {
              setState(() {
                if (selected) {
                  detalle.bloqueo = true;
                  detalle.controller.text = '${detalle.item.canMov}';
                  detalle.cantidad = '${detalle.item.canMov}';
                  listaTemp.add(detalle);
                } else {
                  detalle.bloqueo = false;
                  detalle.estado = Colors.blueAccent;
                  detalle.cantidad = "0";
                  detalle.codMotivo = "00";
                  detalle.motivo = "";
                  detalle.informacion = "";
                  detalle.infoAdicional = "";
                  detalle.tipo = "Devolución";
                  detalle.archivo = "";
                  detalle.controller = TextEditingController();
                  listaTemp.remove(detalle);
                }

                if (listaTemp.length != lista.length) {
                  if (isTodo) {
                    listaTemp.forEach((element) {
                      element.tipo = "";
                      element.setInfoAdicional = "";
                      element.codMotivo = "00";
                      element.setMotivo = "";
                      element.estado = Colors.blue;
                      element.informacion = "";
                    });
                  }
                  isTodo = false;
                }
              });
            }

            Future _openFileExplorer() async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );

              if (result != null) {
                PlatformFile file = result.files.first;
                if (file.extension!.toLowerCase() == "pdf") {
                  listaTemp.forEach((element) {
                    if (element.item.codPro == codigoTemp) {
                      element.archivo = base64.encode(file.bytes!.toList());
                      vendedorProvider.setNombre = file.name;
                      imgPdf = "1";
                    }
                  });
                } else {
                  customDialog1(
                      context,
                      'Error de extensión',
                      "Extension permitida [pdf]",
                      Icons.warning_amber_rounded,
                      Colors.red);
                }
              }
            }

            void limpiar() {
              _valTipo = "Devolución";
              controllerG.text = "";
              infoProducto = "";
              imgPdf = null;
              pass = "0";
              codigoTemp = "";
              _selectCombo = "00";
              controllerD.text = "";
              vendedorProvider.setNombre = "";
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Detalle de Items'.toUpperCase()),
                  listaTemp.length == lista.length
                      ? CustomFormButton(
                          onPressed: () {
                            pass = "1";
                            isTodo = true;
                            infoProducto =
                                "Actualización global para todo los productos de la factura";
                            _valTipo = "Devolución";

                            //
                            setState(() {});
                          },
                          text: 'Devolución total')
                      : Text('')
                ],
              ),
              content: Container(
                height: 400,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black26, width: 2)),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: DataTable(
                              columnSpacing: 40,
                              columns: [
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Codigo'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false,
                                    tooltip: "Nombre producto"),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Cantidad'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: true,
                                    tooltip: "Cantidad producto"),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Devolver'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false,
                                    tooltip: "Cantidad producto a devolover"),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Motivo'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false,
                                    tooltip:
                                        "Informacion adicional del producto a devolver"),
                              ],
                              rows: lista
                                  .map((e) => DataRow(
                                          selected: listaTemp.contains(e),
                                          onSelectChanged: (b) async {
                                            onSelectedRow(b!, e);
                                            limpiar();
                                            setState(() {});
                                          },
                                          cells: [
                                            DataCell(
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(e.item.codPro)),
                                            ),
                                            DataCell(
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: Text(
                                                      e.item.nomPro +
                                                          "::" +
                                                          e.item.mrcPro +
                                                          "::" +
                                                          e.item.grpPro,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )),
                                            ),
                                            DataCell(
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Text(e.item.canMov
                                                      .toString())),
                                            ),
                                            DataCell(Align(
                                              child: SizedBox(
                                                width: 55,
                                                child: InputDialog(
                                                    hint: '',
                                                    validator: (value) {},
                                                    controller: e.controller,
                                                    regx: r'(^[0-9]*$)',
                                                    length: 5,
                                                    enable: e.bloqueo,
                                                    onChanged: (value) {
                                                      if (value != "") {
                                                        if (int.parse(value) >
                                                            e.item.canMov) {
                                                          e.controller.text =
                                                              "${e.item.canMov}";
                                                          customDialog1(
                                                              context,
                                                              'Advertencia',
                                                              'Has Superado la cantidad máxima',
                                                              Icons
                                                                  .warning_rounded,
                                                              Colors
                                                                  .amberAccent);
                                                        } else {
                                                          e.cantidad = value;
                                                        }
                                                      }
                                                    },
                                                    onEditingComplete: () {}),
                                              ),
                                            )),
                                            DataCell(Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isTodo) {
                                                    listaTemp
                                                        .forEach((element) {
                                                      element.tipo = "";
                                                      element.setInfoAdicional =
                                                          "";
                                                      element.codMotivo = "00";
                                                      element.setMotivo = "";
                                                      element.estado =
                                                          Colors.blue;
                                                      element.informacion = "";
                                                    });
                                                  }

                                                  if (listaTemp.contains(e)) {
                                                    infoProducto =
                                                        e.item.nomPro +
                                                            "::" +
                                                            e.item.mrcPro +
                                                            "::" +
                                                            e.item.grpPro;
                                                    pass = "1";
                                                    codigoTemp = e.item.codPro;

                                                    if (e.codMotivo != "00" &&
                                                        e.tipo ==
                                                            "Devolución") {
                                                      _valTipo = "Devolución";
                                                      _selectCombo =
                                                          e.codMotivo;
                                                      controllerD.text =
                                                          e.infoAdicional;
                                                      btnD = "Actualizar Razón";
                                                    } else if (e.tipo ==
                                                            "Garantía" &&
                                                        e.archivo != "") {
                                                      _valTipo = "Garantía";
                                                      controllerG.text =
                                                          e.infoAdicional;
                                                      btnG =
                                                          "Actualizar Archivo";
                                                    } else {
                                                      _valTipo = "Devolución";
                                                      _selectCombo =
                                                          e.codMotivo;
                                                      controllerD.text = "";
                                                      controllerG.text = "";
                                                    }
                                                  }
                                                  setState(() {});
                                                },
                                                child: Tooltip(
                                                  message: 'Razón',
                                                  child: Icon(
                                                    Icons.description,
                                                    color: e.estado,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ]))
                                  .toList()),
                        ),
                      ),
                    ),
                    (pass == "1")
                        ? Container(
                            margin: EdgeInsets.only(left: 0.8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black26, width: 2)),
                            width: 280,
                            child: Column(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      infoProducto,
                                      style: CustomLabels.h7,
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: RadioGroup<String>.builder(
                                      direction: Axis.horizontal,
                                      horizontalAlignment:
                                          MainAxisAlignment.center,
                                      groupValue: _valTipo,
                                      onChanged: (value) => setState(() {
                                            _valTipo = value.toString();
                                          }),
                                      items: _tipoValor,
                                      itemBuilder: (item) =>
                                          RadioButtonBuilder(item)),
                                ),
                                (_valTipo == "Devolución")
                                    ? Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                isExpanded: true,
                                                isDense: true,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                ),
                                                value: _selectCombo,
                                                items: listMotivos.map((item) {
                                                  return DropdownMenuItem(
                                                    value: item.codCmg,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Text(
                                                              item.nomCmg,
                                                              style:
                                                                  CustomLabels
                                                                      .h4),
                                                        )),
                                                  );
                                                }).toList(),
                                                onChanged: (selectedItem) {
                                                  setState(() {
                                                    _selectCombo =
                                                        selectedItem.toString();
                                                    obj =
                                                        listMotivos.singleWhere(
                                                            (element) =>
                                                                element
                                                                    .codCmg ==
                                                                _selectCombo);
                                                  });
                                                },
                                              )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 6),
                                              child: InputForm(
                                                  hint: 'Info.Adicional',
                                                  icon: Icons.assignment,
                                                  validator: (value) {},
                                                  controller: controllerD,
                                                  regx: r'(^[a-zA-Z0-9 ]*$)',
                                                  length: 200,
                                                  onChanged: (value) {},
                                                  onEditingComplete: () {}),
                                            ),
                                            CustomFormButton(
                                                onPressed: () {
                                                  if (_selectCombo != "00") {
                                                    if (isTodo) {
                                                      listaTemp
                                                          .forEach((element) {
                                                        element.tipo = _valTipo;
                                                        element.setInfoAdicional =
                                                            controllerD.text
                                                                .toUpperCase();
                                                        element.codMotivo =
                                                            obj.codCmg;
                                                        element.setMotivo =
                                                            obj.nomCmg;
                                                        element.estado =
                                                            Colors.green;
                                                        element.informacion =
                                                            element.item
                                                                    .nomPro +
                                                                "::" +
                                                                element.item
                                                                    .mrcPro +
                                                                "::" +
                                                                element.item
                                                                    .grpPro;
                                                      });

                                                      lista.forEach((element) {
                                                        element.bloqueo = false;
                                                      });
                                                    } else {
                                                      listaTemp
                                                          .forEach((element) {
                                                        if (element
                                                                .item.codPro ==
                                                            codigoTemp) {
                                                          element.tipo =
                                                              _valTipo;
                                                          element.setInfoAdicional =
                                                              controllerD.text
                                                                  .toUpperCase();
                                                          element.codMotivo =
                                                              obj.codCmg;
                                                          element.setMotivo =
                                                              obj.nomCmg;
                                                          element.estado =
                                                              Colors.green;
                                                          element.informacion =
                                                              infoProducto;
                                                        }
                                                      });
                                                    }
                                                    limpiar();
                                                    setState(() {});
                                                  } else {
                                                    customDialog1(
                                                        context,
                                                        'Advertencia',
                                                        'Seleccione el tipo de razón a devolver',
                                                        Icons.warning_rounded,
                                                        Colors.amberAccent);
                                                  }
                                                },
                                                color: Colors.red,
                                                text: btnD),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 6),
                                              child: InputForm(
                                                  hint: 'Info.Adicional',
                                                  icon: Icons.assignment,
                                                  validator: (value) {},
                                                  controller: controllerG,
                                                  regx: r'(^[a-zA-Z 0-9]*$)',
                                                  length: 200,
                                                  onChanged: (value) {},
                                                  onEditingComplete: () {}),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Text(
                                                vendedorProvider.getNombre,
                                                style: CustomLabels.h7,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CustomFormButton(
                                                  onPressed: () async {
                                                    _openFileExplorer();
                                                  },
                                                  color: Colors.blueGrey,
                                                  text: 'Subir Documento '),
                                            ),
                                            CustomFormButton(
                                                onPressed: () {
                                                  if (imgPdf == "1") {
                                                    listaTemp
                                                        .forEach((element) {
                                                      if (element.item.codPro ==
                                                          codigoTemp) {
                                                        element.informacion =
                                                            infoProducto;
                                                        element.estado =
                                                            Colors.green;
                                                        element.tipo = _valTipo;
                                                        element.setInfoAdicional =
                                                            controllerG.text
                                                                .toUpperCase();
                                                      }
                                                    });
                                                    limpiar();
                                                    setState(() {});
                                                  } else {
                                                    customDialog1(
                                                        context,
                                                        'Advertencia',
                                                        'Error cargar el pdf en el ítem correspondiente',
                                                        Icons.warning_rounded,
                                                        Colors.amberAccent);
                                                  }
                                                },
                                                color: Colors.red,
                                                text: btnG)
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
              actions: [
                CustomFormButton(
                  onPressed: () async {
                    if (listaTemp.length >= 1) {
                      final ticket = validation.relleno(
                          await returnApi.lastValueClase("V"), 9);
                      bool passWhile = true;
                      listaTemp.forEach((element) {
                        if (element.tipo == "Devolución" &&
                            element.codMotivo == "00") contError++;
                        if (element.tipo == "Garantía" && element.archivo == "")
                          contError++;
                      });

                      if (contError == 0) {
                        listaTemp.forEach((e) {
                          Ig0063 ig0063 = Ig0063(
                              codEmp: "01",
                              clsSdv: "V",
                              codVen:
                                  vendedorProvider.codVen.text.toUpperCase(),
                              numSdv: ticket,
                              fecSdv: formatter.format(now.add(Duration(
                                  days: 1))), // NO TOMAR EN CUENTA ESE DATO
                              nunSdv: "", //vacio
                              frmSdv: formatter.format(now.add(Duration(
                                  days: 1))), // NO TOMAR EN CUENTA ESE DATO
                              codRef: vendedorProvider.codCli.text,
                              codPto: e.item.codPto,
                              codMov: e.item.codMov,
                              numMov: factura.numMov,
                              fecMov: factura.fecMov,
                              frmMov: "1800-01-01",
                              secMov: vendedorProvider.listTemp.length + 1,
                              codPro: e.item.codPro,
                              canB91: double.parse(e.cantidad),
                              canB92: double.parse(e.cantidad),
                              canB93: 0,
                              canB94: 0,
                              canB95: 0,
                              canB96: 0,
                              clsMdm: e.tipo.substring(0, 1),
                              codMdm: e.codMotivo,
                              obsMdm: e.motivo,
                              codMrm: "",
                              obsMrm: "",
                              ofsSdv: e.infoAdicional,
                              obsSdv: e.informacion,
                              codCop: "",
                              nomCop: "",
                              ngrCop: "",
                              fgrCop: "",
                              bltCop: 0,
                              destino: "",
                              ptoRel: "",
                              codRel: "",
                              numRel: "",
                              fecRel: "",
                              ptoNex: "",
                              codNex: "",
                              numNex: "",
                              fecNex: "",
                              swsSdv: "",
                              ucrSdv: "",
                              fcrSdv: "",
                              uacSdv: "",
                              facSdv: "",
                              uapSdv: "",
                              fapSdv: "",
                              stsSdv: "P");

                          vendedorProvider.listTemp.add(ig0063);
                        });

                        listaTemp.forEach((element) {
                          if (element.tipo == "Garantía") {
                            vendedorProvider.listArchivo.add(new Archivo(
                                name: element.item.codPro,
                                arrayBs64: element.archivo,
                                estado: true,
                                hide: true,
                                requerido: "",
                                sufijo:
                                    "InfTec-$ticket-${element.item.codPro}"));
                          }
                        });

                        do {
                          final response = await showDialogViewItems(
                              context, 'ítems a devolver (vista)', listaTemp);

                          if (response == "1") {
                            final value = await customDialog2(
                                context,
                                'Informacion',
                                '¿Deseas ingresar datos el envio?',
                                Icons.contact_support_outlined,
                                Colors.blue);

                            if (value) {
                              final op =
                                  await showDialogTransport(context, "V");
                              if (op == "1") {
                                //envio de informacion
                                vendedorProvider.listVendedor.add(
                                    new DetailVendedor(
                                        codigo:
                                            "${vendedorProvider.listVendedor.length + 1}",
                                        codClie: vendedorProvider.codCli.text,
                                        codVen: vendedorProvider.codVen.text,
                                        nombCli: vendedorProvider.nombCli.text,
                                        nombVen: vendedorProvider.nombVen.text,
                                        listDetail: vendedorProvider.listTemp,
                                        cantidad: listaTemp.length));
                                passWhile = false;
                                resp = "1";
                                vendedorProvider.listTemp = [];
                                listaTemp = [];
                                Navigator.of(context).pop();
                              } else {
                                passWhile = true;
                              }
                            } else {
                              final decison = await customDialog2(
                                  context,
                                  'Advertencia',
                                  'Esto puede ocasionar demora a su solicitud',
                                  Icons.warning_amber_rounded,
                                  Colors.amberAccent);

                              if (decison) {
                                //envio de enformacion
                                vendedorProvider.listVendedor.add(
                                    new DetailVendedor(
                                        codigo:
                                            "${vendedorProvider.listVendedor.length + 1}",
                                        codClie: vendedorProvider.codCli.text,
                                        codVen: vendedorProvider.codVen.text,
                                        nombCli: vendedorProvider.nombCli.text,
                                        nombVen: vendedorProvider.nombVen.text,
                                        listDetail: vendedorProvider.listTemp,
                                        cantidad: listaTemp.length));
                                passWhile = false;
                                resp = "1";
                                listaTemp = [];
                                vendedorProvider.listTemp = [];
                                Navigator.of(context).pop();
                              } else {
                                //devuelta al dialogo de pregunta
                                passWhile = true;
                              }
                            }
                          } else {
                            passWhile = false;
                          }
                        } while (passWhile);
                      } else {
                        await customDialog1(
                            context,
                            'Advertencia',
                            'completar todas las razones de los ítems a devolver',
                            Icons.warning_amber_rounded,
                            Colors.amberAccent);
                        contError = 0;
                        passWhile = false;
                      }
                    } else {
                      customDialog1(
                          context,
                          'Advertencia',
                          'No se agrego ningun ítem',
                          Icons.warning_rounded,
                          Colors.amberAccent);
                    }
                  },
                  text: 'Aceptar',
                  color: Colors.green,
                ),
                CustomFormButton(
                  onPressed: () {
                    resp = "0";
                    listaTemp = [];
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

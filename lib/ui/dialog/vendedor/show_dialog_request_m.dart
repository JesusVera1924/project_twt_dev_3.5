import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:devolucion_modulo/datatables/request_vendedor.dart';
import 'package:devolucion_modulo/provider/vendedor_dialog_provider.dart';
import 'package:devolucion_modulo/ui/dialog/vendedor/show_dialog_view_detail.dart';

import 'package:provider/provider.dart';
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

import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

import 'package:devolucion_modulo/util/validation.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future<String> showDialogRequestVM(BuildContext context, List<Detail> lista,
    Invoice factura, List<Motivo> listMotivos) async {
  Motivo obj = Motivo(cICmg: "", codCmg: "", nomCmg: "", numMes: 0);

  Validation validation = Validation();

  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String resp = "0";
  final DataGridController _dataGridController = DataGridController();

  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final vendedorProvider = Provider.of<VendedorProvider>(context);
            final vdialogProvider =
                Provider.of<VendedorDialogProvider>(context);
            vdialogProvider.listaDetail = lista;

            RequestVendedorGridSource _datasource = RequestVendedorGridSource(
                vdialogProvider, context, _dataGridController);

            Future _openFileExplorer() async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );

              if (result != null) {
                PlatformFile file = result.files.first;
                if (file.extension!.toLowerCase() == "pdf") {
                  vdialogProvider.listaDetailTemp.forEach((element) {
                    if (element.item.codPro == vdialogProvider.codigoTemp) {
                      element.archivo = base64.encode(file.bytes!.toList());
                      vendedorProvider.setNombre = file.name;
                      vdialogProvider.imgPdf = "1";
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

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Detalle de Items'.toUpperCase()),
                  CustomFormButton(
                      onPressed: () {
                        vdialogProvider.pass = "1";
                        vdialogProvider.isTodo = true;
                        vdialogProvider.infoProducto =
                            "Actualización global para todo los productos de la factura\nSeleccionar un motivo general";
                        vdialogProvider.valTipo = "Devolución";
                        vdialogProvider.fillProduct();
                        setState(() {});
                      },
                      text: 'Devolución total')
                ],
              ),
              content: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black26, width: 2)),
                  child: (vdialogProvider.pass == "1")
                      ? Container(
                          margin: EdgeInsets.only(left: 0.8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black26, width: 2)),
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
                                    vdialogProvider.infoProducto,
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
                                    groupValue: vdialogProvider.valTipo,
                                    onChanged: (value) => setState(() {
                                          vdialogProvider.valTipo =
                                              value.toString();
                                        }),
                                    items: vdialogProvider.tipoValor,
                                    itemBuilder: (item) =>
                                        RadioButtonBuilder(item)),
                              ),
                              (vdialogProvider.valTipo == "Devolución")
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                              isExpanded: true,
                                              isDense: true,
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                              ),
                                              value:
                                                  vdialogProvider.selectCombo,
                                              items: listMotivos.map((item) {
                                                return DropdownMenuItem(
                                                  value: item.codCmg,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(item.nomCmg,
                                                            style: CustomLabels
                                                                .h4),
                                                      )),
                                                );
                                              }).toList(),
                                              onChanged: (selectedItem) {
                                                setState(() {
                                                  vdialogProvider.selectCombo =
                                                      selectedItem.toString();
                                                  obj = listMotivos.singleWhere(
                                                      (element) =>
                                                          element.codCmg ==
                                                          vdialogProvider
                                                              .selectCombo);
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
                                                controller:
                                                    vdialogProvider.controllerD,
                                                regx: r'(^[a-zA-Z0-9 ]*$)',
                                                length: 200,
                                                onChanged: (value) {},
                                                onEditingComplete: () {}),
                                          ),
                                          CustomFormButton(
                                              onPressed: () {
                                                if (vdialogProvider
                                                        .selectCombo !=
                                                    "00") {
                                                  if (vdialogProvider.isTodo) {
                                                    vdialogProvider
                                                        .listaDetailTemp
                                                        .forEach((element) {
                                                      element.tipo =
                                                          vdialogProvider
                                                              .valTipo;
                                                      element.setInfoAdicional =
                                                          vdialogProvider
                                                              .controllerD.text
                                                              .toUpperCase();
                                                      element.codMotivo =
                                                          obj.codCmg;
                                                      element.setMotivo =
                                                          obj.nomCmg;
                                                      element.estado =
                                                          Colors.green;
                                                      element
                                                          .informacion = element
                                                              .item.nomPro +
                                                          "::" +
                                                          element.item.mrcPro +
                                                          "::" +
                                                          element.item.grpPro;
                                                    });

                                                    lista.forEach((element) {
                                                      element.bloqueo = false;
                                                    });
                                                  } else {
                                                    vdialogProvider
                                                        .listaDetailTemp
                                                        .forEach((element) {
                                                      if (element.item.codPro ==
                                                          vdialogProvider
                                                              .codigoTemp) {
                                                        element.tipo =
                                                            vdialogProvider
                                                                .valTipo;
                                                        element.setInfoAdicional =
                                                            vdialogProvider
                                                                .controllerD
                                                                .text
                                                                .toUpperCase();
                                                        element.codMotivo =
                                                            obj.codCmg;
                                                        element.setMotivo =
                                                            obj.nomCmg;
                                                        element.estado =
                                                            Colors.green;
                                                        element.informacion =
                                                            vdialogProvider
                                                                .infoProducto;
                                                      }
                                                    });
                                                  }
                                                  vendedorProvider.setNombre =
                                                      "";
                                                  vdialogProvider.limpiar();
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
                                              text: vdialogProvider.btnD),
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
                                                controller:
                                                    vdialogProvider.controllerG,
                                                regx: r'(^[a-zA-Z 0-9]*$)',
                                                length: 200,
                                                onChanged: (value) {},
                                                onEditingComplete: () {}),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              vendedorProvider.getNombre,
                                              style: CustomLabels.h7,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomFormButton(
                                                onPressed: () async {
                                                  _openFileExplorer();
                                                },
                                                color: Colors.blueGrey,
                                                text: 'Subir Documento '),
                                          ),
                                          CustomFormButton(
                                              onPressed: () {
                                                if (vdialogProvider.imgPdf ==
                                                    "1") {
                                                  vdialogProvider
                                                      .listaDetailTemp
                                                      .forEach((element) {
                                                    if (element.item.codPro ==
                                                        vdialogProvider
                                                            .codigoTemp) {
                                                      element.informacion =
                                                          vdialogProvider
                                                              .infoProducto;
                                                      element.estado =
                                                          Colors.green;
                                                      element.tipo =
                                                          vdialogProvider
                                                              .valTipo;
                                                      element.setInfoAdicional =
                                                          vdialogProvider
                                                              .controllerG.text
                                                              .toUpperCase();
                                                    }
                                                  });
                                                  vdialogProvider.limpiar();
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
                                              text: vdialogProvider.btnG)
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        )
                      : SfDataGrid(
                          source: _datasource,
                          allowSorting: true,
                          columnWidthMode: ColumnWidthMode.fill,
                          selectionMode: SelectionMode.single,
                          controller: _dataGridController,
                          columns: <GridColumn>[
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
                              autoFitPadding: const EdgeInsets.all(8),
                              columnName: 'producto',
                              label: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Producto',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            GridColumn(
                              width: 60,
                              columnName: 'cantidad',
                              label: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'Cantidad',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            GridColumn(
                              width: 70,
                              columnName: 'devolver',
                              label: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Devolver',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            GridColumn(
                              columnWidthMode: ColumnWidthMode.fitByColumnName,
                              columnName: 'motivo',
                              label: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Motivo',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        )),
              actions: [
                CustomFormButton(
                  onPressed: () async {
                    if (vdialogProvider.listaDetailTemp.length >= 1) {
                      final ticket = validation.relleno(
                          await vdialogProvider.returnApi.lastValueClase("V"),
                          9);
                      bool passWhile = true;
                      vdialogProvider.listaDetailTemp.forEach((element) {
                        if (element.tipo == "Devolución" &&
                            element.codMotivo == "00")
                          vdialogProvider.contError++;
                        if (element.tipo == "Garantía" && element.archivo == "")
                          vdialogProvider.contError++;
                      });

                      if (vdialogProvider.contError == 0) {
                        vdialogProvider.listaDetailTemp.forEach((e) {
                          Ig0063 ig0063 = Ig0063(
                              codEmp: "01",
                              clsSdv: "V",
                              codVen:
                                  vendedorProvider.codVen.text.toUpperCase(),
                              numSdv: ticket,
                              fecSdv: formatter.format(now),
                              nunSdv: "", //vacio
                              frmSdv:
                                  formatter.format(now.add(Duration(hours: 5))),
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

                        vdialogProvider.listaDetailTemp.forEach((element) {
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
                          final response = await showDialogViewDetail(
                              context,
                              'ítems a devolver (vista)',
                              vdialogProvider.listaDetailTemp);

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
                                        cantidad: vdialogProvider
                                            .listaDetailTemp.length));
                                passWhile = false;
                                resp = "1";
                                vendedorProvider.listTemp = [];
                                vdialogProvider.listaDetailTemp = [];
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
                                        cantidad: vdialogProvider
                                            .listaDetailTemp.length));
                                passWhile = false;
                                resp = "1";
                                vdialogProvider.listaDetailTemp = [];
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
                        vdialogProvider.contError = 0;
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
                    vdialogProvider.listaDetailTemp = [];
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

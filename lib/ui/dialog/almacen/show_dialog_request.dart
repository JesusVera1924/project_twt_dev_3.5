// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member
import 'package:devolucion_modulo/datatables/request_datasource.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/provider/almacen_provider.dart';
import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_transport.dart';
import 'package:devolucion_modulo/ui/dialog/devolucion/show_dialog_view_items.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future<String> showDialogRequestA(
    BuildContext context, AlmacenProvider provider, Usuario user) async {
  final returnApi = ReturnApi();
  int contError = 0;
  String resp = "0";
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  final DataGridController dataGridController = DataGridController();
  final dataSource = RequestDTS(context, provider, dataGridController);

  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Detalle de Factura".toUpperCase(),
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Container(
                    width: Responsive.isDesktop(context) ? 800 : 400,
                    height: 310,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black26, width: 2)),
                    child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor: Colors.blueGrey,
                            selectionColor:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            filterIconColor: Colors.black,
                            filterIconHoverColor: Colors.white),
                        child: SfDataGrid(
                            columnWidthMode: ColumnWidthMode.none,
                            headerRowHeight: 40,
                            rowHeight: 40,
                            showCheckboxColumn: true,
                            selectionMode: SelectionMode.multiple,
                            controller: dataGridController,
                            onSelectionChanged: (addedRows, removedRows) {
                              provider.onSelectedRow(addedRows, removedRows);
                              dataSource.actualizarColumnas();
                            },
                            source: dataSource,
                            columns: _buildDataGridForSize(context))),
                  ),
                ],
              ),
              actions: [
                CustomFormButton(
                  onPressed: () async {
                    //control del while
                    bool controllerWhile = true;
                    String ticket = "";
                    provider.listTemp.clear();

                    if (provider.listaTemp.isNotEmpty) {
                      /*   final ticket = validation.relleno(
                          await returnApi.lastValueClase("A"), 9); */
                      for (var element in provider.listaTemp) {
                        if (element.tipo == "Devolución" &&
                            element.codMotivo == "00") contError++;
                        if (element.tipo == "Garantía" &&
                            element.archivo == "") {
                          contError++;
                        }
                      }

                      if (contError == 0) {
                        for (var e in provider.listaTemp) {
                          Ig0063 ig0063 = Ig0063(
                              codEmp: "01",
                              clsSdv: "A",
                              codVen: provider.factura!.codVen,
                              numSdv: ticket,
                              fecSdv: formatter.format(now),
                              nunSdv: "", //vacio
                              frmSdv: formatter.format(now),
                              codRef: provider.codCli.text,
                              codPto: e.item.codPto,
                              codMov: e.item.codMov,
                              numMov: provider.factura!.numMov,
                              fecMov: provider.factura!.fecMov,
                              frmMov: "1800-01-02",
                              secMov: provider.listTemp.length + 1,
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
                              ucrSdv: user.ctaUsr,
                              fcrSdv: "",
                              uacSdv: "",
                              facSdv: "",
                              uapSdv: "",
                              fapSdv: "",
                              stsSdv: "P");
                          provider.listTemp.add(ig0063);
                        }

                        do {
                          final response = await showDialogViewItems(context,
                              'ítems a devolver (vista)', provider.listaTemp);

                          if (response == "1") {
                            final value = await customDialog2(
                                context,
                                'Informacion',
                                '¿Deseas ingresar datos el envio?',
                                Icons.contact_support_outlined,
                                Colors.blue);

                            if (value) {
                              final op =
                                  await showDialogTransport(context, "A");
                              if (op == "1") {
                                //envio de informacion
                                ticket = await returnApi
                                    .postListIg0063(provider.listTemp);

                                await provider.convertKarmov(ticket);
                                /* for (var element in provider.listTemp) {
                                  returnApi.postIg0063(element);
                                  returnApi.updateBodega2(element.codPro, "92",
                                      "${element.canB91}");

                                  returnApi.postKardex(Kardex(
                                      codEmp: "01",
                                      codPto: "01",
                                      codMov: element.codMov,
                                      numMov: ticket,
                                      fecMov: DateTime.now(),
                                      codRel: element.codMov,
                                      numRel: element.numMov,
                                      fecRel: DateTime.now(),
                                      codRef: element.codRef,
                                      nomRef: "",
                                      codPro: element.codPro,
                                      codBod: "92",
                                      canMov: element.canB91,
                                      pacCos: 0,
                                      vacCos: 0,
                                      codMdm: element.codMdm,
                                      obsMdm: element.obsMdm,
                                      obsMov: "",
                                      ucrMov: "",
                                      dcrMov: DateTime.now(),
                                      uacMov: "",
                                      dacMov: DateTime.now(),
                                      somMov: "+",
                                      stsMov: "1"));
                                } */

                                for (var element in provider.listaTemp) {
                                  if (element.tipo == "Garantía") {
                                    returnApi.uploadDocument(element.archivo,
                                        "InfTec-$ticket-${element.item.codPro}");
                                  }
                                }
                                controllerWhile = false;
                                resp = "1";
                                provider.listaTemp = [];
                                /*  CreateFilePdf().pdf4(
                                    provider.listTemp,
                                    provider.factura.nomRef,
                                    provider.cceCli.text); */
                                Navigator.of(context).pop();
                              } else {
                                controllerWhile = true;
                              }
                            } else {
                              /*   final decison = await customDialog2(
                                  context,
                                  'Advertencia',
                                  'Esto puede ocasionar demora a su solicitud',
                                  Icons.warning_amber_rounded,
                                  Colors.amberAccent); */

                              /* if (decison) { */
                              //envio de enformacion
                              ticket = await returnApi
                                  .postListIg0063(provider.listTemp);

                              await provider.convertKarmov(ticket);
                              /* for (var element in provider.listTemp) {
                                returnApi.updateBodega2(
                                    element.codPro, "92", "${element.canB91}");
                                returnApi.postIg0063(element);

                                returnApi.postKardex(Kardex(
                                    codEmp: "01",
                                    codPto: "01",
                                    codMov: element.codMov,
                                    numMov: ticket,
                                    fecMov: DateTime.now(),
                                    codRel: element.codMov,
                                    numRel: element.numMov,
                                    fecRel: DateTime.now(),
                                    codRef: element.codRef,
                                    nomRef: "",
                                    codPro: element.codPro,
                                    codBod: "92",
                                    canMov: element.canB91,
                                    pacCos: 0,
                                    vacCos: 0,
                                    codMdm: element.codMdm,
                                    obsMdm: element.obsMdm,
                                    obsMov: "",
                                    ucrMov: "",
                                    dcrMov: DateTime.now(),
                                    uacMov: "",
                                    dacMov: DateTime.now(),
                                    somMov: "+",
                                    stsMov: "1"));
                              } */

                              for (var element in provider.listaTemp) {
                                if (element.tipo == "Garantía") {
                                  returnApi.uploadDocument(element.archivo,
                                      "InfTec-$ticket-${element.item.codPro}");
                                }
                              }
                              controllerWhile = false;
                              provider.listaTemp = [];
                              resp = "1";
                              /*   CreateFilePdf().pdf4(
                                  provider.listTemp,
                                  provider.factura.nomRef,
                                  provider.cceCli.text);*/
                              Navigator.of(context).pop();
                              /*    }  else {
                                //devuelta al dialogo de pregunta
                                controllerWhile = true;
                              } */
                            }
                          } else {
                            controllerWhile = false;
                          }
                        } while (controllerWhile);
                      } else {
                        await customDialog1(
                            context,
                            'Advertencia',
                            'completar todas las razones de los ítems a devolver',
                            Icons.warning_amber_rounded,
                            Colors.amberAccent);
                        contError = 0;
                        controllerWhile = false;
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
                    provider.listaTemp = [];
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

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = [
    GridColumn(
      columnName: '1-codigo',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('CODIGO',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '2-marca',
      allowFiltering: false,
      width: 120,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('MARCA',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '3-producto',
      allowFiltering: false,
      columnWidthMode: ColumnWidthMode.fill,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('PRODUCTO',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '4-cant',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('CANT',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '5-devolver',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.centerLeft,
        child: Text('DEVOLVER',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
    GridColumn(
      columnName: '6-motivo',
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      label: Container(
        padding: const EdgeInsets.all(8.0),
        //width: Responsive.isDesktop(context) ? 100 : 80,
        alignment: Alignment.center,
        child: Text('MOTIVO',
            style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
      ),
    ),
  ];

  return list;
}

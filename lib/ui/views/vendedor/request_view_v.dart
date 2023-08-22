// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/models/yk0001.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/detailProductResponse.dart';
import 'package:devolucion_modulo/provider/vendedor_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:devolucion_modulo/ui/buttons/custom_outlined_button.dart';
import 'package:devolucion_modulo/ui/dialog/vendedor/show_dialog_request.dart';

import 'package:devolucion_modulo/ui/labels/custom_labels_form.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/modifyModel/detail.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';
import 'package:searchfield/searchfield.dart';

class RequestViewV extends StatefulWidget {
  const RequestViewV({Key? key}) : super(key: key);

  @override
  _RequestViewVState createState() => _RequestViewVState();
}

class _RequestViewVState extends State<RequestViewV> {
  //lista de motivos-series

  Validation inspector = Validation();
  ReturnApi conexionApi = ReturnApi();

  //nodos
  late FocusNode myFocusNodeV;
  late FocusNode myFocusNodeC;
  late FocusNode myFocusNodeF;

  @override
  void initState() {
    myFocusNodeV = FocusNode();
    myFocusNodeC = FocusNode();
    myFocusNodeF = FocusNode();
    Provider.of<VendedorProvider>(context, listen: false).getVendedorInicial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vendedorProvider = Provider.of<VendedorProvider>(context);
    final size = MediaQuery.of(context).size;

    void _methodPressed() async {
      String resp = "";
      if (vendedorProvider.validateForm()) {
        List<DetailProductResponse> listDetailInvoice;
        vendedorProvider.listDetailInvoiceUser = [];
        vendedorProvider.listaTemp = [];

        UtilView.buildShowDialog(context);
        vendedorProvider.numMov.text =
            inspector.relleno(vendedorProvider.numMov.text, 9);

        await vendedorProvider.getInvoice(
            vendedorProvider.valTipo,
            vendedorProvider.selectCombo == "02"
                ? "01"
                : vendedorProvider.selectCombo,
            vendedorProvider.numMov.text);

        if (vendedorProvider.factura != null) {
          listDetailInvoice = await vendedorProvider.getFillDetail(
              vendedorProvider.valTipo,
              vendedorProvider.numMov.text,
              vendedorProvider.codCli.text);

          if (listDetailInvoice.isNotEmpty) {
            for (var element in listDetailInvoice) {
              Detail detail =
                  Detail(item: element, controller: TextEditingController());
              vendedorProvider.listDetailInvoiceUser.add(detail);
            }

            resp = await showDialogRequestV(
                context, vendedorProvider, UtilView.usuario);

            if (resp != "0") {
              final opt = await customDialog2(
                  context,
                  'Enhorabuena',
                  'Solicitud realizada con exito\nNumero de\nseguimiento:$resp!\nDeseas seguir ingresando?',
                  Icons.check_circle_outline_outlined,
                  Colors.green);

              if (opt) {
                vendedorProvider.numMov.text = "";
              } else {
                vendedorProvider.numMov.text = "";
                vendedorProvider.codCli.text = "";
                vendedorProvider.nombCli.text = "";
                myFocusNodeV.requestFocus();
              }
            }
          } else {
            await customDialog1(context, 'No se encontro factura');
          }
        } else {
          await customDialog1(context, 'Error para obtener datos');
        }
        Navigator.of(context).pop();
      } else {
        UtilView.messageWarning("Complete los campos del formulario");
      }
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const CustomLabelsForm(text: 'Codigo:      '),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                constraints: BoxConstraints(
                    maxWidth: !Responsive.isMobile(context)
                        ? Responsive.width(size.width, 2)
                        : double.infinity),
                child: vendedorProvider.isBloqueo
                    ? SizedBox(
                        height: 44,
                        child: SearchField(
                          searchInputDecoration:
                              CustomInputs.formInputDecoration2(
                                  icon: Icons.supervised_user_circle_rounded),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                            LengthLimitingTextInputFormatter(4)
                          ],
                          suggestions: vendedorProvider.listVCallCenter
                              .map(
                                (i) => SearchFieldListItem<Yk0001>(
                                  i.omision,
                                  item: i,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          i.omision,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          controller: vendedorProvider.codVen,
                          onSuggestionTap: (value) async {
                            if (value.item != null) {
                              vendedorProvider.codVen.text =
                                  value.item!.omision;
                              await vendedorProvider.callEventCliente(
                                  value.item!.omision.toString());
                              myFocusNodeC.requestFocus();
                            }
                          },
                        ),
                      )
                    : InputForm(
                        hint: '',
                        node: myFocusNodeV,
                        icon: Icons.contacts_outlined,
                        validator: (value) {
                          return null;
                        },
                        enable: false,
                        controller: vendedorProvider.codVen,
                        regx: r'(^[a-zA-Z 0-9]*$)',
                        mayuscula: true,
                        length: 4,
                        onEditingComplete: () async {
                          /* if (vendedorProvider.codVen.text != "" &&
                          vendedorProvider.codVen.text.length == 4) {
                        UtilView.buildShowDialog(context);
                        final opt = await vendedorProvider.getVendedor(
                            vendedorProvider.codVen.text.toUpperCase());
                        Navigator.of(context).pop();
                        if (!opt) {
                          UtilView.messageDanger(
                              "No se encontro ningun vendedor");
                        } else {
                          myFocusNodeC.requestFocus();
                        }
                      } */
                        },
                        onChanged: (value) {}),
              ),
              const CustomLabelsForm(text: 'Cliente: '),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                constraints: BoxConstraints(
                    maxWidth: !Responsive.isMobile(context)
                        ? Responsive.width(size.width, 2)
                        : double.infinity),
                child: InputForm(
                    hint: '',
                    node: myFocusNodeC,
                    icon: Icons.contacts_outlined,
                    validator: (value) {
                      return null;
                    },
                    enable: true,
                    controller: vendedorProvider.codCli,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 4,
                    onEditingComplete: () async {
                      if (vendedorProvider.codCli.text != "" &&
                          vendedorProvider.codVen.text != "" &&
                          vendedorProvider.codCli.text.length == 4) {
                        UtilView.buildShowDialog(context);

                        final opt = await vendedorProvider.getCliente(
                            vendedorProvider.codCli.text,
                            vendedorProvider.codVen.text);

                        if (!opt) {
                          myFocusNodeF.requestFocus();
                        }

                        /* if (opt) {
                          UtilView.messageDanger(
                              "No se encontro ningun cliente asociado con el codigo del vendedor");
                        } else {
                          myFocusNodeF.requestFocus();
                        } */
                        Navigator.of(context).pop();
                      }
                    },
                    onChanged: (String value) async {
                      if (value.length == 4) {
                        UtilView.buildShowDialog(context);

                        final opt = await vendedorProvider.getCliente(
                            vendedorProvider.codCli.text,
                            vendedorProvider.codVen.text);

                        if (!opt) {
                          myFocusNodeF.requestFocus();
                        }

                        Navigator.of(context).pop();
                      }
                    }),
              ),
              const CustomLabelsForm(text: 'Serie: '),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                constraints: BoxConstraints(
                    maxWidth: !Responsive.isMobile(context)
                        ? Responsive.width(size.width, 2.5)
                        : double.infinity),
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
                          value: vendedorProvider.selectCombo,
                          items: vendedorProvider.listSeries.map((item) {
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
                              vendedorProvider.selectCombo =
                                  selectedItem.toString();
                              vendedorProvider.valTipo = "FC";
                              if (vendedorProvider.selectCombo == "02") {
                                vendedorProvider.valTipo = "FV";
                              }
                            });
                          }),
                    ),
                  ),
                ),
              ),
              const CustomLabelsForm(text: 'Factura:    '),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                constraints: BoxConstraints(
                    maxWidth: !Responsive.isMobile(context)
                        ? Responsive.width(size.width, 2.6)
                        : double.infinity),
                child: InputForm(
                    hint: '',
                    icon: Icons.assignment,
                    validator: (String value) {
                      if (value.isEmpty) return "campo requerido";
                      return null;
                    },
                    node: myFocusNodeF,
                    controller: vendedorProvider.numMov,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 20,
                    onEditingComplete: () async {
                      if (vendedorProvider.numMov.text != "") {
                        _methodPressed();
                      } else {
                        customDialog1(context, "Campo vacio");
                      }
                    },
                    onChanged: (value) {}),
              ),
              const CustomLabelsForm(text: 'Vendedor: '),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                constraints: BoxConstraints(
                    maxWidth: !Responsive.isMobile(context)
                        ? Responsive.width(size.width, 5.2)
                        : double.infinity),
                child: InputForm(
                    hint: '',
                    enable: false,
                    icon: Icons.person_outline_outlined,
                    validator: (value) {
                      return null;
                    },
                    controller: vendedorProvider.nombVen,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 40,
                    onEditingComplete: () {},
                    onChanged: (value) {}),
              ),
              const CustomLabelsForm(text: 'Cliente: '),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                constraints: BoxConstraints(
                    maxWidth: !Responsive.isMobile(context)
                        ? Responsive.width(size.width, 5.2)
                        : double.infinity),
                child: InputForm(
                    hint: '',
                    enable: false,
                    icon: Icons.person_outline_outlined,
                    validator: (value) {
                      return null;
                    },
                    controller: vendedorProvider.nombCli,
                    regx: r'^(?:\+|-)?\d+$',
                    length: 40,
                    onEditingComplete: () {},
                    onChanged: (value) {}),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomOutlinedButton(
                onPressed: () async {
                  _methodPressed();
                },
                color: Colors.red,
                text: 'Buscar Factura'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomIconBtn(
                  onPressed: () {
                    NavigationService.replaceTo(Flurorouter.menuRoute);
                  },
                  color: Colors.blueGrey,
                  msj: "Atras",
                  icon: Icons.exit_to_app_outlined),
            ),
          ],
        ),
        /*   if (vendedorProvider.listVendedor.isNotEmpty)
          ResponsiveGridCol(
            xl: 12,
            child: Container(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Column(
                children: [
                  const Divider(thickness: 1),
                  SizedBox(
                    width: 200,
                    child: InputForm(
                        hint: 'Codigo de referencia',
                        icon: Icons.assignment,
                        validator: (value) {
                          return null;
                        },
                        mayuscula: true,
                        controller: vendedorProvider.codRef,
                        regx: r'(^[a-zA-Z 0-9]*$)',
                        length: 9,
                        onEditingComplete: () {},
                        onChanged: (value) {}),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: MediaQuery.of(context).size.width >= 700
                        ? DataTable(
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
                                      'Cliente'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Cliente'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Vendedor'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Vendedor'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Items'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  numeric: true,
                                  tooltip: "Detalle de items a devolver"),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Acciones'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  numeric: false,
                                  tooltip: "Eliminar ítems"),
                            ],
                            rows: vendedorProvider.listVendedor
                                .map((e) => DataRow(
                                        color: MaterialStateProperty
                                            .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.hovered))
                                            return Colors.black26
                                                .withOpacity(0.08);
                                          if (states
                                              .contains(MaterialState.selected))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.08);
                                          return null;
                                        }),
                                        onSelectChanged: (value) async {
                                          await showDialogViewVendedor(
                                              context,
                                              "Vista Previa (Devolucion)",
                                              e.listDetail);
                                        },
                                        cells: [
                                          DataCell(
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(e.codClie)),
                                          ),
                                          DataCell(
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(e.nombCli)),
                                          ),
                                          DataCell(
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    e.codVen.toUpperCase())),
                                          ),
                                          DataCell(
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(e.nombVen)),
                                          ),
                                          DataCell(
                                            Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text("${e.cantidad}")),
                                          ),
                                          DataCell(
                                            Align(
                                                alignment: Alignment.center,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    final opt = await customDialog2(
                                                        context,
                                                        'Adevertencia',
                                                        'Estas seguro que deseas eliminarlo?',
                                                        Icons.delete_outlined,
                                                        Colors.red);
                                                    if (opt) {
                                                      setState(() {
                                                        vendedorProvider
                                                            .listVendedor
                                                            .removeWhere(
                                                                (element) =>
                                                                    element
                                                                        .codigo ==
                                                                    e.codigo);
                                                      });
                                                    }
                                                  },
                                                  child: const Icon(
                                                      Icons
                                                          .delete_outline_outlined,
                                                      color: Colors.red),
                                                )),
                                          ),
                                        ]))
                                .toList())
                        : SfDataGrid(
                            columns: [
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.fill,
                                columnName: 'Cliente',
                                label: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Cliente',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnWidthMode: ColumnWidthMode.fill,
                                columnName: 'Vendedor',
                                label: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Vendedor',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                columnName: 'items',
                                label: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Items',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                columnName: 'Acciones',
                                label: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Acciones',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                            source: ListVendedorViewGridSource(
                                vendedorProvider, context),
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 120,
                    child: CustomFormButton(
                        color: Colors.blueGrey,
                        onPressed: () async {
                          final opt = await customDialog2(
                              context,
                              'Información',
                              'Estas seguro que deseas enviar?',
                              Icons.info_outline_rounded,
                              Colors.blue);

                          if (vendedorProvider.codRef.text != "") {
                            for (var element in vendedorProvider.listVendedor) {
                              for (var element in element.listDetail) {
                                element.nunSdv = vendedorProvider.codRef.text;
                              }
                            }
                          }

                          if (opt) {
                            for (var element in vendedorProvider.listVendedor) {
                              for (var element in element.listDetail) {
                                conexionApi.postIg0063(element);
                                conexionApi.updateBodega2(
                                    element.codPro, "92", "${element.canB91}");
                                conexionApi.postKardex(Kardex(
                                    codEmp: "01",
                                    codPto: "01",
                                    codMov: element.codMov,
                                    numMov: element.numSdv,
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
                              }
                            }

                            /*  vendedorProvider.listArchivo.forEach((element) {
                              conexionApi.uploadDocument(
                                  element.getArrayBs64, element.getSufijo);
                            }); */

                            //vendedorProvider.listArchivo = [];
                            vendedorProvider.listVendedor = [];
                            vendedorProvider.numMov.text = "";
                            vendedorProvider.codCli.text = "";
                            vendedorProvider.codVen.text = "";
                            vendedorProvider.nombVen.text = "";
                            vendedorProvider.nombCli.text = "";
                            setState(() {});
                          }
                        },
                        text: 'Enviar'),
                  )
                ],
              ),
            ),
          )
       */
      ],
    );
  }
}

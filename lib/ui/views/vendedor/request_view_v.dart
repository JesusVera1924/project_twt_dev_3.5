// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/datatables/list_vendedor_view.dart';
import 'package:devolucion_modulo/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/models/yk0001.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog2.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog8.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/navbar.dart';
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
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RequestViewV extends StatefulWidget {
  const RequestViewV({Key? key}) : super(key: key);

  @override
  _RequestViewVState createState() => _RequestViewVState();
}

class _RequestViewVState extends State<RequestViewV> {
  //lista de motivos-series

  Validation inspector = Validation();
  ReturnApi conexionApi = ReturnApi();
  bool isEquals = true;

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
        if (await vendedorProvider
            .verificar(inspector.relleno(vendedorProvider.numMov.text, 9))) {
          if (vendedorProvider
              .verificarExistenciaFact(vendedorProvider.numMov.text)) {
            vendedorProvider.numMov.clear();
            UtilView.messageWarning("Se encontrol [Factura] en el detalle");
          } else {
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
                  Detail detail = Detail(
                      item: element, controller: TextEditingController());
                  vendedorProvider.listDetailInvoiceUser.add(detail);
                }

                resp = await showDialogRequestV(
                    context, vendedorProvider, UtilView.usuario);

                if (resp != "0") {
                  final opt = await customDialog8(
                      context,
                      'Enhorabuena',
                      'Deseas seguir ingresando?',
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
                  isEquals = false;
                  setState(() {});
                }
              } else {
                UtilView.messageWarning("No se encontro factura");
              }
            } else {
              UtilView.messageWarning("Error para obtener datos");
            }
            Navigator.of(context).pop();
          }
        } else {
          UtilView.messageWarning("Error / Cliente diferente [FC]");
        }
      } else {
        UtilView.messageWarning("Complete los campos del formulario");
      }
    }

    return Container(
      color: const Color.fromARGB(184, 156, 159, 160),
      child: ListView(
        children: [
          Navbar(listW: [
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
          ], titulo: "Proceso de devolución"),
          Container(
            margin: const EdgeInsets.only(top: 8, right: 10, left: 10),
            decoration: buildBoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const CustomLabelsForm(text: 'Codigo:      '),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
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
                                      icon:
                                          Icons.supervised_user_circle_rounded),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
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
                        enable: isEquals,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    constraints: BoxConstraints(
                        maxWidth: !Responsive.isMobile(context)
                            ? Responsive.width(size.width, 2.2)
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    constraints: BoxConstraints(
                        maxWidth: !Responsive.isMobile(context)
                            ? Responsive.width(size.width, 2.5)
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
                            UtilView.messageWarning("Campo [Factura] vacio");
                          }
                        },
                        onChanged: (value) {}),
                  ),
                  const CustomLabelsForm(text: 'Vendedor: '),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    constraints: BoxConstraints(
                        maxWidth: !Responsive.isMobile(context)
                            ? Responsive.width(size.width, 5)
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    constraints: BoxConstraints(
                        maxWidth: !Responsive.isMobile(context)
                            ? Responsive.width(size.width, 5)
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
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, right: 10, left: 10),
            decoration: buildBoxDecoration(),
            child: Column(
              crossAxisAlignment: MediaQuery.of(context).size.width >= 700
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                if (vendedorProvider.listSolicitudes.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Detalle de solicitudes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                if (vendedorProvider.listSolicitudes.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width >= 700
                        ? 1100
                        : MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                          headerColor: Colors.blueGrey,
                          selectionColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          filterIconColor: Colors.black,
                          filterIconHoverColor: Colors.white),
                      child: SfDataGrid(
                        columnWidthMode: ColumnWidthMode.none,
                        headerRowHeight: 35,
                        rowHeight: 35,
                        selectionMode: SelectionMode.multiple,
                        columns: [
                          GridColumn(
                            columnName: '1-Factura',
                            allowFiltering: false,
                            width: 100,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              //width: Responsive.isDesktop(context) ? 100 : 80,
                              alignment: Alignment.center,
                              child: Text('FACTURA',
                                  style: CustomLabels.h11,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          GridColumn(
                            columnName: '2-cliente',
                            width: 80,
                            columnWidthMode: ColumnWidthMode.fitByCellValue,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              //width: Responsive.isDesktop(context) ? 100 : 80,
                              alignment: Alignment.center,
                              child: Text('CLIENTE',
                                  style: CustomLabels.h11,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          GridColumn(
                            columnName: '3-codigo',
                            allowFiltering: false,
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              //width: Responsive.isDesktop(context) ? 100 : 80,
                              alignment: Alignment.center,
                              child: Text('CODIGO',
                                  style: CustomLabels.h11,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          GridColumn(
                            columnName: '4-producto',
                            allowFiltering: false,
                            columnWidthMode: ColumnWidthMode.fill,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              //width: Responsive.isDesktop(context) ? 100 : 80,
                              alignment: Alignment.center,
                              child: Text('PRODUCTO',
                                  style: CustomLabels.h11,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          GridColumn(
                            columnName: '5-cantidad',
                            allowFiltering: false,
                            width: 100,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              //width: Responsive.isDesktop(context) ? 100 : 80,
                              alignment: Alignment.center,
                              child: Text('UNIDAD',
                                  style: CustomLabels.h11,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          GridColumn(
                            columnName: '6-tipo',
                            allowFiltering: false,
                            width: 100,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              //width: Responsive.isDesktop(context) ? 100 : 80,
                              alignment: Alignment.center,
                              child: Text('TIPO',
                                  style: CustomLabels.h11,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          GridColumn(
                            columnName: '7-acciones',
                            allowFiltering: false,
                            width: 100,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              //width: Responsive.isDesktop(context) ? 100 : 80,
                              alignment: Alignment.center,
                              child: Text('ELIMINAR',
                                  style: CustomLabels.h11,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                        source: ListVendedorViewGridSource(
                            vendedorProvider, context),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomOutlinedButton(
                          onPressed: () async {
                            _methodPressed();
                          },
                          color: Colors.blueGrey,
                          text: 'Buscar Factura'),
                      if (vendedorProvider.listSolicitudes.isNotEmpty)
                        const SizedBox(width: 20),
                      if (vendedorProvider.listSolicitudes.isNotEmpty)
                        CustomOutlinedButton(
                            onPressed: () async {
                              final opt = await customDialog2(
                                  context,
                                  'Información',
                                  'Estas seguro que deseas enviar?',
                                  Icons.info_outline_rounded,
                                  Colors.blue);

                              if (opt) {
                                UtilView.buildShowDialog(context);
                                String resp =
                                    await vendedorProvider.generarProcesso();

                                await customDialog1(context,
                                    'Enhorabuena\nSolicitud realizada con exito\nNumero de\nseguimiento:$resp!');
                                isEquals = true;
                                setState(() {});
                                Navigator.of(context).pop();
                              }
                            },
                            color: Colors.blueGrey,
                            text: 'Generar Solicitud'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);

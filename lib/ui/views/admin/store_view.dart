// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/ui/dialog/devolucion/dialog_acep_canc.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/date_formatter.dart';
import 'package:devolucion_modulo/util/navbar.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';

import 'package:devolucion_modulo/datatables/follow2_datasource.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StoreView extends StatefulWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemsIg0063>(context, listen: false).getListItems();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsIg0063>(context);

    void selectDate(String cadena) async {
      DateTime fecha = UtilView.convertStringToDate(
          cadena == 'init' ? provider.txtInicio.text : provider.txtFin.text);
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: fecha,
          firstDate: DateTime(2023),
          lastDate: DateTime(2024),
          initialEntryMode: DatePickerEntryMode.input,
          //initialDatePickerMode: DatePickerMode.year,
          helpText: "Seleccionar Fecha",
          errorInvalidText: "Rango fecha [2023-2024]");
      if (fecha.isAfter(picked!)) {
        setState(() {
          switch (cadena) {
            case 'init':
              provider.txtInicio.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            case 'finish':
              provider.txtFin.text = UtilView.dateFormatDMY(picked.toString());
              break;
            default:
          }
        });
      }
    }

    return Container(
      color: const Color.fromARGB(128, 164, 166, 168),
      child: Column(
        children: [
          Navbar(listW: [
            if (provider.permisos.substring(4, 5) == "C")
              CustomIconBtn(
                  onPressed: () async {
                    UtilView.buildShowDialog(context);
                    final op = await dialogAcepCanc(
                        context,
                        "Generar Lote Devolución",
                        SizedBox(
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 5),
                                child: Text("Rango fecha",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextFormField(
                                        controller: provider.txtInicio,
                                        decoration: CustomInputs
                                            .boxInputDecorationDatePicker(
                                                labelText: 'Inicio',
                                                fc: () => selectDate('init')),
                                        inputFormatters: [DateFormatter()],
                                        onChanged: (value) {},
                                        onTap: () {
                                          provider.txtInicio.selection =
                                              TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: provider
                                                      .txtInicio.text.length);
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextFormField(
                                        controller: provider.txtFin,
                                        decoration: CustomInputs
                                            .boxInputDecorationDatePicker(
                                                labelText: 'Fin',
                                                fc: () => selectDate('finish')),
                                        inputFormatters: [DateFormatter()],
                                        onTap: () {
                                          provider.txtFin.selection =
                                              TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: provider
                                                      .txtFin.text.length);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 5),
                                child: Text("Observación",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: provider.txtObs,
                                  decoration: CustomInputs.boxInputDecoration2(
                                      hint: 'Ingresar Observación',
                                      icon: Icons.menu_open_sharp),
                                  onTap: () {
                                    provider.txtObs.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            provider.txtObs.text.length);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'(^[A-Za-z ]*$)')),
                                    LengthLimitingTextInputFormatter(150),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icons.list,
                        Colors.blueGrey);
                    if (op) {
                      String x = await provider.createBatchReturn();
                      Navigator.of(context).pop();
                      if (x != "") {
                        customDialog1(context, x);
                      }
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  color: Colors.blueGrey,
                  msj: "Generar lote",
                  icon: Icons.assignment_rounded),
            CustomIconBtn(
                onPressed: () async => await provider.getListItems(),
                color: Colors.blueGrey,
                msj: "Recargar",
                icon: Icons.refresh_outlined),
            CustomIconBtn(
                onPressed: () =>
                    NavigationService.replaceTo(Flurorouter.menuRoute),
                color: Colors.blueGrey,
                msj: "Atras",
                icon: Icons.exit_to_app_outlined)
          ], titulo: "SEGUIMIENTO DE SOLICITUDES "),
          SizedBox(
            height: MediaQuery.of(context).size.height - 220,
            child: Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: Colors.blueGrey,
                      filterIconColor: Colors.black,
                      filterIconHoverColor: Colors.white),
                  child: SfDataGrid(
                      columnWidthMode: ColumnWidthMode.none,
                      headerRowHeight: 35,
                      rowHeight: 35,
                      allowFiltering: true,
                      source: Follow2DTS(context, provider),
                      columns: _buildDataGridForSize(context))),
            ),
          ),
        ],
      ),
    );
  }
}

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = [];

  if (Responsive.isTablet(context) || Responsive.isMobile(context)) {
    list = [
      GridColumn(
        columnName: '1-solicitud',
        allowFiltering: false,
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('SOLICITUD',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '2-fechaemision',
        allowFiltering: false,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('F.EMISION',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '3-documento',
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('DOCUMENTO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '4-vendedor',
        columnWidthMode: ColumnWidthMode.fill,
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('VENDEDOR',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '5-acciones',
        allowFiltering: false,
        //columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ACCIONES',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '9-estado',
        allowFiltering: false,
        //columnWidthMode: ColumnWidthMode.fitByColumnName,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ESTADO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  } else {
    list = [
      GridColumn(
        columnName: '1-solicitud',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('SOLICITUD',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '2-fechaemision',
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('F.EMISION',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '3-clase',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('CLASE',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '4-pv',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('PV',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '5-tp',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('TP',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '6-documento',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            filterMode: FilterMode.checkboxFilter,
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('DOCUMENTO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '7.cliente',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('CLIENTE',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '8-vendedor',
        columnWidthMode: ColumnWidthMode.fill,
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            filterMode: FilterMode.checkboxFilter,
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.centerLeft,
          child: Text('VENDEDOR',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '9-items',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ITEMS',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '10-estado',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            filterMode: FilterMode.checkboxFilter,
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ESTADO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '11-detalle',
        //columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('DETALLE',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '12-transporte',
        //columnWidthMode: ColumnWidthMode.fitByColumnName,
        width: Responsive.isDesktop(context) ? 110 : 80,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('TRANSPORTE',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '13-historial',
        //columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('HISTORIAL',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '14-anul',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ANULAR',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  }

  return list;
}

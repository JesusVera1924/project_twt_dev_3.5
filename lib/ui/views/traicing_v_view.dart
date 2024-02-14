import 'package:devolucion_modulo/datatables/follow3_datasource.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/util/navbar.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TraicingVendedorView extends StatefulWidget {
  const TraicingVendedorView({Key? key}) : super(key: key);

  @override
  State<TraicingVendedorView> createState() => _TraicingViewState();
}

class _TraicingViewState extends State<TraicingVendedorView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemsIg0063>(context, listen: false).getListItemsVendedor();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsIg0063>(context);
    return Container(
      color: const Color.fromARGB(128, 164, 166, 168),
      child: Column(
        children: [
          Navbar(listW: [
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
                      source: Follow3DTS(context, provider),
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
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
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
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
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
        columnName: '6-documento',
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('DOCUMENTO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '9-items',
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('#',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '10-estado',
        allowFiltering: false,
        columnWidthMode: ColumnWidthMode.fitByColumnName,
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
        columnWidthMode: ColumnWidthMode.fitByColumnName,
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
        columnName: '12-ncredito',
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
          child: Text('N°CREDITO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  } else {
    list = [
      GridColumn(
        columnName: '1-solicitud',
        width: 110,
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('NUMERO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '2-fechaemision',
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        filterPopupMenuOptions: const FilterPopupMenuOptions(
            canShowSortingOptions: false,
            showColumnName: false,
            canShowClearFilterOption: false),
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('F.EMISION',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '3-pv',
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('VEN',
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
        columnName: '8-cliente',
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
          child: Text('CLIENTE',
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
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('ESTADO',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
      GridColumn(
        columnName: '12-ncredito',
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
          child: Text('N°CREDITO',
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
    ];
  }

  return list;
}

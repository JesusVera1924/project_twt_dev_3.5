import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/navbar.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devolucion_modulo/datatables/approval_admin_datasource.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:devolucion_modulo/ui/dialog/dialog_criterio/custom_dialog_num.dart';
import 'package:devolucion_modulo/util/validation.dart';
import 'package:provider/provider.dart';
import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ApprovalView extends StatefulWidget {
  const ApprovalView({Key? key}) : super(key: key);

  @override
  State<ApprovalView> createState() => _ApprovalViewState();
}

class _ApprovalViewState extends State<ApprovalView> {
  Validation inspector = Validation();

  @override
  void initState() {
    super.initState();
    Provider.of<ItemsProvider>(context, listen: false).getListItems();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsProvider>(context);
    return Container(
      color: const Color.fromARGB(128, 164, 166, 168),
      child: Column(
        children: [
          Navbar(listW: [
            CustomIconBtn(
                onPressed: () async => await provider.getRenew(),
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
          Card(
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
                    source: ApprovalAdminDataSource(context, provider),
                    columns: _buildDataGridForSize(context))),
          ),
        ],
      ),
    );
  }
}

List<GridColumn> _buildDataGridForSize(BuildContext context) {
  List<GridColumn> list = [];

  if (Responsive.isTablet(context)) {
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
        columnName: '3-pv',
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
        columnName: '4-tp',
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
        columnName: '5-documento',
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
        columnName: '6.cliente',
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
        columnName: '7-vendedor',
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
        columnName: '8-items',
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
        columnName: '9',
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
        columnName: '10',
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
        columnName: '11',
        //columnWidthMode: ColumnWidthMode.fitByColumnName,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          //width: Responsive.isDesktop(context) ? 100 : 80,
          alignment: Alignment.center,
          child: Text('AUTORIZAR',
              style: CustomLabels.h11, overflow: TextOverflow.ellipsis),
        ),
      ),
    ];
  }

  return list;
}

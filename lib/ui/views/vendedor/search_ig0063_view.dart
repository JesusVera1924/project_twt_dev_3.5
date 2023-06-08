import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devolucion_modulo/datatables/ig0063_datasource.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:devolucion_modulo/ui/dialog/dialog_criterio/custom_dialog_num.dart';
import 'package:devolucion_modulo/util/validation.dart';
import 'package:provider/provider.dart';
import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';

class SearchIg0063View extends StatefulWidget {
  const SearchIg0063View({Key? key}) : super(key: key);

  @override
  _SearchIg0063ViewState createState() => _SearchIg0063ViewState();
}

class _SearchIg0063ViewState extends State<SearchIg0063View> {
  Validation inspector = Validation();

  @override
  void initState() {
    super.initState();
    Provider.of<ItemsIg0063>(context, listen: false).getListItems();
  }

  @override
  Widget build(BuildContext context) {
    final providerIg0063 = Provider.of<ItemsIg0063>(context);
    return Container(
      color: Color(0xCC232d37),
      child: Container(
        margin: EdgeInsets.all(10),
        child: PaginatedDataTable(
          columnSpacing: 40,
          columns: [
            DataColumn(
                label: Text(
                  'Solicitud'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Numero de solicitud"),
            DataColumn(
                label: Text(
                  'F.emision'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Fecha que se realizo la solicitud"),
            DataColumn(
                label: Text(
                  'PV'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Punto de venta"),
            DataColumn(
                label: Text(
                  'Tp'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Tipo de factura"),
            DataColumn(
                label: Text(
                  'Documento'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Numero de factura"),
            DataColumn(
                label: Text(
                  'Cliente'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Numero de factura"),
            DataColumn(
                label: Expanded(
                  child: Text(
                    'Vendedor'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                numeric: false,
                tooltip: "Numero de factura"),
            DataColumn(
                label: Text(
                  'Items'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: true,
                tooltip: "Ítems registrados a devolver"),
            DataColumn(
                label: Text(
                  'transporte'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false),
            DataColumn(
                label: Text(
                  'Detalle'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Estado de la solicitud"),
            DataColumn(
                label: Text(
                  'estado'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Detalle de solicitud"),
          ],
          source:
              Ig0063DTS(providerIg0063.itemsCliente, context, providerIg0063),
          header: Text(
            'Seguimiento de Solicitudes'.toUpperCase(),
            maxLines: 2,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400, fontSize: 25),
          ),
          rowsPerPage: PaginatedDataTable.defaultRowsPerPage / 2 as int,
          actions: [
            CustomIconBtn(
                onPressed: () async {
                  Provider.of<ItemsProvider>(context, listen: false).getRenew();
                  final respuesta = await customDialogNum(
                      context,
                      'Criterio',
                      r'^(?:\+|-)?\d+$',
                      9,
                      Icons.receipt_long_outlined,
                      Colors.blueGrey);
//cambiar esto POR SFGRID DE FILTRO
                  if (respuesta != "") {
                    /*  Provider.of<ItemsProvider>(context, listen: false)
                        .getListNumero(inspector.relleno(respuesta, 9)); */
                  }
                },
                color: Colors.blueGrey,
                msj: "Numero de documento",
                icon: Icons.receipt_long_outlined),
            CustomIconBtn(
                onPressed: () async {
                  Provider.of<ItemsProvider>(context, listen: false).getRenew();
                  /* Provider.of<ItemsProvider>(context, listen: false)
                      .getListItems(); */
                },
                color: Colors.blueGrey,
                msj: "Recargar",
                icon: Icons.refresh_outlined),
            CustomIconBtn(
                onPressed: () {
                  NavigationService.replaceTo(Flurorouter.menuRoute);
                },
                color: Colors.blueGrey,
                msj: "Atras",
                icon: Icons.exit_to_app_outlined),
          ],
        ),
      ),
    );
  }
}

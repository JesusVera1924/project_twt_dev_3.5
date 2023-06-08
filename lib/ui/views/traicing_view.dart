import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/datatables/follow_datasource.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';
import 'package:devolucion_modulo/provider/items_provider.dart';

class TraicingView extends StatefulWidget {
  const TraicingView({Key? key}) : super(key: key);

  @override
  _TraicingViewState createState() => _TraicingViewState();
}

class _TraicingViewState extends State<TraicingView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemsProvider>(context, listen: false).getItemsClient();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemsProvider>(context).itemsCliente;

    if (items.length == 0) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              'No tiene ninguna solicitud realizada',
              style: CustomLabels.h6,
            )
          ],
        ),
      );
    }

    return Container(
      color: Color(0xCC232d37),
      child: Container(
        margin: EdgeInsets.all(10),
        child: PaginatedDataTable(
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
                  'Vendedor'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Codigo del vendedor"),
            DataColumn(
                label: Text(
                  'Nombre vendedor'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false),
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
                  'Estado'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Estado de la solicitud"),
            DataColumn(
                label: Text(
                  'ver'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Detalle de ítems"),
          ],
          source: FollowDTS(items, context),
          header: Text(
            'Seguimiento de Solicitudes'.toUpperCase(),
            maxLines: 2,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400, fontSize: 25),
          ),
          rowsPerPage: 5,
          actions: [
            CustomIconBtn(
                onPressed: () =>
                    NavigationService.replaceTo(Flurorouter.menuRoute),
                msj: 'Regresar',
                color: Color(0xFFEE376E),
                icon: Icons.exit_to_app_outlined)
          ],
        ),
      ),
    );
  }
}

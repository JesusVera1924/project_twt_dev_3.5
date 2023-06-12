import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devolucion_modulo/datatables/credit_admin_datasource.dart';

import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:provider/provider.dart';

class CreditAdmView extends StatefulWidget {
  const CreditAdmView({Key? key}) : super(key: key);

  @override
  _CreditAdmViewState createState() => _CreditAdmViewState();
}

class _CreditAdmViewState extends State<CreditAdmView> {
  String permiss = "";
  @override
  void initState() {
    super.initState();
    Provider.of<CreditsProvider>(context, listen: false).getData();
    Provider.of<CreditsProvider>(context, listen: false).getListVendedor();
    permiss = LocalStorage.prefs.getString('permiss')!;
  }

  @override
  Widget build(BuildContext context) {
    final listCliente = Provider.of<CreditsProvider>(context).listTemp;
    return Container(
      color: const Color(0xCC232d37),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: PaginatedDataTable(
          columnSpacing: 35,
          // initialFirstRowIndex: PaginatedDataTable.defaultRowsPerPage,
          columns: const [
            DataColumn(
                label: Text(
                  'SOLICITUD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Numero de solicitud"),
            DataColumn(
                label: Text(
                  'F.EMISION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false,
                tooltip: "Fecha que se realizo la solicitud"),
            DataColumn(
                label: Text(
                  'IDENTIFICACÍON',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false),
            DataColumn(
                label: Text(
                  'NOMBRE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                numeric: false),
            DataColumn(
                label: Icon(Icons.person, color: Colors.indigo),
                numeric: false,
                tooltip: "Datos del cliente"),
            DataColumn(
                label:
                    Icon(Icons.maps_home_work_outlined, color: Colors.indigo),
                numeric: false,
                tooltip: "Datos del negocio"),
            DataColumn(
                label: Icon(Icons.contacts_outlined, color: Colors.indigo),
                numeric: false,
                tooltip: "Contactos de referencia"),
            DataColumn(
                label:
                    Icon(Icons.account_balance_outlined, color: Colors.indigo),
                numeric: false,
                tooltip: "Bancos de referencia"),
            DataColumn(
                label: Icon(Icons.margin_outlined, color: Colors.indigo),
                numeric: false,
                tooltip: "Comerciales de referencia"),
            DataColumn(
                label: Icon(Icons.location_city_outlined, color: Colors.indigo),
                numeric: false,
                tooltip: "Propiedades de referencia"),
            DataColumn(
                label: Icon(Icons.people_outline_rounded, color: Colors.indigo),
                numeric: false,
                tooltip: "Familiares de referencia"),
            DataColumn(
                label: Icon(Icons.sentiment_satisfied_outlined,
                    color: Colors.green),
                numeric: false,
                tooltip: "Aprobar solicitud"),
            DataColumn(
                label: Icon(Icons.sentiment_very_dissatisfied_outlined,
                    color: Colors.red),
                numeric: false,
                tooltip: "Rechazar Solicitud"),
            DataColumn(
                label: Icon(Icons.assignment_returned_outlined,
                    color: Colors.blue),
                numeric: false,
                tooltip: "PDF"),
            DataColumn(
                label: Icon(Icons.assignment_outlined, color: Colors.indigo),
                numeric: false,
                tooltip: "Documentación"),
          ],
          source: CreditAdminDTS(listCliente, context, permiss),
          header: Text(
            'Seguimiento de Solicitudes'.toUpperCase(),
            maxLines: 2,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400, fontSize: 25),
          ),
          rowsPerPage: 5,
          actions: [
            CustomIconBtn(
                onPressed: () {
                  Provider.of<CreditsProvider>(context, listen: false)
                      .getFiltro("P");
                },
                color: Color(0xD9E14E47),
                msj: 'Solicitud pendientes',
                icon: Icons.local_parking_rounded),
            CustomIconBtn(
                onPressed: () {
                  Provider.of<CreditsProvider>(context, listen: false)
                      .getFiltro("A");
                },
                color: Color(0xD955BB96),
                msj: 'Solicitud procesadas',
                icon: Icons.add_task),
            CustomIconBtn(
                onPressed: () {
                  Provider.of<CreditsProvider>(context, listen: false)
                      .getFill();
                },
                color: Color(0xD94B8BA9),
                msj: 'Todas las solicitudes',
                icon: Icons.assignment),
            CustomIconBtn(
                onPressed: () {
                  NavigationService.replaceTo(Flurorouter.menuRoute);
                },
                color: Colors.blueGrey,
                msj: 'Regresar',
                icon: Icons.exit_to_app_outlined),
          ],
        ),
      ),
    );
  }
}

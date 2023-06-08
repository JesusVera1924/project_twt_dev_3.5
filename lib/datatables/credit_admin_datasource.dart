import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/services/notifications_service.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_approval.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_banco.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_cliente.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_comercial.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_contacto.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_familiar.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_file.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_negocio.dart';
import 'package:devolucion_modulo/ui/dialog/credit/dialog_patrimonio.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/create_file_web.dart';
import 'package:provider/provider.dart';

class CreditAdminDTS extends DataTableSource {
  final List<Mg0031> listCliente;
  final BuildContext context;
  final returnapi = ReturnApi();
  final String permiss;

  CreditAdminDTS(this.listCliente, this.context, this.permiss);

  @override
  DataRow getRow(int index) {
    final myprovider = Provider.of<CreditsProvider>(context, listen: false);
    myprovider.getContinente();
    final item = this.listCliente[index];

    return DataRow.byIndex(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return Colors.black26.withOpacity(0.10);
          if (item.stsSdc == "A") return Colors.green.withOpacity(0.10);
          if (item.stsSdc == "R") return Colors.red.withOpacity(0.10);
          return Colors.white12;
        }),
        index: index,
        cells: [
          DataCell(Text(item.numSdc)),
          DataCell(Text(item.fecSdc)),
          DataCell(Text(item.secNic)),
          DataCell(Text(item.nomRef)),
          DataCell(InkWell(
            onTap: () {
              if (item.stsSdc != "R" && permiss.contains("M"))
                dialogCliente(context, item, myprovider);
            },
            child: Tooltip(
                message: "Datos del Cliente",
                child: Icon(Icons.edit,
                    color:
                        permiss.contains("M") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () {
              if (item.stsSdc != "R" && permiss.contains("M"))
                dialogNegocio(context, item, myprovider);
            },
            child: Tooltip(
                message: "Datos del Negocio",
                child: Icon(Icons.edit,
                    color:
                        permiss.contains("M") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () {
              if (item.stsSdc != "R" && permiss.contains("M"))
                dialogFamiliar(context, item, myprovider);
            },
            child: Tooltip(
                message: "Referencia de contactos",
                child: Icon(Icons.edit,
                    color:
                        permiss.contains("M") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () {
              if (item.stsSdc != "R" && permiss.contains("M"))
                dialogBanco(context, item, myprovider);
            },
            child: Tooltip(
                message: "Datos de Bancos",
                child: Icon(Icons.edit,
                    color:
                        permiss.contains("M") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () async {
              if (item.stsSdc != "R" && permiss.contains("M"))
                await dialogComercial(context, item, myprovider);
            },
            child: Tooltip(
                message: "Datos Comerciales",
                child: Icon(Icons.edit,
                    color:
                        permiss.contains("M") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () {
              if (item.stsSdc != "R" && permiss.contains("M"))
                dialogPatrimonio(context, item, myprovider);
            },
            child: Tooltip(
                message: "Patrimonio",
                child: Icon(Icons.edit,
                    color:
                        permiss.contains("M") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () {
              if (item.stsSdc != "R" && permiss.contains("M"))
                dialogFamilias(context, item, myprovider);
            },
            child: Tooltip(
                message: "Contactos Familiares",
                child: Icon(Icons.edit,
                    color:
                        permiss.contains("M") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () async {
              if (item.stsSdc != "R" &&
                  item.stsSdc != "A" &&
                  permiss.contains("A")) {
                final opt = await dialogApproval(
                    context, myprovider, item, myprovider.listFormPago);

                if (opt == "1")
                  NotificationsService.showSnackbar('Solicitud / Aprobada');
              }
            },
            child: Tooltip(
                message: "Aprobar Solicitud",
                child: Icon(Icons.check_circle_outline,
                    color:
                        permiss.contains("A") ? Colors.green : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () async {
              if (item.stsSdc != "R" &&
                  item.stsSdc != "A" &&
                  permiss.contains("X")) {
                final dialog = AlertDialog(
                  backgroundColor: Color(0xff092042),
                  title: Text(
                    '¿Está seguro?',
                    style: CustomLabels.h10,
                  ),
                  content: Text(
                    '¿Se rechazara definitivamente?',
                    style: CustomLabels.h10,
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        'No',
                        style: CustomLabels.h3,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Si,Rechazar',
                        style: CustomLabels.h3,
                      ),
                      onPressed: () async {
                        await myprovider.saveRechazo(item);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
                showDialog(context: context, builder: (_) => dialog);
              }
            },
            child: Tooltip(
                message: "Rechazar Solicitud",
                child: Icon(Icons.cancel_outlined,
                    color:
                        permiss.contains("X") ? Colors.red : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () async {
              if (permiss.contains("I")) {
                final fileWeb = CreateFileWeb();

                final pro = myprovider.listProv
                    .singleWhere((e) => e.codOcg == item.estRef);
                final ciu = myprovider.listCiud
                    .singleWhere((e) => e.codOcg == item.ciuRef);

                fileWeb.fillFormFields(true, item, ciu.nomOcg, pro.nomOcg);
              }
            },
            child: Tooltip(
                message: "Descargar Solicitud",
                child: Icon(Icons.file_download_outlined,
                    color:
                        permiss.contains("I") ? Colors.blue : Colors.black38)),
          )),
          DataCell(InkWell(
            onTap: () async {
              if (permiss.contains("I")) dialogFile(context, item);
            },
            child: Tooltip(
                message: "Lista de archivos",
                child: Icon(Icons.file_present_outlined,
                    color:
                        permiss.contains("I") ? Colors.blue : Colors.black38)),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listCliente.length;

  @override
  int get selectedRowCount => 0;
}

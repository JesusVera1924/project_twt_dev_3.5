import 'dart:convert';

import 'package:devolucion_modulo/util/util_view.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/email.dart';
import 'package:devolucion_modulo/models/ig0063.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_bodega.dart';

class CreateFilePdf {
  final double _fontSize1 = 6;
  ReturnApi api = ReturnApi();
  List<List<String>> bodyTable = [];

  Future<void> pdf4(List<Ig0063> cadena, String nombre, String destinatario,
      String copias) async {
    //VARIABLES
/*     final netImage = await networkImage(
        'https://ci3.googleusercontent.com/proxy/aMKVP5SvujxE2xUHVOV29wXnlhB5qaoElrRXLrDzRX8UiEcBpi_wig4FYu6SLf4vlyon6y6tUfDmbKmkehr0EiQLiNBeEmU3mNkMsDOe4ke3A0NqxPGARj8Y5nwidC4MN3o2TXb-eVHdDx0Z95w_mbMsxFRpKUGerlI=s0-d-e1-ft');
 */
    List<pw.Widget> widgets = [];

    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    const tableHeaders = [
      "CODIGO",
      "PRODUCTO",
      "CANTIDAD",
      "MARCA",
      "FACTURA",
      "TIPO",
      "ESTADO"
    ];

    addBodyTable(cadena);

    //CREACION TABLA
    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Table.fromTextArray(
            cellPadding: const pw.EdgeInsets.all(1),
            border: pw.TableBorder.all(width: 0.5),
            cellAlignments: {
              12: pw.Alignment.centerRight,
              13: pw.Alignment.centerRight,
              14: pw.Alignment.centerRight,
              15: pw.Alignment.centerRight,
              16: pw.Alignment.centerRight
            },
            cellAlignment: pw.Alignment.centerLeft,
            cellStyle:
                const pw.TextStyle(color: PdfColors.grey900, fontSize: 4.5),
            headerAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 4.5,
                fontWeight: pw.FontWeight.bold),
            headers: List<String>.generate(
                tableHeaders.length, (col) => tableHeaders[col].toUpperCase()),
            data: bodyTable),
      ),
    );
    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Text(
                    "Las presente devoluciones o garantías se encuentran receptadas por nuestro departamento.Haciendo cita a los puntos número 6,7 de nuestras politicas:",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.black)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Text(
                    "No 6: El departamento de devoluciones de Cojapán, tendra un plazo de 8 dias laborables, para responder al cliente si las devoluciones fueroon aceptadas (emision de nota de credito) o si fue rechazada (envio de una notificacion al cliente).",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.black)),
              ),
              pw.Text(
                  "No 7: ''El departamento de devoluciones de Cojapán, tendrá un plazo de 30 días, para realizar todo el proceso de gestión, validación y respuesta hacia nuestros clientes'', sobre las devoluciones que sean por reclamos de garantías o fallos de fábrica.",
                  style: pw.TextStyle(
                      fontSize: _fontSize1, color: PdfColors.black)),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Text(
                    "Por este mismo medio podrá obtener la resolución de su proceso de devoluciones y garantías.\n\nSi alguna autoparte no es aceptada en cualquiera de los dos casos porque incumplen algún punto dentro de nuestras políticas, la autoparte será enviada con su respectivo informe donde se argumenta los motivos de no aceptación",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.black)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Text(
                    "Por favor, no dude en contactarnos si necesita ampliar la información sobre nuestra resolución.\nGracias por su atención.\nAtentamente,\nDpto. Devoluciones y Garantías\nCojapan ",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.black)),
              ),
            ]),
      ),
    );

    //AGREGAR NUEVA PÁGINA
    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 10, marginLeft: 10, marginRight: 10, marginTop: 10),
      orientation: pw.PageOrientation.natural,
      header: (context) {
        return pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Column(children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text("",
                      style: pw.TextStyle(
                          fontSize: _fontSize1, color: PdfColors.black)),
                  pw.Text(
                    'Pág ${context.pageNumber}/${context.pagesCount}',
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.grey500),
                  ),
                ],
              ),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text("",
                          style: pw.TextStyle(
                              fontSize: _fontSize1, color: PdfColors.black)),
                      /* pw.Image(netImage, width: 40, height: 40), */
                      pw.Text("RESPUESTA AUTOMÁTICA PARA CLIENTES",
                          style: pw.TextStyle(
                              fontSize: _fontSize1, color: PdfColors.black)),
                      pw.Text("",
                          style: pw.TextStyle(
                              fontSize: _fontSize1, color: PdfColors.black))
                    ],
                  )),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                      "Fecha: ${DateTime.now()}\nGuayaquil, Ecuador\nEstimado Cliente: $nombre\nReciba un cordial saludo de parte del departamento de Devolucion y Garantias de COJAPAN\nPor medio del presente nos dirigimos a ustedes para informarle el estado en que se encuentran sus devoluciones o garantías:",
                      style: pw.TextStyle(
                        fontSize: _fontSize1,
                        color: PdfColors.black,
                      )),
                ],
              ),
            ]));
      },
      build: (context) => widgets,
    ));

    final bytes = await doc.save();

//VENDEDOR Y CLIENTE
    var email = Email(
        to: destinatario,
        cc: copias,
        subject: "Solicitud de devolución",
        body: "Generacion de solicitud de solicitud",
        attachment: ["${UtilView.firmaDocumento()}.pdf", base64.encode(bytes)]);
    api.sendEmailReport(email);
    //FileSaveHelper.saveDocument(name: 'LecturaCP.pdf', pdf: doc);
  }

  Future<void> pdf5(List<DetailBodega> cadena) async {
    //VARIABLES
    final netImage = await networkImage(
        'https://res.cloudinary.com/diasdh7zo/image/upload/v1683323355/cojapan_m6oltf.png');

    List<pw.Widget> widgets = [];

    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    const tableHeaders = [
      "CODIGO",
      "PRODUCTO",
      "CANTIDAD",
      "MARCA",
      "FACTURA",
      "TIPO",
      "ESTADO",
      "COMENTARIOS"
    ];

    addBodyTable2(cadena);

    //CREACION TABLA
    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Table.fromTextArray(
            cellPadding: const pw.EdgeInsets.all(1),
            border: pw.TableBorder.all(width: 0.5),
            cellAlignments: {
              12: pw.Alignment.centerRight,
              13: pw.Alignment.centerRight,
              14: pw.Alignment.centerRight,
              15: pw.Alignment.centerRight,
              16: pw.Alignment.centerRight
            },
            cellAlignment: pw.Alignment.centerLeft,
            cellStyle:
                const pw.TextStyle(color: PdfColors.grey900, fontSize: 4.5),
            headerAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 4.5,
                fontWeight: pw.FontWeight.bold),
            headers: List<String>.generate(
                tableHeaders.length, (col) => tableHeaders[col].toUpperCase()),
            data: bodyTable),
      ),
    );

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Text(
                    "Las presentes devoluciones o garantías han sido aceptadas o rechazadas de acuerdo a nuestras políticas contempladas en nuestra página web",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.black)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Text(
                    "https://www.cojapan.com/devoluciones/#formularios",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.blue)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Text(
                    "Las auto partes no aceptadas serán enviadas con su respectivo informe donde se argumenta los motivos de no aceptación",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.black)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Text(
                    "Por favor, no dude en contactarnos si necesita ampliar la información sobre nuestra resolución.\nGracias por su atención.\nAtentamente,\nDpto. Devoluciones y Garantías\nCojapan ",
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.black)),
              ),
            ]),
      ),
    );

    //AGREGAR NUEVA PÁGINA
    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 10, marginLeft: 10, marginRight: 10, marginTop: 10),
      orientation: pw.PageOrientation.natural,
      header: (context) {
        return pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Column(children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text("",
                      style: pw.TextStyle(
                          fontSize: _fontSize1, color: PdfColors.black)),
                  pw.Text(
                    'Pág ${context.pageNumber}/${context.pagesCount}',
                    style: pw.TextStyle(
                        fontSize: _fontSize1, color: PdfColors.grey500),
                  ),
                ],
              ),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(netImage, width: 40, height: 40),
                      pw.Text("RESPUESTA AUTOMÁTICA PARA CLIENTES",
                          style: pw.TextStyle(
                              fontSize: _fontSize1, color: PdfColors.black)),
                      pw.Text("",
                          style: pw.TextStyle(
                              fontSize: _fontSize1, color: PdfColors.black))
                    ],
                  )),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                      "Fecha: ${UtilView.convertDateToString()}\nGuayaquil, Ecuador\nEstimado Cliente: JESUS ALBERTO VERA PARRA\nReciba un cordial saludo de parte del departamento de Devolucion y Garantias de COJAPAN\nPor medio del presente nos dirigimos a ustedes para informarle el estado en que se encuentran sus devoluciones o garantías:",
                      style: pw.TextStyle(
                        fontSize: _fontSize1,
                        color: PdfColors.black,
                      )),
                ],
              ),
            ]));
      },
      build: (context) => widgets,
    ));
    final bytes = await doc.save();

    var email = Email(
        to: "jesusvera19_24@hotmail.com",
        cc: "joelparra65@gmail.com,desarrollodark@gmail.com",
        subject: "Solicitud de devolución",
        body: "Generacion de solicitud de solicitud",
        attachment: ["reporte.pdf", base64.encode(bytes)]);
    api.sendEmailReport(email);
  }

  addBodyTable(List<Ig0063> cadena) {
    for (var element in cadena) {
      bodyTable.add(<String>[
        element.codEmp,
        element.obsSdv == "" ? "" : element.obsSdv.split("::")[0],
        "${element.canB91}",
        element.obsSdv == "" ? "" : element.obsSdv.split("::")[1],
        element.numMov,
        element.clsMdm == "D" ? "Devolución" : "Garantía",
        element.stsSdv == "P" ? "En revision" : "Procesado"
      ]);
    }
  }

  addBodyTable2(List<DetailBodega> cadena) {
    for (var element in cadena) {
      bodyTable.add(<String>[
        element.item.codEmp,
        element.item.obsSdv == "" ? "" : element.item.obsSdv.split("::")[0],
        "${element.item.canB91}",
        element.item.obsSdv == "" ? "" : element.item.obsSdv.split("::")[1],
        element.item.numMov,
        element.item.clsMdm == "D" ? "Devolución" : "Garantía",
        UtilView.optionEstado(element),
        element.item.obsMrm == "" ? "" : element.item.obsMrm.split(":")[2]
      ]);
    }
  }
}

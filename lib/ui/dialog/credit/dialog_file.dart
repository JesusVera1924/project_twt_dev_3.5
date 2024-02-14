import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/save_file_web.dart';

Future<String> dialogFile(BuildContext context, Mg0031 obj) async {
  String respuesta = "";

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            //backgroundColor: Color(0xff092042),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              'Documentos adjuntados',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (obj.dpnCcp == "1")
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () async {
                        final resp = await FileSaveHelper.createLaunchFile(
                            "CED-${obj.numSdc}-${obj.ntsSdc}.pdf");
                        print(resp);
                      },
                      child: Text(
                        "CEDULA PERSONAL",
                        style: CustomLabels.h7.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                if (obj.dpnCrp == "1")
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () async {
                        final resp = await FileSaveHelper.createLaunchFile(
                            "RCP-${obj.numSdc}-${obj.ntsSdc}.pdf");
                        print(resp);
                      },
                      child: Text(
                        "RUC PERSONAL",
                        style: CustomLabels.h7.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                if (obj.dpnCsb == "1")
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () async {
                        final resp = await FileSaveHelper.createLaunchFile(
                            "CSB-${obj.numSdc}-${obj.ntsSdc}.pdf");
                        print(resp);
                      },
                      child: Text(
                        "SERVICIOS BASICOS",
                        style: CustomLabels.h7.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                if (obj.dpjCre == "1")
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () async {
                        final resp = await FileSaveHelper.createLaunchFile(
                            "CRE-${obj.numSdc}-${obj.ntsSdc}.pdf");
                        print(resp);
                      },
                      child: Text(
                        "RUC EMPRESA",
                        style: CustomLabels.h7.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                if (obj.dpjCge == "1")
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () async {
                        final resp = await FileSaveHelper.createLaunchFile(
                            "CRL-${obj.numSdc}-${obj.ntsSdc}.pdf");
                        print(resp);
                      },
                      child: Text(
                        "CEDULA REP.LEGAL",
                        style: CustomLabels.h7.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                if (obj.dpjCne == "1")
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () async {
                        final resp = await FileSaveHelper.createLaunchFile(
                            "NRL-${obj.numSdc}-${obj.ntsSdc}.pdf");
                        print(resp);
                      },
                      child: Text(
                        "NOMBRAMIENTO REP.LEGAL",
                        style: CustomLabels.h7.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                if (obj.dpnCpf == "1")
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () async {
                        final resp = await FileSaveHelper.createLaunchFile(
                            "CPF-${obj.numSdc}-${obj.ntsSdc}.pdf");
                        print(resp);
                      },
                      child: Text(
                        "PERMISOS DE FUNCIONAMIENTO",
                        style: CustomLabels.h7.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.green.withOpacity(0.03);
                    }
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Salir', style: CustomLabels.h4)),
            ],
          );
        });
      });
  return respuesta;
}

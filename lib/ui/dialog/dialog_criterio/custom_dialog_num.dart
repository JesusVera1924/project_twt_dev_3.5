import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/inputs/input_dialog.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

Future<String> customDialogNum(BuildContext context, String title, String regx,
    int length, IconData iconData, Color color) async {
  String respuesta = "";
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            children: [
              Icon(
                iconData,
                color: color,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: CustomLabels.h5,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 120,
            child: InputDialog(
                controller: TextEditingController(),
                hint: 'Criterio de busqueda'.toUpperCase(),
                regx: regx,
                length: length,
                onEditingComplete: () {
                  Navigator.of(context).pop();
                },
                onChanged: (value) {
                  respuesta = value;
                }),
          ),
          actions: [
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.greenAccent;
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar', style: CustomLabels.h4)),
          ],
        );
      });
  return respuesta;
}

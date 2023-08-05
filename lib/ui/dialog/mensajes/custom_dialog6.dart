import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

Future<String> customDialog6(BuildContext context, String title, String body,
    IconData iconData, Color color) async {
  String resp = "0";
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            children: [
              Icon(iconData, color: color, size: 26),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(title, style: CustomLabels.h5),
              ),
            ],
          ),
          content: Text(body, style: CustomLabels.h2),
          actions: [
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.greenAccent.withOpacity(0.08);
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  resp = "1";
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Si', style: CustomLabels.h4),
                )),
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.redAccent.withOpacity(0.08);
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  resp = "2";
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('No', style: CustomLabels.h4),
                )),
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.redAccent.withOpacity(0.08);
                  }
                  return Colors.transparent;
                })),
                onPressed: () {
                  resp = "0";
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cancelar', style: CustomLabels.h4),
                )),
          ],
        );
      });
  return resp;
}

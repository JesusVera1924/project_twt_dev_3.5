import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

Future customDialog1(BuildContext context, String body) async {
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: CustomLabels.h2,
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
}

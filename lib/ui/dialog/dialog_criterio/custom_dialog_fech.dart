import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/inputs/input_bod.dart';

import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

Future<String> customDialogFech(BuildContext context, String title, String regx,
    IconData iconData, Color color) async {
  TextEditingController desde = TextEditingController();
  TextEditingController hasta = TextEditingController();
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
            height: 60,
            child: Column(
              children: [
                const Row(
                  children: [
                    SizedBox(width: 120, child: Text('Desde')),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(width: 120, child: Text('Hasta')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: InputBod(
                          formatt: true,
                          length: 20,
                          hint: 'dd/mm/aaaa'.toUpperCase(),
                          regx: regx,
                          onEditingComplete: () {
                            Navigator.of(context).pop();
                          },
                          controller: desde,
                          onChanged: (value) {}),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 120,
                      child: InputBod(
                          formatt: true,
                          length: 20,
                          hint: 'dd/mm/aaaa'.toUpperCase(),
                          regx: regx,
                          onEditingComplete: () {
                            Navigator.of(context).pop();
                          },
                          controller: hasta,
                          onChanged: (value) {}),
                    ),
                  ],
                ),
              ],
            ),
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
  return "${desde.text}::${hasta.text}";
}

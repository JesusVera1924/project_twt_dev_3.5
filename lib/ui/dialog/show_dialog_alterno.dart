import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/alterno.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

Future showDialogAlternos(BuildContext context, List<Alterno> lista) async {
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            'ALTERNOS',
            textAlign: TextAlign.center,
          ),
          content: lista.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final _fieldValue in lista) ...[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Text(
                            _fieldValue.codAlt,
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                      const Divider(thickness: 1)
                    ]
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sin información',
                        textAlign: TextAlign.center,
                        style: CustomLabels.h9,
                      ),
                    ),
                    const Icon(Icons.not_interested_sharp,
                        size: 40, color: Colors.redAccent)
                  ],
                ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              label: Text(
                'Aceptar',
                style: CustomLabels.h3.copyWith(color: Colors.green),
              ),
            ),
          ],
        );
      });
}

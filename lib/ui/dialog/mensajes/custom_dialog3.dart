import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/ig0062.dart';
import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';

Future customDialog3(BuildContext context, Ig0062 item) async {
  await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: const Text('Información'),
            content: const Text('Actualizar estado'),
            actions: [
              CustomFormButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Aceptar'),
              CustomFormButton(
                  color: Colors.red,
                  onPressed: () => Navigator.of(context).pop(),
                  text: 'Cancelar')
            ],
          );
        });
      });
}

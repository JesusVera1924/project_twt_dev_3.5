import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/cliente.dart';
import 'package:devolucion_modulo/provider/register_form_provider.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

Future showDialogClient(BuildContext context, List<Cliente> lista) async {
  String resp = "";
  final registerFormProvider =
      Provider.of<RegisterFormProvider>(context, listen: false);
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            //  backgroundColor: Color(0xFF8793B2),
            title: const Text('Seleccion un codigo de referencia'),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final _obj in lista) ...[
                  ListTile(
                    onTap: () {
                      registerFormProvider.codRef = _obj.codRef;
                      registerFormProvider.nomRef = _obj.nomRef;
                      resp = "1";
                      Navigator.pop(context);
                    },
                    dense: true,
                    minVerticalPadding: 12,
                    title: Text(_obj.nomAux == "" ? _obj.nomRef : _obj.nomAux,
                        style: CustomLabels.h6),
                    leading: const Icon(Icons.star_border),
                    subtitle: Text(_obj.codRef, style: CustomLabels.h7),
                  )
                ]
              ],
            ));
      });

  return resp;
}

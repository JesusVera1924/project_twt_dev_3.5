import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/provider/forget_provider.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

Future<String> showDialogUsers(
    BuildContext context, List<Usuario> lista) async {
  String resp = "";
  final registerFormProvider =
      Provider.of<ForgetProvider>(context, listen: false);
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
                      registerFormProvider.nomRef.text = _obj.nomUsr;
                      registerFormProvider.email.text = _obj.corUsr;
                      registerFormProvider.user = _obj;
                      resp = "1";
                      Navigator.pop(context);
                    },
                    dense: true,
                    minVerticalPadding: 12,
                    title: Text(_obj.nomUsr == "" ? _obj.codUsr : _obj.nomUsr,
                        style: CustomLabels.h6),
                    leading: const Icon(Icons.star_border),
                    subtitle: Text(_obj.ctaUsr, style: CustomLabels.h7),
                  )
                ]
              ],
            ));
      });

  return resp;
}
